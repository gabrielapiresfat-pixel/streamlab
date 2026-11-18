-- =========================================================
-- StreamLab · Tema 1 — consultas
-- =========================================================
USE streamlab_assinaturas;
SET NAMES utf8mb4;

-- 1. Assinaturas ativas com o cliente e o plano
SELECT c.nome AS cliente, p.nome AS plano, p.preco_mensal, a.inicio
FROM assinatura a
JOIN conta c ON c.id_conta = a.id_conta
JOIN plano p ON p.id_plano = a.id_plano
WHERE a.status = 'Ativa'
ORDER BY p.preco_mensal DESC;

-- 2. Receita recorrente mensal (MRR): soma dos planos das assinaturas ativas
SELECT ROUND(SUM(p.preco_mensal), 2) AS mrr
FROM assinatura a JOIN plano p ON p.id_plano = a.id_plano
WHERE a.status = 'Ativa';

-- 3. Quantos assinantes ativos cada plano tem (inclui planos sem ninguém)
SELECT p.nome AS plano, COUNT(a.id_assinatura) AS assinantes_ativos
FROM plano p
LEFT JOIN assinatura a ON a.id_plano = p.id_plano AND a.status = 'Ativa'
GROUP BY p.id_plano, p.nome
ORDER BY assinantes_ativos DESC, p.nome;

-- 4. Receita efetivamente recebida por mês (só pagamentos aprovados)
SELECT DATE_FORMAT(pg.pago_em, '%Y-%m') AS mes, SUM(pg.valor) AS recebido
FROM pagamento pg
WHERE pg.resultado = 'Aprovado'
GROUP BY mes
ORDER BY mes;

-- 5. Clientes inadimplentes: faturas vencidas e quanto devem
SELECT cliente, email, COUNT(*) AS faturas_vencidas, SUM(valor) AS total_devido
FROM vw_faturas_detalhadas
WHERE status = 'Vencida'
GROUP BY id_conta, cliente, email;

-- 6. Pagamentos recusados (para o time de cobrança agir)
SELECT c.nome AS cliente, m.descricao AS metodo, pg.pago_em, pg.valor
FROM pagamento pg
JOIN metodo_pagamento m ON m.id_metodo = pg.id_metodo
JOIN conta c ON c.id_conta = m.id_conta
WHERE pg.resultado = 'Recusado'
ORDER BY pg.pago_em;

-- 7. Taxa de aprovação de pagamentos por forma de pagamento
SELECT m.tipo,
       COUNT(*) AS tentativas,
       SUM(pg.resultado = 'Aprovado') AS aprovados,
       ROUND(100 * SUM(pg.resultado = 'Aprovado') / COUNT(*), 1) AS taxa_aprovacao_pct
FROM pagamento pg JOIN metodo_pagamento m ON m.id_metodo = pg.id_metodo
GROUP BY m.tipo;

-- 8. Contas com mais perfis do que o plano permite de telas simultâneas
SELECT c.nome AS cliente, p.nome AS plano, p.telas_simultaneas, COUNT(pf.id_perfil) AS perfis
FROM conta c
JOIN assinatura a ON a.id_conta = c.id_conta AND a.status <> 'Cancelada'
JOIN plano p      ON p.id_plano = a.id_plano
JOIN perfil pf    ON pf.id_conta = c.id_conta
GROUP BY c.id_conta, c.nome, p.nome, p.telas_simultaneas
HAVING COUNT(pf.id_perfil) > p.telas_simultaneas;

-- 9. Faturas em aberto de novembro/2026 (a receber)
SELECT cliente, plano, valor, vencimento
FROM vw_faturas_detalhadas
WHERE competencia = '2026-11' AND status IN ('Aberta','Vencida')
ORDER BY vencimento;

-- 10. Taxa de cancelamento (churn) da base
SELECT COUNT(*) AS total_assinaturas,
       SUM(status = 'Cancelada') AS canceladas,
       ROUND(100 * SUM(status = 'Cancelada') / COUNT(*), 1) AS churn_pct
FROM assinatura;

-- 11. Ticket médio por cliente pagante (valor médio pago por conta)
SELECT c.nome AS cliente, ROUND(AVG(pg.valor), 2) AS ticket_medio, SUM(pg.valor) AS total_pago
FROM pagamento pg
JOIN fatura f     ON f.id_fatura = pg.id_fatura
JOIN assinatura a ON a.id_assinatura = f.id_assinatura
JOIN conta c      ON c.id_conta = a.id_conta
WHERE pg.resultado = 'Aprovado'
GROUP BY c.id_conta, c.nome
ORDER BY total_pago DESC;

-- 12. Upgrade de plano: Rafael passa do Padrão para o Premium (transação)
START TRANSACTION;
UPDATE assinatura SET status = 'Cancelada', fim = '2026-11-30', renovacao_auto = FALSE
WHERE id_conta = 2 AND status = 'Ativa';
INSERT INTO assinatura (id_conta, id_plano, inicio, status) VALUES (2, 4, '2026-12-01', 'Ativa');
COMMIT;

-- 13. Pagar a fatura vencida de outubro do Pedro (o gatilho marca como Paga)
INSERT INTO pagamento (id_fatura, id_metodo, pago_em, valor, resultado)
VALUES (11, 4, NOW(), 29.90, 'Aprovado');
SELECT id_fatura, competencia, status FROM fatura WHERE id_fatura = 11;
