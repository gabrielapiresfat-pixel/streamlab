# Tema 3 — Gestão de Sessões, Tokens e Cache (Redis)

## Chaves usadas
| Chave | Tipo | Para quê | Expira |
|---|---|---|---|
| `sessao:<token>` | HASH | dados da sessão de login | 2 h |
| `conta:<id>:sessoes` | SET | tokens ativos da conta (limite de telas) | — |
| `reset:<email>` | STRING | token de recuperação de senha (uso único) | 15 min |
| `tentativas:login:<ip>` | STRING (contador) | bloquear mais de 5 tentativas por minuto | 1 min |
| `cache:home:perfil:<id>` | STRING (JSON) | tela inicial pronta | 5 min |
| `continuar:perfil:<id>` | ZSET | onde parou em cada título (score = segundos) | — |
| `top:<data>` | ZSET | ranking do dia (ZINCRBY a cada play) | 2 dias |

## Como rodar
```bash
grep -v '^#' comandos.redis | redis-cli
```
(o `redis-cli` não aceita linhas de comentário; o `grep` remove). Também dá para colar os comandos no **Redis Insight** ou num banco grátis do **Redis Cloud**.

## Ideias principais
- **TTL** (`EXPIRE`, `SET ... EX`): a sessão e o cache somem sozinhos.
- **NX**: o token de senha não é sobrescrito enquanto estiver válido.
- **Logout** apaga a sessão e tira o token do SET da conta; "sair de todos" apaga todos.
- Em produção, listar chaves com `SCAN`, nunca `KEYS`.
