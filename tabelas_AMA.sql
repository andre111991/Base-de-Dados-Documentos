CREATE DATABASE IF NOT EXISTS sistema_estacionamento;
USE sistema_estacionamento;

-- 1. Tabela Utilizador (Base para quase tudo)
CREATE TABLE Utilizador (
    id_utilizador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    tipo_utilizador VARCHAR(50)
);

-- 2. Tabela Vaga (Independente)
CREATE TABLE Vaga (
    id_vaga INT AUTO_INCREMENT PRIMARY KEY,
    andar INT NOT NULL,
    cor VARCHAR(45),
    letra VARCHAR(45),
    tipo VARCHAR(45),
    estado TINYINT(1) DEFAULT 0
);

-- 3. Tabela Veiculo (Depende do Utilizador)
CREATE TABLE Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_utilizador INT NOT NULL,
    matricula VARCHAR(20) NOT NULL,
    tipo_combustivel VARCHAR(30),
    CONSTRAINT fk_veiculo_utilizador FOREIGN KEY (id_utilizador) 
        REFERENCES Utilizador(id_utilizador) ON DELETE CASCADE
);

-- 4. Tabela Reserva (Depende de Utilizador, Veiculo e Vaga)
CREATE TABLE Reserva (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_utilizador INT NOT NULL,
    id_veiculo INT NOT NULL,
    id_vaga INT NOT NULL,
    data_hora_inicio DATETIME NOT NULL,
    data_hora_fim DATETIME,
    data_pagamento DATETIME,
    valor FLOAT,
    CONSTRAINT fk_reserva_utilizador FOREIGN KEY (id_utilizador) REFERENCES Utilizador(id_utilizador),
    CONSTRAINT fk_reserva_veiculo FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    CONSTRAINT fk_reserva_vaga FOREIGN KEY (id_vaga) REFERENCES Vaga(id_vaga)
);

-- 5. Tabela Carregamento (Depende de Veiculo e Vaga)
CREATE TABLE Carregamento (
    id_carregamento INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    id_vaga INT NOT NULL,
    data_hora_inicio DATETIME NOT NULL,
    data_hora_fim DATETIME,
    pago TINYINT(1) DEFAULT 0,
    CONSTRAINT fk_carregamento_veiculo FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    CONSTRAINT fk_carregamento_vaga FOREIGN KEY (id_vaga) REFERENCES Vaga(id_vaga)
);

-- 6. Tabela Carregador (Depende de Carregamento)
CREATE TABLE Carregador (
    id_carregador INT AUTO_INCREMENT PRIMARY KEY,
    id_carregamento INT NOT NULL,
    potencia FLOAT,
    CONSTRAINT fk_carregador_carregamento FOREIGN KEY (id_carregamento) 
        REFERENCES Carregamento(id_carregamento) ON DELETE CASCADE
);