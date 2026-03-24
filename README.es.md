# B2B SDR Agent Template

> Convierte cualquier negocio de exportación B2B en una máquina de ventas impulsada por IA en 5 minutos.

Una plantilla de código abierto, lista para producción, para construir Representantes de Desarrollo de Ventas (SDR) con IA que manejan el **pipeline de ventas completo** — desde la captura de leads hasta el cierre de tratos — a través de WhatsApp, Telegram y email.

Construido sobre [OpenClaw](https://openclaw.dev), probado en batalla con empresas reales de exportación B2B.

**🌐 [English](./README.md) | [中文](./README.zh-CN.md) | Español | [Français](./README.fr.md) | [العربية](./README.ar.md) | [Português](./README.pt-BR.md) | [日本語](./README.ja.md) | [Русский](./README.ru.md)**

---

## Arquitectura: Sistema de Contexto de 7 Capas

```
┌─────────────────────────────────────────────────┐
│              Agente SDR con IA                   │
├─────────────────────────────────────────────────┤
│  IDENTITY.md   → ¿Quién soy? Empresa, rol       │
│  SOUL.md       → Personalidad, valores, reglas   │
│  AGENTS.md     → Flujo de ventas completo (10 etapas)│
│  USER.md       → Perfil del propietario, ICP, puntuación│
│  HEARTBEAT.md  → Inspección del pipeline de 10 puntos│
│  MEMORY.md     → Arquitectura de memoria de 3 motores│
│  TOOLS.md      → CRM, canales, integraciones     │
├─────────────────────────────────────────────────┤
│  Skills        → Capacidades extensibles         │
│  Product KB    → Tu catálogo de productos        │
│  Cron Jobs     → 10 tareas programadas automáticas│
├─────────────────────────────────────────────────┤
│  OpenClaw Gateway (WhatsApp / Telegram / Email)  │
└─────────────────────────────────────────────────┘
```

Cada capa es un archivo Markdown que personalizas para tu negocio. La IA lee todas las capas en cada conversación, dándole un contexto profundo sobre tu empresa, productos y estrategia de ventas.

## Inicio Rápido

### Opción A: Usuarios de OpenClaw (1 Comando)

Si ya tienes [OpenClaw](https://openclaw.dev) en ejecución:

```bash
clawhub install b2b-sdr-agent
```

Listo. La skill instala el sistema completo de contexto de 7 capas, delivery-queue y sdr-humanizer en tu espacio de trabajo. Luego personaliza:

```bash
# Edita los archivos clave para tu negocio
vim ~/.openclaw/workspace/skills/b2b-sdr-agent/references/IDENTITY.md
vim ~/.openclaw/workspace/skills/b2b-sdr-agent/references/USER.md

# O copia a tu espacio de trabajo principal
cp ~/.openclaw/workspace/skills/b2b-sdr-agent/references/*.md ~/.openclaw/workspace/
```

Reemplaza todos los `{{placeholders}}` con la información real de tu empresa, y tu SDR con IA estará en vivo.

### Opción B: Despliegue Completo (5 Minutos)

#### 1. Clonar y Configurar

```bash
git clone https://github.com/iPythoning/b2b-sdr-agent-template.git
cd b2b-sdr-agent-template

# Edita los 7 archivos del espacio de trabajo para tu negocio
vim workspace/IDENTITY.md   # Información de la empresa, rol, pipeline
vim workspace/USER.md       # Tus productos, ICP, competidores
vim workspace/SOUL.md       # Personalidad y reglas de la IA
```

#### 2. Configurar el Despliegue

```bash
cd deploy
cp config.sh.example config.sh
vim config.sh               # Completa: IP del servidor, clave API, número de WhatsApp
```

#### 3. Desplegar

```bash
./deploy.sh my-company

# Salida:
# ✅ Deploy Complete: my-company
# Gateway:  ws://your-server:18789
# WhatsApp: Enabled
# Skills:   b2b_trade (28 skills)
```

Eso es todo. Tu SDR con IA está en vivo en WhatsApp y listo para vender.

## Lo Que Hace

### Automatización de Ventas de Pipeline Completo (10 Etapas)

| Etapa | Lo Que Hace la IA |
|-------|------------------|
| **1. Captura de Leads** | Auto-detecta mensajes entrantes (WhatsApp/Telegram/anuncios CTWA), crea registros en CRM |
| **2. Calificación BANT** | Conversación natural para evaluar Budget, Authority, Need, Timeline |
| **3. Registro CRM** | Captura de datos estructurados — nombre, empresa, país, puntuación ICP, interés de producto |
| **4. Investigación y Enriquecimiento** | Búsqueda web con Jina AI + análisis de sitio web de la empresa, pipeline de enriquecimiento de 3 capas |
| **5. Cotización** | Genera cotizaciones PDF automáticas, multi-idioma, envía al propietario para aprobación |
| **6. Negociación** | Rastrea contraofertas, recomienda estrategia, escala cuando es necesario |
| **7. Reportes** | Reportes diarios del pipeline a las 09:00, alertas de estancamiento a las 15:00, resúmenes semanales |
| **8. Nutrición** | Seguimientos automatizados, noticias de la industria, cuidado post-venta, revisiones trimestrales |
| **9. Email Outreach** | Secuencias de email en frío personalizadas (Día 1/3/7/14), seguimiento automático |
| **10. Orquestación Multicanal** | Coordinación entre canales (WhatsApp + Email + Telegram), cambio automático |

### Programación Automatizada (10 Cron Jobs)

| Horario | Tarea |
|---------|-------|
| Cada 30 min | Escaneo de bandeja de entrada Gmail para respuestas de clientes |
| Diario 09:00 | Reporte del pipeline al propietario vía WhatsApp |
| Diario 10:00 | Descubrimiento de leads con IA (rotación de mercados: África/ME/SEA/LatAm) |
| Diario 11:00 | Verificación de secuencia de seguimiento por email |
| Diario 15:00 | Detección de leads estancados |
| Semanal Mié | Campaña de nutrición |
| Semanal Vie | Recopilación de inteligencia de competidores |
| Semanal Lun | Reporte resumen semanal |

### Conversaciones Similares a Humanos
- Responde en el idioma del cliente (auto-detectado)
- Ritmo natural de mensajes con la skill delivery-queue (retrasos de 3-90s, división de mensajes)
- Envío consciente de zona horaria (7 mapeos de zonas horarias de mercados)
- Adaptación cultural (Medio Oriente, África, SEA, LatAm, Europa)
- Nunca revela identidad de IA — se presenta como tu consultor de ventas

### Puntuación ICP Dinámica
- Puntuación inicial basada en 5 dimensiones ponderadas (volumen de compra, coincidencia de producto, región, capacidad de pago, autoridad)
- **Se auto-ajusta** según la interacción: respuesta rápida +1, pide cotización +2, menciona competidor +2, 7d sin respuesta -1
- Leads calientes (ICP>=7) marcados automáticamente, propietario notificado de inmediato

### Memoria Inteligente (3 Motores)
- **Supermemory**: Notas de investigación, inteligencia de competidores, insights de mercado — consultado antes del contacto
- **MemoryLake**: Contexto de sesión, resúmenes de conversaciones — recuperado automáticamente por conversación
- **MemOS Cloud**: Patrones de comportamiento entre sesiones — capturado automáticamente

## Las 7 Capas Explicadas

| Capa | Archivo | Propósito |
|------|---------|-----------|
| **Identity** | `IDENTITY.md` | Información de la empresa, definición de rol, etapas del pipeline, niveles de leads |
| **Soul** | `SOUL.md` | Personalidad de IA, estilo de comunicación, reglas estrictas, mentalidad de crecimiento |
| **Agents** | `AGENTS.md` | Flujo de ventas de 10 etapas, calificación BANT, orquestación multicanal |
| **User** | `USER.md` | Perfil del propietario, líneas de productos, puntuación ICP, competidores |
| **Heartbeat** | `HEARTBEAT.md` | Inspección automática del pipeline — nuevos leads, tratos estancados, calidad de datos |
| **Memory** | `MEMORY.md` | Arquitectura de memoria de 3 niveles, principios de efectividad SDR |
| **Tools** | `TOOLS.md` | Comandos CRM, configuración de canales, investigación web, acceso a email |

## Skills

Capacidades preconstruidas que extienden tu SDR con IA:

| Skill | Descripción |
|-------|-------------|
| **delivery-queue** | Programa mensajes con retrasos similares a humanos. Campañas de goteo, seguimientos programados. |
| **supermemory** | Motor de memoria semántica. Auto-captura insights de clientes, busca en todas las conversaciones. |
| **sdr-humanizer** | Reglas para conversación natural — ritmo, adaptación cultural, anti-patrones. |
| **lead-discovery** | Descubrimiento de leads impulsado por IA. Búsqueda web de compradores potenciales, evaluación ICP, entrada automática en CRM. |
| **quotation-generator** | Genera automáticamente facturas proforma en PDF con membrete de empresa, soporte multi-idioma. |

### Perfiles de Skills

Elige un conjunto de skills preconfigurado según tus necesidades:

| Perfil | Skills | Mejor Para |
|---------|--------|------------|
| `b2b_trade` | 28 skills | Empresas de exportación B2B (predeterminado) |
| `lite` | 16 skills | Empezar, bajo volumen |
| `social` | 14 skills | Ventas enfocadas en redes sociales |
| `full` | 40+ skills | Todo habilitado |

## Ejemplos por Industria

Configuraciones listas para usar para verticales comunes de exportación B2B:

| Industria | Directorio | Destacados |
|-----------|------------|------------|
| **Vehículos Pesados** | `examples/heavy-vehicles/` | Camiones, maquinaria, ventas de flotas, mercados africanos/ME |
| **Electrónica de Consumo** | `examples/electronics/` | OEM/ODM, vendedores de Amazon, ventas basadas en muestras |
| **Textiles y Confección** | `examples/textiles/` | Telas sustentables, certificado GOTS, mercados UE/EE.UU. |

Para usar un ejemplo, cópialo en tu espacio de trabajo:

```bash
cp examples/heavy-vehicles/IDENTITY.md workspace/IDENTITY.md
cp examples/heavy-vehicles/USER.md workspace/USER.md
# Luego personaliza para tu negocio específico
```

## Base de Conocimiento de Productos

Estructura tu catálogo de productos para que la IA pueda generar cotizaciones precisas:

```
product-kb/
├── catalog.json                    # Catálogo de productos con specs, MOQ, tiempos de entrega
├── products/
│   └── example-product/info.json   # Información detallada del producto
└── scripts/
    └── generate-pi.js              # Generador de factura proforma
```

## Despliegue

### Prerrequisitos
- Un servidor Linux (Ubuntu 20.04+ recomendado)
- Node.js 18+
- Una clave API de modelo de IA (OpenAI, Anthropic, Google, Kimi, etc.)
- Cuenta de WhatsApp Business (opcional pero recomendado)

### Configuración

Toda la configuración está en `deploy/config.sh`. Secciones clave:

```bash
# Servidor
SERVER_HOST="your-server-ip"

# Modelo de IA
PRIMARY_API_KEY="sk-..."

# Canales
WHATSAPP_ENABLED=true
TELEGRAM_BOT_TOKEN="..."

# CRM
SHEETS_SPREADSHEET_ID="your-google-sheets-id"

# Admin (quién puede gestionar la IA)
ADMIN_PHONES="+1234567890"
```

### Despliegue Gestionado

¿No quieres auto-hospedar? **[PulseAgent](https://ai.pulseagent.io)** ofrece agentes SDR B2B completamente gestionados con:
- Despliegue con un clic
- Dashboard y analíticas
- Gestión multicanal
- Soporte prioritario

[Comenzar →](https://ai.pulseagent.io)

## Contribuciones

¡Las contribuciones son bienvenidas! Áreas donde nos encantaría ayuda:

- **Plantillas de industria**: Agrega ejemplos para tu industria
- **Skills**: Construye nuevas capacidades
- **Traducciones**: Traduce plantillas del espacio de trabajo a otros idiomas
- **Documentación**: Mejora guías y tutoriales

## Licencia

MIT — úsalo para cualquier cosa.

---

<p align="center">
  Hecho con ❤️ por <a href="https://ai.pulseagent.io">PulseAgent</a><br/>
  <em>Context as a Service — AI SDR para Exportación B2B</em>
</p>
