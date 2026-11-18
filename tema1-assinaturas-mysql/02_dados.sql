-- =========================================================
-- StreamLab · Tema 1 — dados de exemplo
-- =========================================================
USE streamlab_assinaturas;
SET NAMES utf8mb4;

INSERT INTO plano (nome, preco_mensal, qualidade, telas_simultaneas, com_anuncios) VALUES
('Básico com anúncios', 20.90, 'HD',      1, TRUE),
('Básico',              29.90, 'HD',      1, FALSE),
('Padrão',              44.90, 'Full HD', 2, FALSE),
('Premium',             59.90, '4K',      4, FALSE),
('Família',             69.90, '4K',      6, FALSE);

INSERT INTO conta (nome, email, pais, criada_em, status) VALUES
('Mariana Lopes',   'mariana.lopes@email.com',  'BR', '2025-03-10', 'Ativa'),
('Rafael Antunes',  'rafael.antunes@email.com', 'BR', '2025-06-22', 'Ativa'),
('Juliana Prado',   'juliana.prado@email.com',  'BR', '2025-09-05', 'Ativa'),
('Pedro Henrique',  'pedro.h@email.com',        'PT', '2025-11-18', 'Suspensa'),
('Camila Ferraz',   'camila.ferraz@email.com',  'BR', '2026-01-30', 'Ativa'),
('Lucas Moreira',   'lucas.moreira@email.com',  'BR', '2026-04-12', 'Cancelada'),
('Beatriz Souza',   'beatriz.souza@email.com',  'BR', '2026-07-01', 'Ativa');

INSERT INTO perfil (id_conta, nome, infantil) VALUES
(1,'Mariana',FALSE),(1,'Theo',TRUE),(2,'Rafael',FALSE),(3,'Ju',FALSE),(3,'Marcos',FALSE),
(3,'Kids',TRUE),(4,'Pedro',FALSE),(5,'Camila',FALSE),(5,'Namorado',FALSE),(6,'Lucas',FALSE),(7,'Bia',FALSE),(7,'Vó Lurdes',FALSE);

INSERT INTO assinatura (id_conta, id_plano, inicio, fim, status, renovacao_auto) VALUES
(1, 5, '2025-03-10', NULL,         'Ativa',     TRUE),   -- 1 Mariana  · Família
(2, 3, '2025-06-22', NULL,         'Ativa',     TRUE),   -- 2 Rafael   · Padrão
(3, 4, '2025-09-05', NULL,         'Ativa',     TRUE),   -- 3 Juliana  · Premium
(4, 2, '2025-11-18', NULL,         'Em atraso', TRUE),   -- 4 Pedro    · Básico
(5, 1, '2026-01-30', NULL,         'Ativa',     TRUE),   -- 5 Camila   · Básico c/ anúncios
(6, 3, '2026-04-12', '2026-08-12', 'Cancelada', FALSE),  -- 6 Lucas    · Padrão
(7, 4, '2026-07-01', NULL,         'Ativa',     TRUE);   -- 7 Beatriz  · Premium

INSERT INTO metodo_pagamento (id_conta, tipo, descricao, padrao) VALUES
(1,'Cartão de crédito','Visa final 4417',TRUE),
(2,'Pix','Pix automático',TRUE),
(3,'Cartão de crédito','Mastercard final 0921',TRUE),
(4,'Cartão de crédito','Elo final 7730',TRUE),
(5,'Boleto','Boleto bancário',TRUE),
(6,'Cartão de crédito','Visa final 1288',TRUE),
(7,'Pix','Pix automático',TRUE);

-- Faturas de setembro, outubro e novembro/2026
INSERT INTO fatura (id_assinatura, competencia, valor, vencimento, status) VALUES
(1,'2026-09',69.90,'2026-09-10','Aberta'),(1,'2026-10',69.90,'2026-10-10','Aberta'),(1,'2026-11',69.90,'2026-11-10','Aberta'),
(2,'2026-09',44.90,'2026-09-22','Aberta'),(2,'2026-10',44.90,'2026-10-22','Aberta'),(2,'2026-11',44.90,'2026-11-22','Aberta'),
(3,'2026-09',59.90,'2026-09-05','Aberta'),(3,'2026-10',59.90,'2026-10-05','Aberta'),(3,'2026-11',59.90,'2026-11-05','Aberta'),
(4,'2026-09',29.90,'2026-09-18','Aberta'),(4,'2026-10',29.90,'2026-10-18','Vencida'),(4,'2026-11',29.90,'2026-11-18','Vencida'),
(5,'2026-09',20.90,'2026-09-30','Aberta'),(5,'2026-10',20.90,'2026-10-30','Aberta'),(5,'2026-11',20.90,'2026-11-30','Aberta'),
(7,'2026-09',59.90,'2026-09-01','Aberta'),(7,'2026-10',59.90,'2026-10-01','Aberta'),(7,'2026-11',59.90,'2026-11-01','Aberta');

-- Pagamentos (o gatilho marca a fatura como Paga quando aprovado)
INSERT INTO pagamento (id_fatura, id_metodo, pago_em, valor, resultado) VALUES
(1,1,'2026-09-10 08:02:11',69.90,'Aprovado'),
(2,1,'2026-10-10 08:01:40',69.90,'Aprovado'),
(3,1,'2026-11-10 08:03:05',69.90,'Aprovado'),
(4,2,'2026-09-22 09:15:00',44.90,'Aprovado'),
(5,2,'2026-10-22 09:14:21',44.90,'Aprovado'),
(7,3,'2026-09-05 07:59:59',59.90,'Aprovado'),
(8,3,'2026-10-05 08:00:30',59.90,'Aprovado'),
(9,3,'2026-11-05 08:00:12',59.90,'Recusado'),
(9,3,'2026-11-06 10:22:47',59.90,'Aprovado'),
(10,4,'2026-09-18 12:40:00',29.90,'Aprovado'),
(11,4,'2026-10-18 12:40:03',29.90,'Recusado'),
(13,5,'2026-09-28 16:20:00',20.90,'Aprovado'),
(14,5,'2026-10-29 11:05:00',20.90,'Aprovado'),
(16,7,'2026-09-01 07:30:00',59.90,'Aprovado'),
(17,7,'2026-10-01 07:30:00',59.90,'Aprovado'),
(18,7,'2026-11-01 07:30:00',59.90,'Aprovado');
