/*
Curso de Engenharia de Software - UniEVANGÉLICA
Disciplina de Sistemas Gerenciadores de Banco de Dados
Dev: Alexandre Silva Oliveira
DATA: 15/05/2023
*/

-- Criação das tabelas

-- Tabela que armazena informações dos consultórios
CREATE TABLE consultorios
(
    id_consultorio INT PRIMARY KEY, -- Identificador único do consultório
    nome VARCHAR(50), -- Nome do consultório
    localizacao VARCHAR(50) -- Localização do consultório
);

-- Tabela que armazena informações dos profissionais de saúde
CREATE TABLE profissionais
(
    id_profissional INT PRIMARY KEY, -- Identificador único do profissional
    nome VARCHAR(50), -- Nome do profissional
    id_especialidade INT, -- Identificador da especialidade do profissional
    registro_medicina VARCHAR(50), -- Número de registro no conselho de medicina
    id_consultorio INT, -- Identificador do consultório onde o profissional atende
    FOREIGN KEY (id_especialidade) REFERENCES especialidade(id), -- Chave estrangeira para a tabela de especialidades
    FOREIGN KEY (id_consultorio) REFERENCES consultorios(id_consultorio) -- Chave estrangeira para a tabela de consultórios
);

-- Tabela que armazena informações dos pacientes
CREATE TABLE pacientes
(
    id_paciente INT PRIMARY KEY, -- Identificador único do paciente
    nome VARCHAR(50), -- Nome do paciente
    data_nascimento DATE, -- Data de nascimento do paciente
    cartao_convenio VARCHAR(50) -- Número do cartão de convênio do paciente
);

-- Tabela que armazena informações dos agendamentos de consultas
CREATE TABLE agendamentos
(
    id_agendamento INT PRIMARY KEY, -- Identificador único do agendamento
    data_hora DATETIME, -- Data e hora do agendamento
    id_paciente INT, -- Identificador do paciente agendado
    id_profissional INT, -- Identificador do profissional responsável pelo atendimento
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente), -- Chave estrangeira para a tabela de pacientes
    FOREIGN KEY (id_profissional) REFERENCES profissionais(id_profissional) -- Chave estrangeira para a tabela de profissionais
);

-- Tabela que armazena informações sobre as alterações nos agendamentos
CREATE TABLE auditoriaagendamentos
(
    id_auditoria INT PRIMARY KEY, -- Identificador único do registro de auditoria
    id_agendamento INT, -- Identificador do agendamento que foi modificado
    data_hora DATETIME -- Data e hora da modificação
);

-- Trigger que é disparada toda vez que um agendamento é inserido, atualizado ou excluído
CREATE TRIGGER tr_auditagendamentos ON agendamentos after
    UPDATE, INSERT, DELETE AS
BEGIN
    DECLARE @id_agendamento INT;
    SELECT @id_agendamento = id_agendamento FROM inserted;

    INSERT INTO auditoriaagendamentos
    (
        id_agendamento,
        data_hora
    )
    VALUES
    (
        @id_agendamento,
        Getdate()
    );
END;

-- Stored procedure para facilitar a inserção de um novo agendamento, verificando a disponibilidade do profissional e garantindo que não haja conflito de horários
CREATE PROCEDURE Sp_inseriragendamento
    @data_hora DATETIME,
    @id_paciente INT,
    @id_profissional INT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM agendamentos
        WHERE id_profissional = @id_profissional
        AND data_hora = @data_hora
    )
    BEGIN
        RAISERROR('O profissional já possui um agendamento neste horário.', 16, 1);
        RETURN;
    END;

    INSERT INTO agendamentos
    (
        data_hora,
        id_paciente,
        id_profissional
    )
    VALUES
    (
        @data_hora,
        @id_paciente,
        @id_profissional
    );
END;

-- Função que calcula a idade dos pacientes a partir de suas datas de nascimento
CREATE FUNCTION Fn_calcularidade (@data_nascimento DATE)
RETURNS INT AS
BEGIN
    DECLARE @idade INT;
    SET @idade = DATEDIFF(YEAR, @data_nascimento, GETDATE());
    IF MONTH(@data_nascimento) > MONTH(GETDATE())
    OR
    (
        MONTH(@data_nascimento) = MONTH(GETDATE())
        AND
        DAY(@data_nascimento) > DAY(GETDATE())
    )
    BEGIN
        SET @idade = @idade - 1;
    END;
    RETURN @idade;
END;

-- View que lista todos os agendamentos com informações detalhadas sobre paciente, profissional e consultório
CREATE VIEW vw_listaagendamentos AS
SELECT
    a.id_agendamento,
    a.data_hora,
    p.nome AS nome_paciente,
    pr.nome AS nome_profissional,
    e.nome AS nome_especialidade,
    c.nome AS nome_consultorio,
    c.localizacao
FROM
    agendamentos a
    INNER JOIN pacientes p ON a.id_paciente = p.id_paciente
    INNER JOIN profissionais pr ON a.id_profissional = pr.id_profissional
    INNER JOIN consultorios c ON pr.id_consultorio = c.id_consultorio
    INNER JOIN especialidade e ON pr.id_especialidade = e.id;

-- Criação de logins e usuários com suas respectivas permissões

CREATE LOGIN admin WITH PASSWORD = 'senha_admin';
CREATE LOGIN profissional WITH PASSWORD = 'senha_profissional';
CREATE LOGIN recepcionista WITH PASSWORD = 'senha_recepcionista';

CREATE USER admin FOR LOGIN admin;
CREATE USER profissional FOR LOGIN profissional;
CREATE USER recepcionista FOR LOGIN recepcionista;

GRANT SELECT, INSERT, UPDATE, DELETE ON agendamentos TO admin;
GRANT SELECT ON pacientes, consultorios, especialidade TO profissional;
GRANT SELECT, INSERT, UPDATE, DELETE ON agendamentos TO recepcionista;
GRANT SELECT ON pacientes, profissionais, consultorios, especialidade TO recepcionista;
