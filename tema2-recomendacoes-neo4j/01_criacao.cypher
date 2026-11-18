// =========================================================
// StreamLab · Tema 2 — Grafo de Recomendações e Relacionamentos
// Banco de grafos (Neo4j 5) — rode no Neo4j Browser ou no Aura Free
// =========================================================

// Limpa o grafo (cuidado: apaga tudo)
MATCH (n) DETACH DELETE n;

// Restrições de unicidade (também criam índices)
CREATE CONSTRAINT perfil_id IF NOT EXISTS FOR (p:Perfil) REQUIRE p.id IS UNIQUE;
CREATE CONSTRAINT titulo_id IF NOT EXISTS FOR (t:Titulo) REQUIRE t.id IS UNIQUE;
CREATE CONSTRAINT genero_nome IF NOT EXISTS FOR (g:Genero) REQUIRE g.nome IS UNIQUE;
CREATE CONSTRAINT pessoa_nome IF NOT EXISTS FOR (a:Pessoa) REQUIRE a.nome IS UNIQUE;

// ---------- Gêneros ----------
UNWIND ['Terror','Ficção científica','Comédia','Drama','Romance','Aventura','Noir','Suspense','Fantasia'] AS g
CREATE (:Genero {nome: g});

// ---------- Títulos (filmes de domínio público do Internet Archive) ----------
UNWIND [
  {id:'t1', nome:'Nosferatu',                 ano:1922, generos:['Terror']},
  {id:'t2', nome:'Metropolis',                ano:1927, generos:['Ficção científica','Drama']},
  {id:'t3', nome:'A General',                 ano:1926, generos:['Comédia','Aventura']},
  {id:'t4', nome:'A Noite dos Mortos-Vivos',  ano:1968, generos:['Terror','Suspense']},
  {id:'t5', nome:'Jejum de Amor',             ano:1940, generos:['Comédia','Romance']},
  {id:'t6', nome:'O Fantasma da Ópera',       ano:1925, generos:['Terror','Drama']},
  {id:'t7', nome:'O Homem Mosca',             ano:1923, generos:['Comédia']},
  {id:'t8', nome:'Flash Gordon',              ano:1936, generos:['Ficção científica','Aventura']},
  {id:'t9', nome:'Curva do Destino',          ano:1945, generos:['Noir','Suspense']},
  {id:'t10',nome:'Viagem à Lua',              ano:1902, generos:['Ficção científica','Fantasia']}
] AS t
CREATE (ti:Titulo {id:t.id, nome:t.nome, ano:t.ano})
WITH ti, t
UNWIND t.generos AS g
MATCH (ge:Genero {nome:g})
CREATE (ti)-[:DO_GENERO]->(ge);

// ---------- Pessoas (elenco e direção): [nome, papel, título] ----------
UNWIND [
  ['Max Schreck','ATUA_EM','t1'], ['F. W. Murnau','DIRIGIU','t1'],
  ['Brigitte Helm','ATUA_EM','t2'], ['Fritz Lang','DIRIGIU','t2'],
  ['Buster Keaton','ATUA_EM','t3'], ['Buster Keaton','DIRIGIU','t3'],
  ['Duane Jones','ATUA_EM','t4'], ['George A. Romero','DIRIGIU','t4'],
  ['Cary Grant','ATUA_EM','t5'], ['Rosalind Russell','ATUA_EM','t5'], ['Howard Hawks','DIRIGIU','t5'],
  ['Lon Chaney','ATUA_EM','t6'], ['Mary Philbin','ATUA_EM','t6'],
  ['Harold Lloyd','ATUA_EM','t7'],
  ['Buster Crabbe','ATUA_EM','t8'], ['Jean Rogers','ATUA_EM','t8'],
  ['Tom Neal','ATUA_EM','t9'], ['Edgar G. Ulmer','DIRIGIU','t9'],
  ['Georges Méliès','ATUA_EM','t10'], ['Georges Méliès','DIRIGIU','t10']
] AS x
MERGE (pe:Pessoa {nome:x[0]})
WITH pe, x
MATCH (t:Titulo {id:x[2]})
FOREACH (_ IN CASE WHEN x[1] = 'ATUA_EM' THEN [1] ELSE [] END | MERGE (pe)-[:ATUA_EM]->(t))
FOREACH (_ IN CASE WHEN x[1] = 'DIRIGIU' THEN [1] ELSE [] END | MERGE (pe)-[:DIRIGIU]->(t));

// ---------- Perfis (mesmos ids dos perfis do Tema 1) ----------
UNWIND [
  {id:1, nome:'Mariana'}, {id:3, nome:'Rafael'}, {id:4, nome:'Ju'},
  {id:5, nome:'Marcos'},  {id:8, nome:'Camila'}, {id:10, nome:'Bia'}
] AS p
CREATE (:Perfil {id:p.id, nome:p.nome});

// ---------- O que cada perfil assistiu (nota de 1 a 5) ----------
UNWIND [
  [1,'t1',5],[1,'t8',5],[1,'t4',4],[1,'t2',3],
  [3,'t1',4],[3,'t4',5],[3,'t10',5],[3,'t6',3],
  [4,'t2',5],[4,'t7',5],[4,'t8',4],
  [5,'t3',5],[5,'t9',4],[5,'t5',4],
  [8,'t1',5],[8,'t10',4],[8,'t3',2],
  [10,'t7',4],[10,'t2',4],[10,'t5',5]
] AS a
MATCH (p:Perfil {id:a[0]}), (t:Titulo {id:a[1]})
CREATE (p)-[:ASSISTIU {nota:a[2]}]->(t);

// ---------- Quem segue quem (rede social dentro da plataforma) ----------
UNWIND [[1,4],[1,8],[3,8],[4,10],[8,3],[10,5]] AS s
MATCH (a:Perfil {id:s[0]}), (b:Perfil {id:s[1]})
CREATE (a)-[:SEGUE]->(b);
