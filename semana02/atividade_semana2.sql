CREATE TABLE Planeta (
    idPlaneta INT PRIMARY KEY,
    NoPlaneta VARCHAR(45),
    NuHabitantes VARCHAR(45)
);

CREATE TABLE Especie (
    idEspecie INT PRIMARY KEY,
    NoEspecie VARCHAR(45),
    idPlaneta INT,
    FOREIGN KEY (idPlaneta) REFERENCES Planeta(idPlaneta)
);

CREATE TABLE Individuo (
    idIndividuo INT PRIMARY KEY,
    RG VARCHAR(7),
    NoIndividuo VARCHAR(45),
    idPlaneta INT,
    idEspecie INT,
    FOREIGN KEY (idPlaneta) REFERENCES Planeta(idPlaneta),
    FOREIGN KEY (idEspecie) REFERENCES Especie(idEspecie)
);

CREATE TABLE UsuarioForca (
    idUsuarioForca INT PRIMARY KEY,
    NoUsuarioForca VARCHAR(45),
    idIndividuo INT,
    FOREIGN KEY (idIndividuo) REFERENCES Individuo(idIndividuo)
);

CREATE TABLE Sabres (
    idSabres INT PRIMARY KEY,
    idCor INT,
    idForceOrganization INT,
    isUsuarioForca BOOLEAN,
    FOREIGN KEY (idForceOrganization) REFERENCES ForceOrganization(idForceOrganization),
    FOREIGN KEY (idUsuarioForca) REFERENCES UsuarioForca(idUsuarioForca)
);

CREATE TABLE FaccaoIndividuo (
    idIndividuo INT,
    idFaccao INT,
    idFaccaoIndividuo INT,
    DtRegistro DATE,
    PRIMARY KEY (idIndividuo, idFaccao),
    FOREIGN KEY (idIndividuo) REFERENCES Individuo(idIndividuo),
    FOREIGN KEY (idFaccao) REFERENCES Faccao(idFaccao)
);

CREATE TABLE Faccao (
    idFaccao INT PRIMARY KEY,
    NuMembros VARCHAR(45),
    NoFaccao VARCHAR(45)
);

CREATE TABLE ForceOrganization (
    idForceOrganization INT PRIMARY KEY,
    NoForceOrganization VARCHAR(45),
    NuMembros VARCHAR(45),
    idFaccao INT,
    idUsuarioForca INT,
    FOREIGN KEY (idFaccao) REFERENCES Faccao(idFaccao),
    FOREIGN KEY (idUsuarioForca) REFERENCES UsuarioForca(idUsuarioForca)
);
