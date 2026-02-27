


CREATE DATABASE IF NOT EXISTS empresa_guincho;
USE empresa_guincho;


CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf_cnpj VARCHAR(18) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    endereco VARCHAR(150)
);


CREATE TABLE veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10) NOT NULL UNIQUE,
    modelo VARCHAR(50),
    marca VARCHAR(50),
    id_cliente INT NOT NULL,
    CONSTRAINT fk_veiculo_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE motorista (
    id_motorista INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnh VARCHAR(20) NOT NULL UNIQUE,
    telefone VARCHAR(20)
);


CREATE TABLE atendimento (
    id_atendimento INT AUTO_INCREMENT PRIMARY KEY,
    data_atendimento DATETIME NOT NULL,
    local_origem VARCHAR(150),
    local_destino VARCHAR(150),
    valor_servico DECIMAL(10,2) NOT NULL,
    id_cliente INT NOT NULL,
    id_veiculo INT NOT NULL,
    id_motorista INT NOT NULL,
    CONSTRAINT fk_atendimento_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_atendimento_veiculo
        FOREIGN KEY (id_veiculo)
        REFERENCES veiculo(id_veiculo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_atendimento_motorista
        FOREIGN KEY (id_motorista)
        REFERENCES motorista(id_motorista)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


CREATE INDEX idx_data_atendimento
ON atendimento(data_atendimento);

CREATE TABLE pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    forma_pagamento ENUM('Dinheiro','Pix','Cartao','Transferencia') NOT NULL,
    status_pagamento ENUM('Pendente','Pago','Cancelado') NOT NULL DEFAULT 'Pendente',
    data_pagamento DATE,
    id_atendimento INT UNIQUE,
    CONSTRAINT fk_pagamento_atendimento
        FOREIGN KEY (id_atendimento)
        REFERENCES atendimento(id_atendimento)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ============================================
-- FIM DO SCRIPT
-- ============================================
