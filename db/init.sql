
CREATE SCHEMA IF NOT EXISTS Food_Travel;
USE Food_Travel;

-- Tabela Cliente
CREATE TABLE IF NOT EXISTS cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    cpf NUMERIC(11) UNIQUE,
    nome VARCHAR(30) NOT NULL,
    telefone VARCHAR(13) NOT NULL,
    email VARCHAR(30),
    senha VARCHAR(80) NOT NULL
);

-- Tabela Restaurante
CREATE TABLE IF NOT EXISTS restaurante (
    id_restaurante INT AUTO_INCREMENT PRIMARY KEY,
    CNPJ NUMERIC(16) UNIQUE,
    nome_do_restaurante VARCHAR(30) NOT NULL,
    descricao VARCHAR(250),
    categoria VARCHAR(50),
    endereco_restaurante VARCHAR(60) NOT NULL,
    horario_funcionamento TIME NOT NULL
);

-- Tabela Categoria_Produto
CREATE TABLE IF NOT EXISTS categoria_produto (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(30)
);

-- Tabela Produto
CREATE TABLE IF NOT EXISTS produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(30) NOT NULL,
    descricao VARCHAR(250) NOT NULL,
    preco VARCHAR(10) NOT NULL,
    id_restaurante INT,
    id_categoria INT,
    FOREIGN KEY (id_restaurante) REFERENCES restaurante(id_restaurante),
    FOREIGN KEY (id_categoria) REFERENCES categoria_produto(id_categoria)
);

-- Tabela Pedido
CREATE TABLE IF NOT EXISTS pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_restaurante INT,
    data_hora_pedido DATETIME NOT NULL,
    status_pedido VARCHAR(60) NOT NULL,
    total_pedido NUMERIC(10,2) NOT NULL,
    forma_pagamento VARCHAR(50) NOT NULL,
    troco VARCHAR(5) NULL,
    delivery VARCHAR(3) NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_restaurante) REFERENCES restaurante(id_restaurante)
);

-- Tabela Endereco_Cliente
CREATE TABLE IF NOT EXISTS endereco_cliente (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_pedido INT,
    rua VARCHAR(50) NOT NULL,
    numero INT,
    bairro VARCHAR(50),
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

-- Tabela Item_Pedido
CREATE TABLE IF NOT EXISTS item_pedido (
    id_item_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario NUMERIC(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- Tabela Avaliacoes
CREATE TABLE IF NOT EXISTS avaliacoes (
    id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_restaurante INT NOT NULL,
    comentarios VARCHAR(250),
    estrelas INT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_restaurante) REFERENCES restaurante(id_restaurante)
);

-- Tabela Funcionario
CREATE TABLE IF NOT EXISTS funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome_funcionario VARCHAR(50) NOT NULL,
    cargo VARCHAR(30),
    data_contratacao DATE,
    salario NUMERIC(10,2),
    id_restaurante INT,
    FOREIGN KEY (id_restaurante) REFERENCES restaurante(id_restaurante)
);


INSERT INTO restaurante (nome_do_restaurante, CNPJ, descricao, categoria, endereco_restaurante, horario_funcionamento) VALUES
('Food Travel Restaurante', 10125057000128, 'Onde a arte da culinária se encontra com o luxo.', 'Variada', 'Av. Brasil, 123', '09:00:00');

INSERT INTO categoria_produto (nome_categoria) VALUES
('Hamburgueres'), ('Pizzas'), ('Drinks'), ('Sobremesas');

INSERT INTO produto (nome_produto, descricao, preco, id_restaurante, id_categoria) VALUES
('X-Tudo', 'Hambúrguer completo', '55.00', 1, 1),
('Pizza Cogumelo', 'Molho, mussarela, cogumelo', '65.00', 1, 2),
('Coquetel Morango', 'Vodka, morango, hortelã', '19.00', 1, 3);