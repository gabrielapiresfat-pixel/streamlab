# StreamLab — plataforma de streaming em 5 bancos de dados

Projeto P2 de Banco de Dados (FATEC) · **Parte 1: Plataforma de Streaming de Vídeo**.
Cada módulo da plataforma usa o tipo de banco que melhor resolve o seu problema.
O acervo são **filmes clássicos de domínio público do [Internet Archive](https://archive.org/details/feature_films)**, que tocam de verdade no app do site.

**Demonstração:** https://gabrielapiresfat-pixel.github.io/streamlab/

| Tema | Módulo | Banco | Pasta |
|---|---|---|---|
| 1 | Assinaturas, Faturamento e Contas | Relacional · **MySQL** | [`tema1-assinaturas-mysql`](tema1-assinaturas-mysql) |
| 2 | Grafo de Recomendações e Relacionamentos | Grafos · **Neo4j** | [`tema2-recomendacoes-neo4j`](tema2-recomendacoes-neo4j) |
| 3 | Gestão de Sessões, Tokens e Cache | Chave-valor · **Redis** | [`tema3-sessoes-redis`](tema3-sessoes-redis) |
| 4 | Catálogo de Mídia e Metadados | Documentos · **MongoDB** | [`tema4-catalogo-mongodb`](tema4-catalogo-mongodb) |
| 5 | Telemetria de Reprodução, Buffer e Métricas | Série temporal · **InfluxDB** | [`tema5-telemetria-influxdb`](tema5-telemetria-influxdb) |

## Como os módulos se ligam
Os bancos compartilham os mesmos identificadores: **id do perfil** (ex.: 1 = Mariana) e **id do título** (ex.: `t1` = *Nosferatu*).
Assim o app junta as informações: a assinatura vem do MySQL, a recomendação do Neo4j, a sessão do Redis, os dados do filme do MongoDB e a qualidade da reprodução do InfluxDB.

## Por que um banco diferente para cada tema
- **MySQL** — dinheiro exige consistência: chaves estrangeiras, transações (upgrade de plano) e gatilho (fatura paga).
- **Neo4j** — recomendação é percorrer ligações ("quem assistiu isso também assistiu"), o que em SQL viraria muitos JOINs.
- **Redis** — sessões e cache são lidos o tempo todo e expiram sozinhos (TTL), tudo em memória.
- **MongoDB** — cada filme tem formato diferente (mudo com cartelas, seriado com capítulos, versões restauradas); cada título é um documento, com o endereço do vídeo no Internet Archive.
- **InfluxDB** — o player manda medições a cada 10 s; um banco de série temporal agrega por janela de tempo.

## Estrutura
```
tema1-assinaturas-mysql/     01_criacao.sql · 02_dados.sql · 03_consultas.sql (13 comandos)
tema2-recomendacoes-neo4j/   01_criacao.cypher · 02_consultas.cypher (10 consultas)
tema3-sessoes-redis/         comandos.redis (10 blocos de comandos)
tema4-catalogo-mongodb/      01_dados.js · 02_consultas.js (10 consultas)
tema5-telemetria-influxdb/   01_dados.lp · 02_consultas.flux (10 consultas)
docs/                        site de demonstração (GitHub Pages): app estilo cinema + uma aba por tema
```
Cada pasta tem um README com o modelo, como rodar e o que cada consulta faz.

## O app (site)
- Escolha de perfil, sala de cinema com fileiras de filmes, recomendações e "continuar assistindo".
- **Player com vídeo real**: os filmes vêm do Internet Archive (`archive.org/download/<identificador>/<arquivo>`), e o buffer, as travadas e os quadros perdidos medidos no navegador viram registros de telemetria.
- Fileira **Acervo livre**: busca ao vivo os filmes mais vistos da coleção `feature_films` pela API pública do Internet Archive.
- Painel **"O que aconteceu nos bancos"**: mostra qual banco respondeu a cada ação e o comando usado.

Os filmes são de domínio público; o site não guarda nenhum vídeo, apenas toca a partir do Internet Archive.
