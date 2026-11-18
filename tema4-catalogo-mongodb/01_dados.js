// =========================================================
// StreamLab · Tema 4 — Catálogo de Mídia e Metadados
// Banco orientado a documentos (MongoDB 7) — rode com: mongosh 01_dados.js
// Acervo: filmes clássicos de domínio público do Internet Archive (archive.org).
// Cada documento guarda em "acervo" o identificador e o arquivo de vídeo usados pelo player.
// =========================================================
db = db.getSiblingDB('streamlab_catalogo');
db.titulos.drop();

db.titulos.insertMany([
  {
    "_id": "t1",
    "titulo": "Nosferatu",
    "original": "Nosferatu, eine Symphonie des Grauens",
    "tipo": "filme",
    "ano": 1922,
    "generos": [
      "Terror"
    ],
    "classificacao": "14",
    "duracao_min": 93,
    "mudo": true,
    "sinopse": "Um corretor viaja à Transilvânia para vender uma casa ao misterioso Conde Orlok, que leva a peste e o terror até a cidade de Wisborg.",
    "elenco": [
      {
        "nome": "Max Schreck",
        "personagem": "Conde Orlok"
      },
      {
        "nome": "Gustav von Wangenheim",
        "personagem": "Thomas Hutter"
      },
      {
        "nome": "Greta Schröder",
        "personagem": "Ellen Hutter"
      }
    ],
    "direcao": [
      "F. W. Murnau"
    ],
    "pais": "Alemanha",
    "idiomas": {
      "audio": [
        "trilha instrumental"
      ],
      "cartelas": [
        "en"
      ]
    },
    "qualidades": [
      "SD"
    ],
    "avaliacao": {
      "media": 4.6,
      "votos": 21430
    },
    "acervo": {
      "fonte": "Internet Archive",
      "identificador": "Nosferatu_most_complete_version_93_mins.",
      "arquivo": "Nosferatu_1922_Symphony_of_Horror_512kb.mp4"
    },
    "disponivel_em": [
      "BR",
      "PT",
      "US"
    ]
  },
  {
    "_id": "t2",
    "titulo": "Metropolis",
    "original": "Metropolis",
    "tipo": "filme",
    "ano": 1927,
    "generos": [
      "Ficção científica",
      "Drama"
    ],
    "classificacao": "12",
    "duracao_min": 119,
    "mudo": true,
    "sinopse": "Numa cidade do futuro dividida entre ricos e operários, o filho do dono da cidade se apaixona por Maria, que prega a união entre os dois mundos.",
    "elenco": [
      {
        "nome": "Brigitte Helm",
        "personagem": "Maria / a robô"
      },
      {
        "nome": "Gustav Fröhlich",
        "personagem": "Freder"
      },
      {
        "nome": "Alfred Abel",
        "personagem": "Joh Fredersen"
      }
    ],
    "direcao": [
      "Fritz Lang"
    ],
    "pais": "Alemanha",
    "idiomas": {
      "audio": [
        "trilha instrumental"
      ],
      "cartelas": [
        "en"
      ]
    },
    "qualidades": [
      "SD",
      "HD"
    ],
    "avaliacao": {
      "media": 4.7,
      "votos": 18820
    },
    "versoes": [
      {
        "ano": 1927,
        "nome": "Estreia em Berlim",
        "duracao_min": 153
      },
      {
        "ano": 2010,
        "nome": "Restauração com cenas recuperadas",
        "duracao_min": 148
      }
    ],
    "acervo": {
      "fonte": "Internet Archive",
      "identificador": "Metropolis1927EnglishVersion",
      "arquivo": "Metropolis_1927_English_Version.mp4"
    },
    "disponivel_em": [
      "BR",
      "PT",
      "US"
    ]
  },
  {
    "_id": "t3",
    "titulo": "A General",
    "original": "The General",
    "tipo": "filme",
    "ano": 1926,
    "generos": [
      "Comédia",
      "Aventura"
    ],
    "classificacao": "L",
    "duracao_min": 79,
    "mudo": true,
    "sinopse": "Durante a Guerra Civil americana, um maquinista persegue sozinho os soldados que roubaram sua locomotiva — e sua namorada.",
    "elenco": [
      {
        "nome": "Buster Keaton",
        "personagem": "Johnnie Gray"
      },
      {
        "nome": "Marion Mack",
        "personagem": "Annabelle Lee"
      }
    ],
    "direcao": [
      "Buster Keaton",
      "Clyde Bruckman"
    ],
    "pais": "EUA",
    "idiomas": {
      "audio": [
        "trilha instrumental"
      ],
      "cartelas": [
        "en"
      ]
    },
    "qualidades": [
      "SD",
      "HD"
    ],
    "avaliacao": {
      "media": 4.5,
      "votos": 12110
    },
    "acervo": {
      "fonte": "Internet Archive",
      "identificador": "TheGeneral_201312",
      "arquivo": "The-General-v2.mp4"
    },
    "disponivel_em": [
      "BR",
      "PT",
      "US"
    ]
  },
  {
    "_id": "t4",
    "titulo": "A Noite dos Mortos-Vivos",
    "original": "Night of the Living Dead",
    "tipo": "filme",
    "ano": 1968,
    "generos": [
      "Terror",
      "Suspense"
    ],
    "classificacao": "16",
    "duracao_min": 96,
    "sinopse": "Um grupo de desconhecidos se tranca numa casa de fazenda enquanto mortos voltam à vida e cercam o lugar.",
    "elenco": [
      {
        "nome": "Duane Jones",
        "personagem": "Ben"
      },
      {
        "nome": "Judith O'Dea",
        "personagem": "Barbra"
      }
    ],
    "direcao": [
      "George A. Romero"
    ],
    "pais": "EUA",
    "idiomas": {
      "audio": [
        "en"
      ],
      "legendas": [
        "en"
      ]
    },
    "qualidades": [
      "SD"
    ],
    "avaliacao": {
      "media": 4.4,
      "votos": 25300
    },
    "acervo": {
      "fonte": "Internet Archive",
      "identificador": "NightOfTheLivingDead1968-Restored",
      "arquivo": "Notld1968Restoration-desktop_512kb.mp4"
    },
    "disponivel_em": [
      "BR",
      "PT",
      "US"
    ]
  },
  {
    "_id": "t5",
    "titulo": "Jejum de Amor",
    "original": "His Girl Friday",
    "tipo": "filme",
    "ano": 1940,
    "generos": [
      "Comédia",
      "Romance"
    ],
    "classificacao": "L",
    "duracao_min": 92,
    "sinopse": "Um editor de jornal faz de tudo para impedir que a ex-esposa, sua melhor repórter, se case de novo e largue a profissão.",
    "elenco": [
      {
        "nome": "Cary Grant",
        "personagem": "Walter Burns"
      },
      {
        "nome": "Rosalind Russell",
        "personagem": "Hildy Johnson"
      },
      {
        "nome": "Ralph Bellamy",
        "personagem": "Bruce Baldwin"
      }
    ],
    "direcao": [
      "Howard Hawks"
    ],
    "pais": "EUA",
    "idiomas": {
      "audio": [
        "en"
      ],
      "legendas": [
        "en"
      ]
    },
    "qualidades": [
      "SD"
    ],
    "avaliacao": {
      "media": 4.3,
      "votos": 9870
    },
    "acervo": {
      "fonte": "Internet Archive",
      "identificador": "his_girl_friday",
      "arquivo": "his_girl_friday_512kb.mp4"
    },
    "disponivel_em": [
      "BR",
      "PT",
      "US"
    ]
  },
  {
    "_id": "t6",
    "titulo": "O Fantasma da Ópera",
    "original": "The Phantom of the Opera",
    "tipo": "filme",
    "ano": 1925,
    "generos": [
      "Terror",
      "Drama"
    ],
    "classificacao": "12",
    "duracao_min": 106,
    "mudo": true,
    "sinopse": "Nos subterrâneos da Ópera de Paris vive um homem mascarado, obcecado pela jovem cantora Christine.",
    "elenco": [
      {
        "nome": "Lon Chaney",
        "personagem": "Erik, o Fantasma"
      },
      {
        "nome": "Mary Philbin",
        "personagem": "Christine Daaé"
      }
    ],
    "direcao": [
      "Rupert Julian"
    ],
    "pais": "EUA",
    "idiomas": {
      "audio": [
        "trilha instrumental"
      ],
      "cartelas": [
        "en"
      ]
    },
    "qualidades": [
      "SD"
    ],
    "avaliacao": {
      "media": 4.2,
      "votos": 8450
    },
    "acervo": {
      "fonte": "Internet Archive",
      "identificador": "ThePhantomoftheOpera",
      "arquivo": "Phantom_of_the_Opera_512kb.mp4"
    },
    "disponivel_em": [
      "BR",
      "PT",
      "US"
    ]
  },
  {
    "_id": "t7",
    "titulo": "O Homem Mosca",
    "original": "Safety Last!",
    "tipo": "filme",
    "ano": 1923,
    "generos": [
      "Comédia"
    ],
    "classificacao": "L",
    "duracao_min": 74,
    "mudo": true,
    "sinopse": "Para impressionar a namorada, um vendedor promete escalar a fachada de um prédio — e acaba pendurado no famoso relógio.",
    "elenco": [
      {
        "nome": "Harold Lloyd",
        "personagem": "O rapaz"
      },
      {
        "nome": "Mildred Davis",
        "personagem": "A moça"
      }
    ],
    "direcao": [
      "Fred C. Newmeyer",
      "Sam Taylor"
    ],
    "pais": "EUA",
    "idiomas": {
      "audio": [
        "trilha instrumental"
      ],
      "cartelas": [
        "en"
      ]
    },
    "qualidades": [
      "SD",
      "HD"
    ],
    "avaliacao": {
      "media": 4.5,
      "votos": 7600
    },
    "acervo": {
      "fonte": "Internet Archive",
      "identificador": "SafetyLastHaroldLloyd1923.FullMovieexcellentQuality.",
      "arquivo": "Safety Last - Harold Lloyd 1923. Full movie,excellent quality..mp4"
    },
    "disponivel_em": [
      "BR",
      "PT",
      "US"
    ]
  },
  {
    "_id": "t8",
    "titulo": "Flash Gordon",
    "original": "Flash Gordon",
    "tipo": "seriado",
    "ano": 1936,
    "generos": [
      "Ficção científica",
      "Aventura"
    ],
    "classificacao": "L",
    "duracao_min": 76,
    "capitulos_originais": 13,
    "sinopse": "Flash, Dale e o Dr. Zarkov viajam ao planeta Mongo para impedir que o imperador Ming destrua a Terra. Versão em filme do seriado de cinema.",
    "elenco": [
      {
        "nome": "Buster Crabbe",
        "personagem": "Flash Gordon"
      },
      {
        "nome": "Jean Rogers",
        "personagem": "Dale Arden"
      },
      {
        "nome": "Charles Middleton",
        "personagem": "Imperador Ming"
      }
    ],
    "direcao": [
      "Frederick Stephani"
    ],
    "pais": "EUA",
    "idiomas": {
      "audio": [
        "en"
      ],
      "legendas": []
    },
    "qualidades": [
      "SD"
    ],
    "avaliacao": {
      "media": 4.0,
      "votos": 5120
    },
    "acervo": {
      "fonte": "Internet Archive",
      "identificador": "FlashGordonTheMovie",
      "arquivo": "FlashGordonTheMovie.mp4"
    },
    "disponivel_em": [
      "BR",
      "PT",
      "US"
    ]
  },
  {
    "_id": "t9",
    "titulo": "Curva do Destino",
    "original": "Detour",
    "tipo": "filme",
    "ano": 1945,
    "generos": [
      "Noir",
      "Suspense"
    ],
    "classificacao": "14",
    "duracao_min": 68,
    "sinopse": "Um pianista pega carona rumo a Los Angeles e, depois de uma morte acidental, se vê preso a uma mulher que conhece seu segredo.",
    "elenco": [
      {
        "nome": "Tom Neal",
        "personagem": "Al Roberts"
      },
      {
        "nome": "Ann Savage",
        "personagem": "Vera"
      }
    ],
    "direcao": [
      "Edgar G. Ulmer"
    ],
    "pais": "EUA",
    "idiomas": {
      "audio": [
        "en"
      ],
      "legendas": []
    },
    "qualidades": [
      "SD"
    ],
    "avaliacao": {
      "media": 4.1,
      "votos": 6930
    },
    "acervo": {
      "fonte": "Internet Archive",
      "identificador": "detour-1945",
      "arquivo": "Detour 1945.mp4"
    },
    "disponivel_em": [
      "BR",
      "PT",
      "US"
    ]
  },
  {
    "_id": "t10",
    "titulo": "Viagem à Lua",
    "original": "Le Voyage dans la Lune",
    "tipo": "curta",
    "ano": 1902,
    "generos": [
      "Ficção científica",
      "Fantasia"
    ],
    "classificacao": "L",
    "duracao_min": 13,
    "mudo": true,
    "sinopse": "Astrônomos são lançados por um canhão gigante e o foguete acerta o olho da Lua, onde encontram os selenitas.",
    "elenco": [
      {
        "nome": "Georges Méliès",
        "personagem": "Prof. Barbenfouillis"
      }
    ],
    "direcao": [
      "Georges Méliès"
    ],
    "pais": "França",
    "idiomas": {
      "audio": [
        "trilha instrumental"
      ],
      "cartelas": []
    },
    "qualidades": [
      "SD",
      "HD"
    ],
    "avaliacao": {
      "media": 4.6,
      "votos": 15400
    },
    "acervo": {
      "fonte": "Internet Archive",
      "identificador": "ATripToTheMoonGeorgeMelies",
      "arquivo": "A Trip to the Moon-George Méliès.mp4"
    },
    "disponivel_em": [
      "BR",
      "PT",
      "US"
    ]
  }
]);

// Índices: busca por texto e filtros mais usados
db.titulos.createIndex({ titulo: 'text', sinopse: 'text' }, { default_language: 'portuguese' });
db.titulos.createIndex({ generos: 1 });
db.titulos.createIndex({ 'elenco.nome': 1 });
db.titulos.createIndex({ ano: 1 });

print('Títulos inseridos: ' + db.titulos.countDocuments());
