-- 1. Criar a base de dados
CREATE DATABASE IF NOT EXISTS sistema_parqueamento;
USE sistema_parqueamento;

-- 2. Tabela Utilizador
CREATE TABLE Utilizador (
    id_utilizador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    tipo_utilizador VARCHAR(50)
);

-- 3. Tabela Vaga
CREATE TABLE Vaga (
    id_vaga INT AUTO_INCREMENT PRIMARY KEY,
    andar INT NOT NULL,
    tipo VARCHAR(20), -- normal/VE
    estado VARCHAR(20) -- livre/ocupada/reservada
);

-- 4. Tabela Veiculo (Relacionada com Utilizador)
CREATE TABLE Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_utilizador INT,
    matricula VARCHAR(20) UNIQUE NOT NULL,
    combustivel VARCHAR(30),
    FOREIGN KEY (id_utilizador) REFERENCES Utilizador(id_utilizador) ON DELETE SET NULL
);

-- 5. Tabela Reserva (Relacionada com Utilizador e Vaga)
CREATE TABLE Reserva (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_utilizador INT,
    id_vaga INT,
    data_hora_inicio DATETIME NOT NULL,
    data_hora_fim DATETIME,
    FOREIGN KEY (id_utilizador) REFERENCES Utilizador(id_utilizador),
    FOREIGN KEY (id_vaga) REFERENCES Vaga(id_vaga)
);

-- 6. Tabela Carregamento (Relacionada com Veiculo e Vaga)
CREATE TABLE Carregamento (
    id_carregamento INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT,
    id_vaga INT,
    tempo_carregamento TIME,
    energia_consumida DECIMAL(10,2),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    FOREIGN KEY (id_vaga) REFERENCES Vaga(id_vaga)
);

-- 7. Tabela Pagamento (Relacionada com Reserva)
CREATE TABLE Pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_reserva INT,
    valor DECIMAL(10,2) NOT NULL,
    metodo_pagamento VARCHAR(50),
    data_pagamento DATETIME,
    FOREIGN KEY (id_reserva) REFERENCES Reserva(id_reserva)
);

-- 8. Tabela Sensor (Relacionada com Vaga)
CREATE TABLE Sensor (
    id_sensor INT AUTO_INCREMENT PRIMARY KEY,
    id_vaga INT,
    tipo_sensor VARCHAR(50), -- ocupação/luz
    estado_sensor VARCHAR(50),
    FOREIGN KEY (id_vaga) REFERENCES Vaga(id_vaga)
);

-- 9. Tabela PainelSolar
CREATE TABLE PainelSolar (
    id_painel INT AUTO_INCREMENT PRIMARY KEY,
    potencia_gerada DECIMAL(10,2),
    eficiencia DECIMAL(5,2),
    data_registo DATE
);