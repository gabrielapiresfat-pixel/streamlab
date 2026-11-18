// =========================================================
// StreamLab · Tema 5 — consultas Flux (InfluxDB 2)
// Rode no Data Explorer (Script Editor) do InfluxDB ou com: influx query -f 02_consultas.flux
// Janela dos dados: 18/11/2026 23:00 a 23:01 UTC (20:00 a 20:01 em Brasília)
// =========================================================
inicio = 2026-11-18T23:00:00Z
fim    = 2026-11-18T23:05:00Z

// 1. Bitrate médio de cada sessão (perfil + título)
from(bucket: "streamlab")
  |> range(start: inicio, stop: fim)
  |> filter(fn: (r) => r._measurement == "reproducao" and r._field == "bitrate_kbps")
  |> group(columns: ["perfil", "titulo", "dispositivo"])
  |> mean()
  |> yield(name: "1_bitrate_medio")

// 2. Bitrate médio por região em janelas de 20 segundos (gráfico de linha)
from(bucket: "streamlab")
  |> range(start: inicio, stop: fim)
  |> filter(fn: (r) => r._measurement == "reproducao" and r._field == "bitrate_kbps")
  |> group(columns: ["regiao"])
  |> aggregateWindow(every: 20s, fn: mean, createEmpty: false)
  |> yield(name: "2_bitrate_por_regiao")

// 3. Total de travadas (rebuffer) por região — o principal indicador de qualidade
from(bucket: "streamlab")
  |> range(start: inicio, stop: fim)
  |> filter(fn: (r) => r._measurement == "reproducao" and r._field == "rebuffer")
  |> group(columns: ["regiao"])
  |> sum()
  |> yield(name: "3_rebuffer_por_regiao")

// 4. Momentos em que o buffer zerou (vídeo parado esperando carregar)
from(bucket: "streamlab")
  |> range(start: inicio, stop: fim)
  |> filter(fn: (r) => r._measurement == "reproducao" and r._field == "buffer_ms" and r._value == 0)
  |> keep(columns: ["_time", "perfil", "titulo", "regiao", "cdn"])
  |> yield(name: "4_buffer_zerado")

// 5. Tempo para começar o vídeo (inicio_ms) por dispositivo
from(bucket: "streamlab")
  |> range(start: inicio, stop: fim)
  |> filter(fn: (r) => r._measurement == "reproducao" and r._field == "inicio_ms" and r._value > 0)
  |> group(columns: ["dispositivo"])
  |> max()
  |> yield(name: "5_tempo_inicio")

// 6. Percentil 95 do bitrate na plataforma inteira
from(bucket: "streamlab")
  |> range(start: inicio, stop: fim)
  |> filter(fn: (r) => r._measurement == "reproducao" and r._field == "bitrate_kbps")
  |> group()
  |> quantile(q: 0.95, method: "estimate_tdigest")
  |> yield(name: "6_p95_bitrate")

// 7. Qualidade por CDN: bitrate mínimo e máximo (detecta servidor com problema)
dados = from(bucket: "streamlab")
  |> range(start: inicio, stop: fim)
  |> filter(fn: (r) => r._measurement == "reproducao" and r._field == "bitrate_kbps")
  |> group(columns: ["cdn"])
dados |> min() |> yield(name: "7_bitrate_min_por_cdn")
dados |> max() |> yield(name: "7_bitrate_max_por_cdn")

// 8. Erros de reprodução por título
from(bucket: "streamlab")
  |> range(start: inicio, stop: fim)
  |> filter(fn: (r) => r._measurement == "reproducao" and r._field == "erro")
  |> group(columns: ["titulo"])
  |> sum()
  |> yield(name: "8_erros_por_titulo")

// 9. Contagem de eventos por tipo (play, pausa, troca de qualidade)
from(bucket: "streamlab")
  |> range(start: inicio, stop: fim)
  |> filter(fn: (r) => r._measurement == "eventos")
  |> group(columns: ["tipo"])
  |> count()
  |> yield(name: "9_eventos_por_tipo")

// 10. Alerta: sessões com bitrate médio abaixo de 2.000 kbps (experiência ruim)
from(bucket: "streamlab")
  |> range(start: inicio, stop: fim)
  |> filter(fn: (r) => r._measurement == "reproducao" and r._field == "bitrate_kbps")
  |> group(columns: ["perfil", "titulo", "regiao"])
  |> mean()
  |> filter(fn: (r) => r._value < 2000.0)
  |> yield(name: "10_sessoes_ruins")
