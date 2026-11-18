-- =========================================================
-- StreamLab · Tema 1 — Assinaturas, Faturamento e Contas
-- Banco relacional (MySQL 8 / MariaDB)
-- =========================================================
DROP DATABASE IF EXISTS streamlab_assinaturas;
CREATE DATABASE streamlab_assinaturas DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE streamlab_assinaturas;
SET NAMES utf8mb4;

-- Planos oferecidos pela plataforma
CREATE TABLE plano (
  id_plano           INT AUTO_INCREMENT PRIMARY KEY,
  nome               VARCHAR(40)  NOT NULL UNIQUE,
  preco_mensal       DECIMAL(8,2) NOT NULL CHECK (preco_mensal >= 0),
  qualidade          ENUM('HD','Full HD','4K') NOT NULL,
  telas_simultaneas  TINYINT NOT NULL CHECK (telas_simultaneas BETWEEN 1 AND 6),
  com_anuncios       BOOLEAN NOT NULL DEFAULT FALSE
);

-- Conta do cliente (quem paga)
CREATE TABLE conta (
  id_conta    INT AUTO_INCREMENT PRIMARY KEY,
  nome        VARCHAR(80)  NOT NULL,
  email       VARCHAR(120) NOT NULL UNIQUE,
  pais        CHAR(2)      NOT NULL DEFAULT 'BR',
  criada_em   DATE         NOT NULL,
  status      ENUM('Ativa','Suspensa','Cancelada') NOT NULL DEFAULT 'Ativa'
);

-- Perfis dentro de uma conta (quem assiste)
CREATE TABLE perfil (
  id_perfil   INT AUTO_INCREMENT PRIMARY KEY,
  id_conta    INT NOT NULL,
  nome        VARCHAR(40) NOT NULL,
  infantil    BOOLEAN NOT NULL DEFAULT FALSE,
  FOREIGN KEY (id_conta) REFERENCES conta(id_conta) ON DELETE CASCADE
);

-- Assinatura: liga a conta a um plano num período
CREATE TABLE assinatura (
  id_assinatura   INT AUTO_INCREMENT PRIMARY KEY,
  id_conta        INT NOT NULL,
  id_plano        INT NOT NULL,
  inicio          DATE NOT NULL,
  fim             DATE NULL,
  status          ENUM('Ativa','Em atraso','Cancelada') NOT NULL DEFAULT 'Ativa',
  renovacao_auto  BOOLEAN NOT NULL DEFAULT TRUE,
  FOREIGN KEY (id_conta) REFERENCES conta(id_conta),
  FOREIGN KEY (id_plano) REFERENCES plano(id_plano)
);

-- Formas de pagamento salvas (nunca guardamos o número do cartão, só o final)
CREATE TABLE metodo_pagamento (
  id_metodo   INT AUTO_INCREMENT PRIMARY KEY,
  id_conta    INT NOT NULL,
  tipo        ENUM('Cartão de crédito','Pix','Boleto') NOT NULL,
  descricao   VARCHAR(40) NOT NULL,          -- ex.: 'Visa final 4417'
  padrao      BOOLEAN NOT NULL DEFAULT FALSE,
  FOREIGN KEY (id_conta) REFERENCES conta(id_conta) ON DELETE CASCADE
);

-- Fatura mensal de cada assinatura
CREATE TABLE fatura (
  id_fatura      INT AUTO_INCREMENT PRIMARY KEY,
  id_assinatura  INT NOT NULL,
  competencia    CHAR(7) NOT NULL,           -- 'AAAA-MM'
  valor          DECIMAL(8,2) NOT NULL,
  vencimento     DATE NOT NULL,
  status         ENUM('Aberta','Paga','Vencida','Cancelada') NOT NULL DEFAULT 'Aberta',
  UNIQUE (id_assinatura, competencia),
  FOREIGN KEY (id_assinatura) REFERENCES assinatura(id_assinatura)
);

-- Pagamentos realizados (uma fatura pode ter tentativa recusada e depois aprovada)
CREATE TABLE pagamento (
  id_pagamento   INT AUTO_INCREMENT PRIMARY KEY,
  id_fatura      INT NOT NULL,
  id_metodo      INT NOT NULL,
  pago_em        DATETIME NOT NULL,
  valor          DECIMAL(8,2) NOT NULL,
  resultado      ENUM('Aprovado','Recusado') NOT NULL,
  FOREIGN KEY (id_fatura) REFERENCES fatura(id_fatura),
  FOREIGN KEY (id_metodo) REFERENCES metodo_pagamento(id_metodo)
);

CREATE INDEX idx_fatura_status ON fatura(status, vencimento);
CREATE INDEX idx_assinatura_status ON assinatura(status);

-- Visão usada pelo time financeiro: faturas com dono e plano
CREATE VIEW vw_faturas_detalhadas AS
SELECT f.id_fatura, f.competencia, f.valor, f.vencimento, f.status,
       c.id_conta, c.nome AS cliente, c.email, p.nome AS plano
FROM fatura f
JOIN assinatura a ON a.id_assinatura = f.id_assinatura
JOIN conta c      ON c.id_conta = a.id_conta
JOIN plano p      ON p.id_plano = a.id_plano;

-- Quando um pagamento é aprovado, a fatura vira 'Paga' automaticamente
DELIMITER //
CREATE TRIGGER trg_pagamento_aprovado
AFTER INSERT ON pagamento
FOR EACH ROW
BEGIN
  IF NEW.resultado = 'Aprovado' THEN
    UPDATE fatura SET status = 'Paga' WHERE id_fatura = NEW.id_fatura;
  END IF;
END//
DELIMITER ;
