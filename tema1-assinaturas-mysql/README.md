# Tema 1 — Assinaturas, Faturamento e Contas (MySQL)

## Modelo
```
conta 1───N perfil
conta 1───N assinatura N───1 plano
conta 1───N metodo_pagamento
assinatura 1───N fatura 1───N pagamento N───1 metodo_pagamento
```
- 7 tabelas, chaves primárias `AUTO_INCREMENT` e chaves estrangeiras.
- `ENUM` e `CHECK` garantem valores válidos (status, qualidade, preço ≥ 0).
- **View** `vw_faturas_detalhadas`: fatura + cliente + plano, usada pelo financeiro.
- **Trigger** `trg_pagamento_aprovado`: pagamento aprovado marca a fatura como *Paga*.
- Não guardamos número de cartão, só a descrição ("Visa final 4417").

## Como rodar
```bash
mysql -u root -p < 01_criacao.sql
mysql -u root -p < 02_dados.sql
mysql -u root -p < 03_consultas.sql
```
(ou cole os arquivos, nessa ordem, na aba SQL do phpMyAdmin / MySQL Workbench)

## Consultas (03_consultas.sql)
| # | O que responde | Resultado com os dados de exemplo |
|---|---|---|
| 1 | Assinaturas ativas com cliente e plano | 5 assinaturas |
| 2 | Receita recorrente mensal (MRR) | R$ 255,50 |
| 3 | Assinantes por plano (LEFT JOIN) | Premium 2, demais 1, Básico 0 |
| 4 | Receita recebida por mês | set 285,40 · out 255,50 · nov 189,70 |
| 5 | Inadimplentes (usa a view) | Pedro Henrique, R$ 59,80 |
| 6 | Pagamentos recusados | 2 (Pedro e Juliana) |
| 7 | Taxa de aprovação por forma de pagamento | cartão 77,8% · Pix 100% · boleto 100% |
| 8 | Contas com mais perfis que telas do plano (HAVING) | Camila (2 perfis, 1 tela) |
| 9 | Faturas de novembro a receber | 3 faturas |
| 10 | Churn (taxa de cancelamento) | 14,3% |
| 11 | Ticket médio por cliente | Mariana lidera (R$ 209,70) |
| 12 | Upgrade de plano em **transação** | Rafael: Padrão → Premium |
| 13 | Pagamento que dispara o **trigger** | fatura 11 vira *Paga* |
