

CREATE VIEW vw_relatorio AS
SELECT i.NoIndividuo, p.NoPlaneta, e.NoEspecie, f.NoFaccao, fo.NoForceOrganization
FROM Individuo i
INNER JOIN Planeta p ON i.idPlaneta = p.idPlaneta
INNER JOIN Especie e ON i.idEspecie = e.idEspecie
INNER JOIN FaccaoIndividuo fi ON i.idIndividuo = fi.idIndividuo
INNER JOIN Faccao f ON fi.idFaccao = f.idFaccao
INNER JOIN ForceOrganization fo ON fi.idFaccao = fo.idFaccao AND fi.idIndividuo = fo.idUsuarioForca
WHERE f.NoFaccao = 'Aliança Rebelde'
WITH CHECK OPTION;
