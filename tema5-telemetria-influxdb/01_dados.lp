# =========================================================
# StreamLab · Tema 5 — Telemetria de Reprodução, Buffer e Métricas de Stream
# Banco de série temporal (InfluxDB 2) — formato Line Protocol
# Importar: influx write --bucket streamlab --precision s --file 01_dados.lp
#
# measurement,tags campos timestamp
#  tags   (indexadas): perfil, titulo, dispositivo, regiao, cdn
#  campos (valores)  : bitrate_kbps, buffer_ms, rebuffer, fps, inicio_ms, erro
# Uma amostra a cada 10 s de três sessões na noite de 18/11/2026 (20:00 BRT = 23:00 UTC)
# =========================================================
reproducao,perfil=1,titulo=t1,dispositivo=smart_tv,regiao=sudeste,cdn=sp1 bitrate_kbps=15200i,buffer_ms=8200i,rebuffer=0i,fps=60i,inicio_ms=1100i,erro=0i 1795042800
reproducao,perfil=1,titulo=t1,dispositivo=smart_tv,regiao=sudeste,cdn=sp1 bitrate_kbps=15600i,buffer_ms=9100i,rebuffer=0i,fps=60i,inicio_ms=0i,erro=0i 1795042810
reproducao,perfil=1,titulo=t1,dispositivo=smart_tv,regiao=sudeste,cdn=sp1 bitrate_kbps=15800i,buffer_ms=9600i,rebuffer=0i,fps=60i,inicio_ms=0i,erro=0i 1795042820
reproducao,perfil=1,titulo=t1,dispositivo=smart_tv,regiao=sudeste,cdn=sp1 bitrate_kbps=14100i,buffer_ms=6400i,rebuffer=0i,fps=60i,inicio_ms=0i,erro=0i 1795042830
reproducao,perfil=1,titulo=t1,dispositivo=smart_tv,regiao=sudeste,cdn=sp1 bitrate_kbps=15900i,buffer_ms=9800i,rebuffer=0i,fps=60i,inicio_ms=0i,erro=0i 1795042840
reproducao,perfil=1,titulo=t1,dispositivo=smart_tv,regiao=sudeste,cdn=sp1 bitrate_kbps=16000i,buffer_ms=10000i,rebuffer=0i,fps=60i,inicio_ms=0i,erro=0i 1795042850
reproducao,perfil=4,titulo=t8,dispositivo=celular,regiao=nordeste,cdn=for1 bitrate_kbps=3100i,buffer_ms=4100i,rebuffer=0i,fps=30i,inicio_ms=2400i,erro=0i 1795042800
reproducao,perfil=4,titulo=t8,dispositivo=celular,regiao=nordeste,cdn=for1 bitrate_kbps=2200i,buffer_ms=1500i,rebuffer=0i,fps=30i,inicio_ms=0i,erro=0i 1795042810
reproducao,perfil=4,titulo=t8,dispositivo=celular,regiao=nordeste,cdn=for1 bitrate_kbps=900i,buffer_ms=0i,rebuffer=1i,fps=24i,inicio_ms=0i,erro=0i 1795042820
reproducao,perfil=4,titulo=t8,dispositivo=celular,regiao=nordeste,cdn=for1 bitrate_kbps=1400i,buffer_ms=1200i,rebuffer=0i,fps=30i,inicio_ms=0i,erro=0i 1795042830
reproducao,perfil=4,titulo=t8,dispositivo=celular,regiao=nordeste,cdn=for1 bitrate_kbps=800i,buffer_ms=0i,rebuffer=1i,fps=24i,inicio_ms=0i,erro=0i 1795042840
reproducao,perfil=4,titulo=t8,dispositivo=celular,regiao=nordeste,cdn=for1 bitrate_kbps=2600i,buffer_ms=3200i,rebuffer=0i,fps=30i,inicio_ms=0i,erro=0i 1795042850
reproducao,perfil=3,titulo=t10,dispositivo=notebook,regiao=sul,cdn=poa1 bitrate_kbps=7800i,buffer_ms=7000i,rebuffer=0i,fps=60i,inicio_ms=1600i,erro=0i 1795042800
reproducao,perfil=3,titulo=t10,dispositivo=notebook,regiao=sul,cdn=poa1 bitrate_kbps=8200i,buffer_ms=7600i,rebuffer=0i,fps=60i,inicio_ms=0i,erro=0i 1795042810
reproducao,perfil=3,titulo=t10,dispositivo=notebook,regiao=sul,cdn=poa1 bitrate_kbps=8100i,buffer_ms=7900i,rebuffer=0i,fps=60i,inicio_ms=0i,erro=0i 1795042820
reproducao,perfil=3,titulo=t10,dispositivo=notebook,regiao=sul,cdn=poa1 bitrate_kbps=6900i,buffer_ms=5200i,rebuffer=0i,fps=60i,inicio_ms=0i,erro=1i 1795042830
reproducao,perfil=3,titulo=t10,dispositivo=notebook,regiao=sul,cdn=poa1 bitrate_kbps=8000i,buffer_ms=7400i,rebuffer=0i,fps=60i,inicio_ms=0i,erro=0i 1795042840
reproducao,perfil=3,titulo=t10,dispositivo=notebook,regiao=sul,cdn=poa1 bitrate_kbps=8300i,buffer_ms=8000i,rebuffer=0i,fps=60i,inicio_ms=0i,erro=0i 1795042850
eventos,perfil=1,titulo=t1,tipo=play valor=1i 1795042800
eventos,perfil=4,titulo=t8,tipo=play valor=1i 1795042800
eventos,perfil=3,titulo=t10,tipo=play valor=1i 1795042800
eventos,perfil=4,titulo=t8,tipo=troca_qualidade valor=1i 1795042820
eventos,perfil=3,titulo=t10,tipo=pausa valor=1i 1795042850
