# Tema 4 — Catálogo de Mídia e Metadados (MongoDB)

## Modelo (coleção `titulos`)
O acervo são **10 filmes clássicos de domínio público do Internet Archive**. Cada título é um documento, e os documentos não precisam ter os mesmos campos:
filme mudo tem `mudo` e `idiomas.cartelas`; seriado tem `capitulos_originais`; alguns têm `versoes` (restaurações).
```js
{ _id: 't1', titulo: 'Nosferatu', original: 'Nosferatu, eine Symphonie des Grauens', tipo: 'filme', ano: 1922,
  generos: ['Terror'], duracao_min: 93, mudo: true, elenco: [{ nome, personagem }], direcao: ['F. W. Murnau'],
  idiomas: { audio: ['trilha instrumental'], cartelas: ['en'] }, avaliacao: { media: 4.6, votos: 21430 },
  acervo: { fonte: 'Internet Archive', identificador: 'Nosferatu_most_complete_version_93_mins.', arquivo: '...mp4' } }
```
O campo **`acervo`** liga o catálogo ao vídeo real: o player do site monta o endereço
`https://archive.org/download/<identificador>/<arquivo>` e toca o filme.
Índices: texto (`titulo` + `sinopse`, em português), `generos`, `elenco.nome` e `ano`. Os `_id` são os mesmos dos outros temas.

## Como rodar
```bash
mongosh 01_dados.js
mongosh 02_consultas.js
```
(ou um cluster grátis no **MongoDB Atlas** + **MongoDB Compass**, colando os comandos no shell)

## Consultas
1. Filmes de terror · 2. Em HD com nota > 4,4 · 3. Busca por texto ("lua foguete" → Viagem à Lua) ·
4. Tudo com o Cary Grant (array de elenco) · 5. Filmes mudos (`$exists`) · 6. Clássicos dos anos 1920 ·
7. Títulos e nota média por gênero (`aggregate`) · 8. Títulos e duração média por década ·
9. Nova versão restaurada (`$push`) · 10. Novo voto recalculando a média (update com pipeline)
