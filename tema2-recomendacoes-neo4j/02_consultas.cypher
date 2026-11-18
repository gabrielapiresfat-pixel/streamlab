// =========================================================
// StreamLab · Tema 2 — consultas no grafo
// =========================================================

// 1. Tudo o que a Mariana assistiu, com a nota
MATCH (:Perfil {nome:'Mariana'})-[a:ASSISTIU]->(t:Titulo)
RETURN t.nome AS titulo, a.nota AS nota
ORDER BY nota DESC;

// 2. "Quem assistiu isso também assistiu" (filtragem colaborativa)
//    Títulos que perfis parecidos com a Mariana gostaram e ela ainda não viu
MATCH (eu:Perfil {nome:'Mariana'})-[a1:ASSISTIU]->(t:Titulo)<-[a2:ASSISTIU]-(outro:Perfil)
WHERE a1.nota >= 4 AND a2.nota >= 4
MATCH (outro)-[a3:ASSISTIU]->(rec:Titulo)
WHERE a3.nota >= 4 AND NOT (eu)-[:ASSISTIU]->(rec)
RETURN rec.nome AS recomendacao, count(DISTINCT outro) AS perfis_parecidos, round(avg(a3.nota),1) AS nota_media
ORDER BY perfis_parecidos DESC, nota_media DESC
LIMIT 5;

// 3. Recomendação por gênero favorito do Rafael
MATCH (p:Perfil {nome:'Rafael'})-[a:ASSISTIU]->(:Titulo)-[:DO_GENERO]->(g:Genero)
WITH p, g, sum(a.nota) AS peso ORDER BY peso DESC LIMIT 1
MATCH (g)<-[:DO_GENERO]-(rec:Titulo)
WHERE NOT (p)-[:ASSISTIU]->(rec)
RETURN g.nome AS genero_favorito, collect(rec.nome) AS sugestoes;

// 4. Em alta entre quem a Ju segue
MATCH (:Perfil {nome:'Ju'})-[:SEGUE]->(amigo:Perfil)-[a:ASSISTIU]->(t:Titulo)
RETURN t.nome AS titulo, collect(amigo.nome) AS amigos, max(a.nota) AS melhor_nota;

// 5. Títulos mais populares (mais vistos e melhor avaliados)
MATCH (p:Perfil)-[a:ASSISTIU]->(t:Titulo)
RETURN t.nome AS titulo, count(p) AS visualizacoes, round(avg(a.nota),1) AS nota_media
ORDER BY visualizacoes DESC, nota_media DESC
LIMIT 5;

// 6. Pessoas que trabalham juntas: quem atuou com o Cary Grant
MATCH (:Pessoa {nome:'Cary Grant'})-[:ATUA_EM]->(t:Titulo)<-[:ATUA_EM]-(colega:Pessoa)
RETURN colega.nome AS colega, collect(t.nome) AS titulos_em_comum;

// 7. Caminho mais curto entre dois perfis pela rede de quem segue quem
MATCH caminho = shortestPath((:Perfil {nome:'Mariana'})-[:SEGUE*]-(:Perfil {nome:'Marcos'}))
RETURN [n IN nodes(caminho) | n.nome] AS caminho, length(caminho) AS passos;

// 8. Títulos parecidos com "Nosferatu": compartilham gênero, elenco ou direção
MATCH (base:Titulo {nome:'Nosferatu'})-[:DO_GENERO|ATUA_EM|DIRIGIU]-(ligacao)-[:DO_GENERO|ATUA_EM|DIRIGIU]-(similar:Titulo)
WHERE similar <> base
RETURN similar.nome AS titulo, count(DISTINCT ligacao) AS pontos_em_comum, collect(DISTINCT coalesce(ligacao.nome, '')) AS por_causa_de
ORDER BY pontos_em_comum DESC;

// 9. Gêneros mais assistidos na plataforma
MATCH (:Perfil)-[:ASSISTIU]->(:Titulo)-[:DO_GENERO]->(g:Genero)
RETURN g.nome AS genero, count(*) AS visualizacoes
ORDER BY visualizacoes DESC;

// 10. Registrar que a Camila assistiu "Flash Gordon" e deu nota 5
MATCH (p:Perfil {nome:'Camila'}), (t:Titulo {nome:'Flash Gordon'})
MERGE (p)-[a:ASSISTIU]->(t)
SET a.nota = 5
RETURN p.nome, t.nome, a.nota;
