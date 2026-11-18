# Tema 5 — Telemetria de Reprodução, Buffer e Métricas (InfluxDB)

## Modelo
- **measurement** `reproducao` — uma medição a cada 10 s por sessão
  - tags (indexadas): `perfil`, `titulo`, `dispositivo`, `regiao`, `cdn`
  - campos: `bitrate_kbps`, `buffer_ms`, `rebuffer`, `fps`, `inicio_ms`, `erro`
- **measurement** `eventos` — play, pausa, troca de qualidade

Dados: 3 sessões na noite de 18/11/2026 (20:00 em Brasília = 23:00 UTC), com perfis e títulos dos outros temas.

## Como rodar
1. Crie um bucket `streamlab` no **InfluxDB 2** (local ou InfluxDB Cloud grátis).
2. Importe os dados: `influx write --bucket streamlab --precision s --file 01_dados.lp`
3. Rode as consultas: `influx query -f 02_consultas.flux` (ou cole no Script Editor do Data Explorer).

## Consultas (Flux)
1. Bitrate médio por sessão · 2. Bitrate por região em janelas de 20 s ·
3. Travadas (rebuffer) por região → Nordeste: 2 · 4. Momentos com buffer zerado ·
5. Tempo para começar por dispositivo · 6. Percentil 95 do bitrate ·
7. Bitrate mínimo e máximo por CDN · 8. Erros por título ·
9. Eventos por tipo · 10. Alerta de sessões abaixo de 2.000 kbps → Ju no celular (média 1.833 kbps)
