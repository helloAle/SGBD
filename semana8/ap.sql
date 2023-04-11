--Curso de Engenharia de Software - UniEVANGÉLICA 
--Disciplina de Sisetmas Gerenciadores de Banco de Dados
--Dev: Alexandre  
--11/04/2023

-- Iniciar a transação
BEGIN TRANSACTION;

-- Inserir um novo planeta
INSERT INTO Planeta (idPlaneta, NoPlaneta, NuHabitantes) VALUES (1, 'Tatooine', '200000');

-- Inserir uma nova espécie e relacionar ao planeta inserido
INSERT INTO Especie (idEspecie, NoEspecie, idPlaneta) VALUES (1, 'Jawa', 1);

-- Inserir um novo indivíduo e relacionar ao planeta e espécie inseridos
INSERT INTO Individuo (idIndividuo, RG, NoIndividuo, idPlaneta, idEspecie) VALUES (1, '1234567', 'Jawa 1', 1, 1);

-- Finalizar a transação
COMMIT;
