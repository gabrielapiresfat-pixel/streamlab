// =========================================================
// StreamLab · Tema 4 — consultas no catálogo (mongosh 02_consultas.js)
// =========================================================
db = db.getSiblingDB('streamlab_catalogo');
const mostrar = (titulo, r) => { print('\n== ' + titulo); printjson(r); };

// 1. Filmes de terror, só título e ano
mostrar('1. Terror', db.titulos.find(
  { generos: 'Terror' }, { _id: 0, titulo: 1, ano: 1 }).sort({ ano: 1 }).toArray());

// 2. Disponíveis em HD com nota acima de 4.4
mostrar('2. HD e nota > 4.4', db.titulos.find(
  { qualidades: 'HD', 'avaliacao.media': { $gt: 4.4 } },
  { _id: 0, titulo: 1, 'avaliacao.media': 1 }).sort({ 'avaliacao.media': -1 }).toArray());

// 3. Busca por texto (como a barra de busca do app)
mostrar('3. Busca "lua foguete"', db.titulos.find(
  { $text: { $search: 'lua foguete' } },
  { _id: 0, titulo: 1, score: { $meta: 'textScore' } }).sort({ score: { $meta: 'textScore' } }).toArray());

// 4. Tudo em que o Cary Grant atua (busca dentro do array de elenco)
mostrar('4. Com Cary Grant', db.titulos.find(
  { 'elenco.nome': 'Cary Grant' },
  { _id: 0, titulo: 1, 'elenco.$': 1 }).toArray());

// 5. Filmes mudos (campo que só alguns documentos têm: $exists)
mostrar('5. Filmes mudos', db.titulos.find(
  { mudo: { $exists: true } }, { _id: 0, titulo: 1, ano: 1, 'idiomas.cartelas': 1 }).sort({ ano: 1 }).toArray());

// 6. Clássicos da década de 1920
mostrar('6. Anos 1920', db.titulos.find(
  { ano: { $gte: 1920, $lt: 1930 } }, { _id: 0, titulo: 1, ano: 1 }).sort({ ano: 1 }).toArray());

// 7. Quantos títulos e nota média por gênero (aggregate)
mostrar('7. Por gênero', db.titulos.aggregate([
  { $unwind: '$generos' },
  { $group: { _id: '$generos', titulos: { $sum: 1 }, nota_media: { $avg: '$avaliacao.media' } } },
  { $project: { _id: 0, genero: '$_id', titulos: 1, nota_media: { $round: ['$nota_media', 2] } } },
  { $sort: { titulos: -1, genero: 1 } }
]).toArray());

// 8. Títulos e duração média por década
mostrar('8. Por década', db.titulos.aggregate([
  { $group: { _id: { $multiply: [{ $floor: { $divide: ['$ano', 10] } }, 10] },
              titulos: { $push: '$titulo' }, duracao_media: { $avg: '$duracao_min' } } },
  { $project: { _id: 0, decada: '$_id', titulos: 1, duracao_media: { $round: ['$duracao_media', 0] } } },
  { $sort: { decada: 1 } }
]).toArray());

// 9. Registrar uma nova versão restaurada de Nosferatu ($push num array que ele ainda não tinha)
db.titulos.updateOne({ _id: 't1' }, { $push: { versoes: { ano: 2006, nome: 'Restauração da Fundação Murnau', duracao_min: 94 } } });
mostrar('9. Versões de Nosferatu', db.titulos.findOne({ _id: 't1' }, { _id: 0, titulo: 1, versoes: 1 }));

// 10. Registrar um novo voto de nota 5 em "Flash Gordon" (recalcula a média)
db.titulos.updateOne({ _id: 't8' }, [{ $set: {
  'avaliacao.media': { $round: [{ $divide: [{ $add: [{ $multiply: ['$avaliacao.media', '$avaliacao.votos'] }, 5] }, { $add: ['$avaliacao.votos', 1] }] }, 2] },
  'avaliacao.votos': { $add: ['$avaliacao.votos', 1] } } }]);
mostrar('10. Nova avaliação de Flash Gordon', db.titulos.findOne({ _id: 't8' }, { _id: 0, titulo: 1, avaliacao: 1 }));
