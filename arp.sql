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
    id_consultorio INT PRIMARY KEY,
    nome VARCHAR(50),
    localizacao VARCHAR(50)
);

-- Tabela que armazena informações dos profissionais de saúde
CREATE TABLE profissionais
(
    id_profissional INT PRIMARY KEY,
    nome VARCHAR(50),
    id_especialidade INT,
    registro_medicina VARCHAR(50),
    id_consultorio INT,
    FOREIGN KEY (id_especialidade) REFERENCES especialidade(id),
    FOREIGN KEY (id_consultorio) REFERENCES consultorios(id_consultorio)
);

-- Tabela que armazena informações dos pacientes
CREATE TABLE pacientes
(
    id_paciente INT PRIMARY KEY,
    nome VARCHAR(50),
    data_nascimento DATE,
    cartao_convenio VARCHAR(50)
);

-- Tabela que armazena informações dos agendamentos de consultas
CREATE TABLE agendamentos
(
    id_agendamento INT PRIMARY KEY,
    data_hora DATETIME,
    id_paciente INT,
    id_profissional INT,
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    FOREIGN KEY (id_profissional) REFERENCES profissionais(id_profissional)
);

-- Tabela que armazena informações sobre as alterações nos agendamentos
CREATE TABLE auditoriaagendamentos
(
    id_auditoria INT PRIMARY KEY,
    id_agendamento INT,
    data_hora DATETIME
);

-- Trigger que é disparada toda vez que um agendamento é inserido, atualizado ou excluído
CREATE TRIGGER tr_auditagendamentos ON agendamentos AFTER
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
        MONTH(@data_nascimento) = MONTH(GETDATE
        AND DAY(@data_nascimento) > DAY(GETDATE())
    )
    BEGIN
        SET @idade = @idade - 1;
    END;
    RETURN @idade;
END;
