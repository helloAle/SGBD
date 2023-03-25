SELECT i.NoIndividuo, e.NoEspecie, p.NoPlaneta
FROM Individuo i
INNER JOIN Especie e ON i.idEspecie = e.idEspecie
INNER JOIN Planeta p ON i.idPlaneta = p.idPlaneta;

SELECT i.NoIndividuo, s.idSabres
FROM Individuo i
LEFT JOIN UsuarioForca uf ON i.idIndividuo = uf.idIndividuo
LEFT JOIN Sabres s ON uf.idUsuarioForca = s.idUsuarioForca;

SELECT p.NoPlaneta, f.NoFaccao
FROM Planeta p
INNER JOIN ForceOrganization fo ON p.idPlaneta = fo.idUsuarioForca
INNER JOIN Faccao f ON fo.idFaccao = f.idFaccao;
