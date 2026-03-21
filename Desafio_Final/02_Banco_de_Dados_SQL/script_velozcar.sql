DROP DATABASE IF EXISTS velozcar;

CREATE DATABASE velozcar;

USE velozcar;

CREATE TABLE cliente (
id_cliente INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
cpf VARCHAR(14) NOT NULL UNIQUE,
rg VARCHAR(20) NOT NULL,
data_nascimento DATE NOT NULL,
telefone VARCHAR(20) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
endereco VARCHAR(150) NOT NULL,
data_cadastro DATE NOT NULL
);

CREATE TABLE funcionario (
id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
cpf VARCHAR(14) NOT NULL UNIQUE,
cargo VARCHAR(50) NOT NULL,
telefone VARCHAR(20) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
endereco VARCHAR(150) NOT NULL,
data_admissao DATE NOT NULL,
salario DECIMAL(10,2) NOT NULL
);

CREATE TABLE categoria_veiculo (
id_categoria INT AUTO_INCREMENT PRIMARY KEY,
nome_categoria VARCHAR(50) NOT NULL,
descricao VARCHAR(150) NOT NULL,
tipo_combustivel VARCHAR(30) NOT NULL,
qtd_passageiros INT NOT NULL,
valor_caucao DECIMAL(10,2) NOT NULL,
quilometragem_limite INT NOT NULL,
ar_condicionado VARCHAR(3) NOT NULL,
status_categoria VARCHAR(20) NOT NULL
);

CREATE TABLE veiculo (
id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
placa VARCHAR(10) NOT NULL UNIQUE,
chassi VARCHAR(30) NOT NULL UNIQUE,
modelo VARCHAR(50) NOT NULL,
marca VARCHAR(50) NOT NULL,
cor VARCHAR(30) NOT NULL,
ano_fabricacao INT NOT NULL,
valor_diaria DECIMAL(10,2) NOT NULL,
status VARCHAR(20) NOT NULL,
id_categoria INT NOT NULL,
FOREIGN KEY (id_categoria) REFERENCES categoria_veiculo(id_categoria)
);

CREATE TABLE aluguel (
id_aluguel INT AUTO_INCREMENT PRIMARY KEY,
data_inicio DATE NOT NULL,
data_fim DATE,
data_prevista_devolucao DATE NOT NULL,
valor_total DECIMAL(10,2) NOT NULL,
status VARCHAR(20) NOT NULL,
local_retirada VARCHAR(100) NOT NULL,
local_devolucao VARCHAR(100) NOT NULL,
id_cliente INT NOT NULL,
id_funcionario INT NOT NULL,
id_veiculo INT NOT NULL,
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario),
FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo)
);

CREATE TABLE pagamento (
id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
valor_pagamento DECIMAL(10,2) NOT NULL,
data_pagamento DATE NOT NULL,
metodo VARCHAR(20) NOT NULL,
status VARCHAR(20) NOT NULL,
desconto DECIMAL(10,2) DEFAULT 0,
juros DECIMAL(10,2) DEFAULT 0,
codigo_transacao VARCHAR(50) NOT NULL,
observacao VARCHAR(150),
id_aluguel INT NOT NULL,
FOREIGN KEY (id_aluguel) REFERENCES aluguel(id_aluguel)
);

CREATE TABLE manutencao (
id_manutencao INT AUTO_INCREMENT PRIMARY KEY,
descricao_servico VARCHAR(150) NOT NULL,
custo DECIMAL(10,2) NOT NULL,
data_manutencao DATE NOT NULL,
responsavel VARCHAR(100) NOT NULL,
tipo_manutencao VARCHAR(50) NOT NULL,
status VARCHAR(20) NOT NULL,
quilometragem_veiculo INT NOT NULL,
observacao VARCHAR(150),
id_veiculo INT NOT NULL,
id_funcionario INT NOT NULL,
FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo),
FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);

CREATE TABLE seguro (
id_seguro INT AUTO_INCREMENT PRIMARY KEY,
nome_seguro VARCHAR(50) NOT NULL,
cobertura VARCHAR(150) NOT NULL,
valor_seguro DECIMAL(10,2) NOT NULL,
franquia DECIMAL(10,2) NOT NULL,
seguradora VARCHAR(100) NOT NULL,
telefone_seguradora VARCHAR(20) NOT NULL,
tipo_plano VARCHAR(30) NOT NULL,
status VARCHAR(20) NOT NULL
);

CREATE TABLE aluguel_seguro (
id_aluguel_seguro INT AUTO_INCREMENT PRIMARY KEY,
data_contratacao DATE NOT NULL,
valor_cobrado DECIMAL(10,2) NOT NULL,
status VARCHAR(20) NOT NULL,
observacao VARCHAR(150),
codigo_apolice VARCHAR(50) NOT NULL,
data_inicio_cobertura DATE NOT NULL,
data_fim_cobertura DATE NOT NULL,
tipo_cobranca VARCHAR(30) NOT NULL,
id_aluguel INT NOT NULL,
id_seguro INT NOT NULL,
FOREIGN KEY (id_aluguel) REFERENCES aluguel(id_aluguel),
FOREIGN KEY (id_seguro) REFERENCES seguro(id_seguro)
);

INSERT INTO cliente (nome, cpf, rg, data_nascimento, telefone, email, endereco, data_cadastro) VALUES
('João Silva', '111.111.111-11', 'MG123456', '1990-05-10', '83999990001', 'joao@email.com', 'Rua A, 100', '2026-01-10'),
('Maria Souza', '222.222.222-22', 'MG223456', '1988-08-12', '83999990002', 'maria@email.com', 'Rua B, 200', '2026-01-11'),
('Carlos Lima', '333.333.333-33', 'MG323456', '1995-02-15', '83999990003', 'carlos@email.com', 'Rua C, 300', '2026-01-12'),
('Ana Costa', '444.444.444-44', 'MG423456', '1992-11-20', '83999990004', 'ana@email.com', 'Rua D, 400', '2026-01-13'),
('Pedro Alves', '555.555.555-55', 'MG523456', '1985-07-30', '83999990005', 'pedro@email.com', 'Rua E, 500', '2026-01-14'),
('Juliana Rocha', '666.666.666-66', 'MG623456', '1998-04-25', '83999990006', 'juliana@email.com', 'Rua F, 600', '2026-01-15'),
('Lucas Mendes', '777.777.777-77', 'MG723456', '1991-09-14', '83999990007', 'lucas@email.com', 'Rua G, 700', '2026-01-16'),
('Fernanda Nunes', '888.888.888-88', 'MG823456', '1993-06-18', '83999990008', 'fernanda@email.com', 'Rua H, 800', '2026-01-17'),
('Rafael Gomes', '999.999.999-99', 'MG923456', '1987-03-22', '83999990009', 'rafael@email.com', 'Rua I, 900', '2026-01-18'),
('Paula Martins', '101.101.101-10', 'MG103456', '1996-12-05', '83999990010', 'paula@email.com', 'Rua J, 1000', '2026-01-19');

INSERT INTO funcionario (nome, cpf, cargo, telefone, email, endereco, data_admissao, salario) VALUES
('Marcos Pereira', '123.123.123-12', 'Atendente', '83988880001', 'marcos@velozcar.com', 'Av A, 10', '2024-02-01', 2500.00),
('Patricia Lima', '234.234.234-23', 'Gerente', '83988880002', 'patricia@velozcar.com', 'Av B, 20', '2023-05-10', 4500.00),
('Bruno Castro', '345.345.345-34', 'Atendente', '83988880003', 'bruno@velozcar.com', 'Av C, 30', '2024-03-15', 2500.00),
('Larissa Melo', '456.456.456-45', 'Financeiro', '83988880004', 'larissa@velozcar.com', 'Av D, 40', '2022-09-20', 3200.00),
('Thiago Santos', '567.567.567-56', 'Supervisor', '83988880005', 'thiago@velozcar.com', 'Av E, 50', '2021-11-01', 3800.00),
('Camila Duarte', '678.678.678-67', 'Atendente', '83988880006', 'camila@velozcar.com', 'Av F, 60', '2025-01-10', 2500.00),
('Felipe Araújo', '789.789.789-78', 'Mecânico', '83988880007', 'felipe@velozcar.com', 'Av G, 70', '2023-07-12', 3000.00),
('Amanda Vieira', '890.890.890-89', 'Financeiro', '83988880008', 'amanda@velozcar.com', 'Av H, 80', '2024-08-18', 3200.00),
('Diego Oliveira', '901.901.901-90', 'Mecânico', '83988880009', 'diego@velozcar.com', 'Av I, 90', '2022-12-01', 3000.00),
('Renata Barros', '012.012.012-01', 'Gerente', '83988880010', 'renata@velozcar.com', 'Av J, 100', '2020-04-05', 4700.00);

INSERT INTO categoria_veiculo (nome_categoria, descricao, tipo_combustivel, qtd_passageiros, valor_caucao, quilometragem_limite, ar_condicionado, status_categoria) VALUES
('Econômico', 'Carros compactos e econômicos', 'Flex', 5, 1000.00, 300, 'Sim', 'Ativa'),
('Sedan', 'Carros sedan para viagens e conforto', 'Flex', 5, 1500.00, 400, 'Sim', 'Ativa'),
('SUV', 'Utilitários esportivos', 'Diesel', 7, 2500.00, 500, 'Sim', 'Ativa'),
('Executivo', 'Veículos premium', 'Gasolina', 5, 3000.00, 450, 'Sim', 'Ativa'),
('Utilitário', 'Veículos para carga leve', 'Diesel', 2, 2000.00, 350, 'Não', 'Ativa'),
('Hatch', 'Veículos hatch compactos', 'Flex', 5, 1200.00, 320, 'Sim', 'Ativa'),
('Minivan', 'Veículos familiares', 'Flex', 7, 1800.00, 420, 'Sim', 'Ativa'),
('Pickup', 'Veículos de carga e misto', 'Diesel', 5, 2800.00, 380, 'Sim', 'Ativa'),
('Elétrico', 'Veículos sustentáveis', 'Elétrico', 5, 3500.00, 250, 'Sim', 'Ativa'),
('Luxo', 'Veículos de alto padrão', 'Gasolina', 5, 5000.00, 500, 'Sim', 'Ativa');

INSERT INTO veiculo (placa, chassi, modelo, marca, cor, ano_fabricacao, valor_diaria, status, id_categoria) VALUES
('QAA1A11', 'CHASSI00000000000001', 'Onix', 'Chevrolet', 'Branco', 2022, 120.00, 'Disponível', 1),
('QBB2B22', 'CHASSI00000000000002', 'HB20', 'Hyundai', 'Prata', 2021, 130.00, 'Alugado', 6),
('QCC3C33', 'CHASSI00000000000003', 'Corolla', 'Toyota', 'Preto', 2023, 220.00, 'Disponível', 2),
('QDD4D44', 'CHASSI00000000000004', 'Compass', 'Jeep', 'Cinza', 2022, 300.00, 'Manutenção', 3),
('QEE5E55', 'CHASSI00000000000005', 'Civic', 'Honda', 'Branco', 2020, 210.00, 'Disponível', 2),
('QFF6F66', 'CHASSI00000000000006', 'Toro', 'Fiat', 'Vermelho', 2021, 280.00, 'Alugado', 8),
('QGG7G77', 'CHASSI00000000000007', 'Kwid', 'Renault', 'Azul', 2024, 110.00, 'Disponível', 1),
('QHH8H88', 'CHASSI00000000000008', 'Tracker', 'Chevrolet', 'Preto', 2023, 260.00, 'Disponível', 3),
('QII9I99', 'CHASSI00000000000009', 'Model 3', 'Tesla', 'Branco', 2025, 450.00, 'Disponível', 9),
('QJJ0J00', 'CHASSI00000000000010', 'BMW 320i', 'BMW', 'Cinza', 2024, 500.00, 'Disponível', 10);

INSERT INTO aluguel (data_inicio, data_fim, data_prevista_devolucao, valor_total, status, local_retirada, local_devolucao, id_cliente, id_funcionario, id_veiculo) VALUES
('2026-02-01', '2026-02-05', '2026-02-05', 480.00, 'Finalizado', 'Loja Centro', 'Loja Centro', 1, 1, 1),
('2026-02-03', '2026-02-06', '2026-02-06', 390.00, 'Finalizado', 'Loja Sul', 'Loja Sul', 2, 2, 2),
('2026-02-05', NULL, '2026-02-10', 1100.00, 'Ativo', 'Loja Centro', 'Loja Norte', 3, 3, 3),
('2026-02-07', '2026-02-10', '2026-02-09', 900.00, 'Atrasado', 'Loja Norte', 'Loja Norte', 4, 4, 4),
('2026-02-10', '2026-02-12', '2026-02-12', 420.00, 'Finalizado', 'Loja Sul', 'Loja Sul', 5, 5, 5),
('2026-02-11', NULL, '2026-02-15', 1120.00, 'Ativo', 'Loja Centro', 'Loja Centro', 6, 6, 6),
('2026-02-12', '2026-02-14', '2026-02-14', 220.00, 'Finalizado', 'Loja Norte', 'Loja Norte', 7, 7, 7),
('2026-02-13', NULL, '2026-02-18', 1300.00, 'Ativo', 'Loja Sul', 'Loja Centro', 8, 8, 8),
('2026-02-14', '2026-02-16', '2026-02-16', 900.00, 'Finalizado', 'Loja Centro', 'Loja Sul', 9, 9, 9),
('2026-02-15', NULL, '2026-02-20', 1500.00, 'Ativo', 'Loja Norte', 'Loja Norte', 10, 10, 10);

INSERT INTO pagamento (valor_pagamento, data_pagamento, metodo, status, desconto, juros, codigo_transacao, observacao, id_aluguel) VALUES
(480.00, '2026-02-01', 'Pix', 'Concluído', 0, 0, 'TRX001', 'Pagamento integral', 1),
(390.00, '2026-02-03', 'Cartão', 'Concluído', 10.00, 0, 'TRX002', 'Desconto promocional', 2),
(500.00, '2026-02-05', 'Boleto', 'Pendente', 0, 0, 'TRX003', 'Entrada pendente', 3),
(900.00, '2026-02-07', 'Pix', 'Concluído', 0, 20.00, 'TRX004', 'Pagamento com atraso', 4),
(420.00, '2026-02-10', 'Cartão', 'Concluído', 0, 0, 'TRX005', 'Pagamento normal', 5),
(600.00, '2026-02-11', 'Pix', 'Pendente', 0, 0, 'TRX006', 'Pagamento parcial', 6),
(220.00, '2026-02-12', 'Boleto', 'Concluído', 0, 0, 'TRX007', 'Quitado', 7),
(650.00, '2026-02-13', 'Cartão', 'Pendente', 0, 0, 'TRX008', 'Primeira parcela', 8),
(900.00, '2026-02-14', 'Pix', 'Concluído', 0, 0, 'TRX009', 'Pagamento integral', 9),
(700.00, '2026-02-15', 'Cartão', 'Pendente', 0, 0, 'TRX010', 'Entrada inicial', 10);

INSERT INTO manutencao (descricao_servico, custo, data_manutencao, responsavel, tipo_manutencao, status, quilometragem_veiculo, observacao, id_veiculo, id_funcionario) VALUES
('Troca de óleo', 150.00, '2026-01-05', 'Felipe Araújo', 'Preventiva', 'Concluída', 15000, 'Revisão periódica', 1, 7),
('Alinhamento', 120.00, '2026-01-10', 'Diego Oliveira', 'Preventiva', 'Concluída', 18000, 'Veículo puxando para direita', 2, 9),
('Troca de pneus', 800.00, '2026-01-15', 'Felipe Araújo', 'Corretiva', 'Concluída', 30000, 'Pneus desgastados', 3, 7),
('Reparo no freio', 500.00, '2026-01-20', 'Diego Oliveira', 'Corretiva', 'Em andamento', 28000, 'Ruído ao frear', 4, 9),
('Revisão elétrica', 300.00, '2026-01-22', 'Felipe Araújo', 'Preventiva', 'Concluída', 22000, 'Checagem geral', 5, 7),
('Troca de bateria', 450.00, '2026-01-25', 'Diego Oliveira', 'Corretiva', 'Concluída', 25000, 'Bateria fraca', 6, 9),
('Balanceamento', 100.00, '2026-01-28', 'Felipe Araújo', 'Preventiva', 'Concluída', 12000, 'Manutenção periódica', 7, 7),
('Revisão geral', 900.00, '2026-02-01', 'Diego Oliveira', 'Preventiva', 'Em andamento', 35000, 'Checklist completo', 8, 9),
('Atualização de software', 250.00, '2026-02-03', 'Felipe Araújo', 'Preventiva', 'Concluída', 5000, 'Veículo elétrico', 9, 7),
('Polimento e revisão', 350.00, '2026-02-05', 'Diego Oliveira', 'Estética', 'Concluída', 8000, 'Preparação premium', 10, 9);

INSERT INTO seguro (nome_seguro, cobertura, valor_seguro, franquia, seguradora, telefone_seguradora, tipo_plano, status) VALUES
('Seguro Básico', 'Colisão parcial e roubo', 50.00, 1500.00, 'SeguraMais', '0800111111', 'Básico', 'Ativo'),
('Seguro Completo', 'Colisão total, roubo e terceiros', 90.00, 1000.00, 'ProtegeCar', '0800222222', 'Premium', 'Ativo'),
('Seguro Executivo', 'Cobertura total nacional', 120.00, 800.00, 'EliteSeg', '0800333333', 'Executivo', 'Ativo'),
('Seguro Econômico', 'Roubo e furto', 35.00, 1800.00, 'SeguraMais', '0800111111', 'Básico', 'Ativo'),
('Seguro Familiar', 'Cobertura ampla para viagens', 70.00, 1200.00, 'ProtegeCar', '0800222222', 'Intermediário', 'Ativo'),
('Seguro Pickup', 'Cobertura para utilitários', 85.00, 1400.00, 'CargaSafe', '0800444444', 'Especial', 'Ativo'),
('Seguro Elétrico', 'Cobertura para veículos elétricos', 130.00, 900.00, 'EcoSeg', '0800555555', 'Premium', 'Ativo'),
('Seguro Luxo', 'Cobertura premium de alto padrão', 160.00, 700.00, 'EliteSeg', '0800333333', 'Luxo', 'Ativo'),
('Seguro Viagem', 'Assistência 24h e colisão', 65.00, 1300.00, 'RoadHelp', '0800666666', 'Intermediário', 'Ativo'),
('Seguro Empresarial', 'Cobertura corporativa ampliada', 110.00, 1100.00, 'CorpSeg', '0800777777', 'Corporativo', 'Ativo');

INSERT INTO aluguel_seguro (data_contratacao, valor_cobrado, status, observacao, codigo_apolice, data_inicio_cobertura, data_fim_cobertura, tipo_cobranca, id_aluguel, id_seguro) VALUES
('2026-02-01', 50.00, 'Ativo', 'Cobertura básica', 'APL001', '2026-02-01', '2026-02-05', 'Diária', 1, 1),
('2026-02-03', 90.00, 'Ativo', 'Cobertura completa', 'APL002', '2026-02-03', '2026-02-06', 'Diária', 2, 2),
('2026-02-05', 65.00, 'Ativo', 'Assistência viagem', 'APL003', '2026-02-05', '2026-02-10', 'Diária', 3, 9),
('2026-02-07', 120.00, 'Ativo', 'Executivo', 'APL004', '2026-02-07', '2026-02-09', 'Diária', 4, 3),
('2026-02-10', 35.00, 'Ativo', 'Cobertura econômica', 'APL005', '2026-02-10', '2026-02-12', 'Diária', 5, 4),
('2026-02-11', 85.00, 'Ativo', 'Plano pickup', 'APL006', '2026-02-11', '2026-02-15', 'Diária', 6, 6),
('2026-02-12', 50.00, 'Ativo', 'Plano básico', 'APL007', '2026-02-12', '2026-02-14', 'Diária', 7, 1),
('2026-02-13', 70.00, 'Ativo', 'Plano familiar', 'APL008', '2026-02-13', '2026-02-18', 'Diária', 8, 5),
('2026-02-14', 130.00, 'Ativo', 'Plano elétrico', 'APL009', '2026-02-14', '2026-02-16', 'Diária', 9, 7),
('2026-02-15', 160.00, 'Ativo', 'Plano luxo', 'APL010', '2026-02-15', '2026-02-20', 'Diária', 10, 8);

UPDATE veiculo
SET status = 'Disponível'
WHERE id_veiculo = 4;

UPDATE pagamento
SET status = 'Concluído'
WHERE id_pagamento = 3;

SELECT YEAR(data_cadastro) AS ano, COUNT(*) AS total_clientes
FROM cliente
GROUP BY YEAR(data_cadastro);

SELECT endereco, COUNT(*) AS total
FROM cliente
GROUP BY endereco;

SELECT cargo, COUNT(*) AS total_funcionarios
FROM funcionario
GROUP BY cargo;

SELECT cargo, AVG(salario) AS media_salarial
FROM funcionario
GROUP BY cargo;

SELECT tipo_combustivel, COUNT(*) AS total
FROM categoria_veiculo
GROUP BY tipo_combustivel;

SELECT status_categoria, AVG(valor_caucao) AS media_caucao
FROM categoria_veiculo
GROUP BY status_categoria;

SELECT status, COUNT(*) AS total_veiculos
FROM veiculo
GROUP BY status;

SELECT marca, AVG(valor_diaria) AS media_diaria
FROM veiculo
GROUP BY marca;

SELECT status, COUNT(*) AS total_alugueis
FROM aluguel
GROUP BY status;

SELECT id_funcionario, SUM(valor_total) AS total_movimentado
FROM aluguel
GROUP BY id_funcionario;

SELECT status, COUNT(*) AS total_pagamentos
FROM pagamento
GROUP BY status;

SELECT metodo, SUM(valor_pagamento) AS total_recebido
FROM pagamento
GROUP BY metodo;

SELECT tipo_manutencao, COUNT(*) AS total
FROM manutencao
GROUP BY tipo_manutencao;

SELECT status, SUM(custo) AS custo_total
FROM manutencao
GROUP BY status;

SELECT tipo_plano, COUNT(*) AS total
FROM seguro
GROUP BY tipo_plano;

SELECT seguradora, AVG(valor_seguro) AS media_valor
FROM seguro
GROUP BY seguradora;

SELECT status, COUNT(*) AS total
FROM aluguel_seguro
GROUP BY status;

SELECT tipo_cobranca, SUM(valor_cobrado) AS total_cobrado
FROM aluguel_seguro
GROUP BY tipo_cobranca;

SELECT a.id_aluguel, c.nome AS cliente, v.modelo AS veiculo, a.status, a.valor_total
FROM aluguel a
INNER JOIN cliente c ON a.id_cliente = c.id_cliente
INNER JOIN veiculo v ON a.id_veiculo = v.id_veiculo;

SELECT p.id_pagamento, c.nome AS cliente, p.valor_pagamento, p.metodo, p.status
FROM pagamento p
INNER JOIN aluguel a ON p.id_aluguel = a.id_aluguel
INNER JOIN cliente c ON a.id_cliente = c.id_cliente;

SELECT m.id_manutencao, v.modelo AS veiculo, f.nome AS funcionario, m.tipo_manutencao, m.custo
FROM manutencao m
INNER JOIN veiculo v ON m.id_veiculo = v.id_veiculo
INNER JOIN funcionario f ON m.id_funcionario = f.id_funcionario;

SELECT v.modelo, cat.nome_categoria, v.status, v.valor_diaria
FROM veiculo v
INNER JOIN categoria_veiculo cat ON v.id_categoria = cat.id_categoria;

SELECT a.id_aluguel, s.nome_seguro, alseg.valor_cobrado
FROM aluguel_seguro alseg
INNER JOIN aluguel a ON alseg.id_aluguel = a.id_aluguel
INNER JOIN seguro s ON alseg.id_seguro = s.id_seguro;