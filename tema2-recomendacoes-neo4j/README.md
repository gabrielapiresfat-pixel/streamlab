# Tema 2 — Grafo de Recomendações e Relacionamentos (Neo4j)

## Modelo
```
(:Perfil)-[:ASSISTIU {nota}]->(:Titulo)-[:DO_GENERO]->(:Genero)
(:Pessoa)-[:ATUA_EM | :DIRIGIU]->(:Titulo)
(:Perfil)-[:SEGUE]->(:Perfil)
```
6 perfis, 10 filmes clássicos de domínio público (os mesmos do acervo do Internet Archive usado no app), 9 gêneros, 17 pessoas e 20 avaliações. Os ids de perfil são os mesmos do Tema 1.

## Como rodar
Crie um banco grátis no **Neo4j Aura Free** (ou use o Neo4j Desktop), abra o **Neo4j Browser**,
cole `01_criacao.cypher` e depois as consultas de `02_consultas.cypher` (uma por vez ou todas com a opção de múltiplas instruções ligada).

## Consultas
1. O que a Mariana assistiu
2. **Quem assistiu isso também assistiu** (filtragem colaborativa) → para a Mariana: *Viagem à Lua* e *O Homem Mosca*
3. Recomendação pelo gênero favorito
4. Em alta entre quem a pessoa segue
5. Títulos mais populares
6. Quem atuou com o Cary Grant
7. Caminho mais curto entre dois perfis (`shortestPath`)
8. Títulos parecidos (mesmo gênero, elenco ou direção)
9. Gêneros mais assistidos
10. Registrar uma nova avaliação (`MERGE`)
