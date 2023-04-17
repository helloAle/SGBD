/* 
Curso de Engenharia de Software - UniEVANGÉLICA 
Disciplina de Sisetmas Gerenciadores de Banco de Dados
Dev: Alexandre Silva Oliveira
24/03/2023
*/

SELECT Individuo.NoIndividuo, Especie.NoEspecie 
FROM Individuo 
INNER JOIN Especie 
ON Individuo.idEspecie = Especie.idEspecie
WHERE Individuo.idPlaneta = 1;
