CREATE DATABASE IF NOT EXISTS parking_db;
USE parking_db;

-- 1. TABELA: Utilizador
CREATE TABLE IF NOT EXISTS Utilizador (
    id_utilizador INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    tipo_utilizador VARCHAR(50) NOT NULL DEFAULT 'cliente'
);

-- 2. TABELA: Vaga
CREATE TABLE IF NOT EXISTS Vaga (
    id_vaga INT AUTO_INCREMENT PRIMARY KEY,
    andar INT NOT NULL,
    cor VARCHAR(45),
    letra VARCHAR(45),
    tipo VARCHAR(45) NOT NULL, -- ex: 'eletrico', 'normal'
    estado TINYINT NOT NULL DEFAULT 0 -- 0 para livre, 1 para ocupada
);

-- 3. TABELA: Veiculo (CORRIGIDA: sem id_reserva)
CREATE TABLE IF NOT EXISTS Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_utilizador INT NOT NULL,
    matricula VARCHAR(20) NOT NULL UNIQUE,
    tipo_combustivel VARCHAR(30) NOT NULL,
    CONSTRAINT fk_veiculo_utilizador 
        FOREIGN KEY (id_utilizador) 
        REFERENCES Utilizador(id_utilizador) 
        ON DELETE CASCADE
);

-- 4. TABELA: Reserva (Gere a ligação de quem, qual carro e onde)
CREATE TABLE IF NOT EXISTS Reserva (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_utilizador INT NOT NULL,
    id_veiculo INT NOT NULL,
    id_vaga INT NOT NULL,
    data_hora_inicio DATETIME NOT NULL,
    data_hora_fim DATETIME NOT NULL,
    data_pagamento DATETIME,
    valor FLOAT DEFAULT 0.0,
    pago TINYINT DEFAULT 0,
    CONSTRAINT fk_reserva_utilizador 
        FOREIGN KEY (id_utilizador) 
        REFERENCES Utilizador(id_utilizador) ON DELETE CASCADE,
    CONSTRAINT fk_reserva_veiculo 
        FOREIGN KEY (id_veiculo) 
        REFERENCES Veiculo(id_veiculo) ON DELETE CASCADE,
    CONSTRAINT fk_reserva_vaga 
        FOREIGN KEY (id_vaga) 
        REFERENCES Vaga(id_vaga) ON DELETE CASCADE
);

-- 5. TABELA: Carregamento
CREATE TABLE IF NOT EXISTS Carregamento (
    id_carregamento INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    id_vaga INT NOT NULL,
    data_hora_inicio DATETIME NOT NULL,
    data_hora_fim DATETIME,
    pago TINYINT DEFAULT 0,
    valor FLOAT DEFAULT 0.0,
    CONSTRAINT fk_carregamento_veiculo 
        FOREIGN KEY (id_veiculo) 
        REFERENCES Veiculo(id_veiculo) ON DELETE CASCADE,
    CONSTRAINT fk_carregamento_vaga 
        FOREIGN KEY (id_vaga) 
        REFERENCES Vaga(id_vaga) ON DELETE CASCADE
);

-- 6. TABELA: Carregador
CREATE TABLE IF NOT EXISTS Carregador (
    id_carregador INT AUTO_INCREMENT PRIMARY KEY,
    id_carregamento INT,
    potencia FLOAT NOT NULL,
    CONSTRAINT fk_carregador_carregamento 
        FOREIGN KEY (id_carregamento) 
        REFERENCES Carregamento(id_carregamento) ON DELETE SET NULL
);