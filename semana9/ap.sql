--Curso de Engenharia de Software - UniEVANGÉLICA 
--Disciplina de Sisetmas Gerenciadores de Banco de Dados
--Dev: Alexandre  
--11/04/2023

--Crie uma view de relatório
CREATE VIEW RelatorioUsuarios AS
SELECT idIndividuo, RG, NoIndividuo, NoPlaneta, NoEspecie, NoUsuarioForca
FROM Individuo
JOIN Planeta ON Individuo.idPlaneta = Planeta.idPlaneta
JOIN Especie ON Individuo.idEspecie = Especie.idEspecie
JOIN UsuarioForca ON Individuo.idIndividuo = UsuarioForca.idIndividuo;


--Crie um usuário que só pode visualizar os dados na view criada
CREATE USER <nome_do_usuario> FOR LOGIN <nome_do_login>
GRANT SELECT ON <nome_da_view> TO <nome_do_usuario>


--Crie um usuário com permissão apenas de leitura em todo banco de dados
CREATE USER <nome_do_usuario> FOR LOGIN <nome_do_login>
GRANT SELECT ON ALL TABLES IN SCHEMA <nome_do_esquema> TO <nome_do_usuario>
