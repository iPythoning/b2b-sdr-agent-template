# Template de Agente SDR B2B

> Transforme qualquer negócio de exportação B2B em uma máquina de vendas com IA em 5 minutos.

Um template open-source e pronto para produção para construir Representantes de Desenvolvimento de Vendas (SDRs) com IA que gerenciam o **pipeline de vendas completo** — desde a captura de leads até o fechamento de negócios — através de WhatsApp, Telegram e e-mail.

Construído com [OpenClaw](https://openclaw.dev), testado em batalha com empresas reais de exportação B2B.

**🌐 [English](./README.md) | [中文](./README.zh-CN.md) | [Español](./README.es.md) | [Français](./README.fr.md) | [العربية](./README.ar.md) | Português | [日本語](./README.ja.md) | [Русский](./README.ru.md)**

---

## Arquitetura: Sistema de Contexto em 7 Camadas

```
┌─────────────────────────────────────────────┐
│             Agente SDR com IA                │
├─────────────────────────────────────────────┤
│  IDENTITY.md   → Quem sou eu? Empresa, papel│
│  SOUL.md       → Personalidade, valores, regras│
│  AGENTS.md     → Workflow completo de vendas (8 estágios)│
│  USER.md       → Perfil do proprietário, ICP, pontuação│
│  HEARTBEAT.md  → Verificações automatizadas do pipeline│
│  MEMORY.md     → Arquitetura de memória em 3 níveis│
│  TOOLS.md      → CRM, canais, integrações   │
├─────────────────────────────────────────────┤
│  Skills        → Capacidades extensíveis    │
│  Product KB    → Catálogo de produtos       │
├─────────────────────────────────────────────┤
│  OpenClaw Gateway (WhatsApp / Telegram)     │
└─────────────────────────────────────────────┘
```

Cada camada é um arquivo Markdown que você personaliza para seu negócio. A IA lê todas as camadas em cada conversa, fornecendo contexto profundo sobre sua empresa, produtos e estratégia de vendas.

## Início Rápido

### Opção A: Usuários do OpenClaw (1 Comando)

Se você já tem o [OpenClaw](https://openclaw.dev) rodando:

```bash
clawhub install b2b-sdr-agent
```

Pronto. A skill instala o sistema completo de contexto em 7 camadas, delivery-queue e sdr-humanizer no seu workspace. Depois personalize:

```bash
# Edite os arquivos principais para seu negócio
vim ~/.openclaw/workspace/skills/b2b-sdr-agent/references/IDENTITY.md
vim ~/.openclaw/workspace/skills/b2b-sdr-agent/references/USER.md

# Ou copie para seu workspace principal
cp ~/.openclaw/workspace/skills/b2b-sdr-agent/references/*.md ~/.openclaw/workspace/
```

Substitua todos os `{{placeholders}}` com informações reais da sua empresa, e seu SDR com IA estará no ar.

### Opção B: Implementação Completa (5 Minutos)

#### 1. Clone & Configure

```bash
git clone https://github.com/iPythoning/b2b-sdr-agent-template.git
cd b2b-sdr-agent-template

# Edite os 7 arquivos do workspace para seu negócio
vim workspace/IDENTITY.md   # Informações da empresa, papel, pipeline
vim workspace/USER.md       # Seus produtos, ICP, concorrentes
vim workspace/SOUL.md       # Personalidade e regras da IA
```

#### 2. Configure o Deployment

```bash
cd deploy
cp config.sh.example config.sh
vim config.sh               # Preencha: IP do servidor, chave API, número WhatsApp
```

#### 3. Deploy

```bash
./deploy.sh minha-empresa

# Saída:
# ✅ Deploy Completo: minha-empresa
# Gateway:  ws://seu-servidor:18789
# WhatsApp: Habilitado
# Skills:   b2b_trade (28 skills)
```

É isso. Seu SDR com IA está ativo no WhatsApp e pronto para vender.

## O Que Ele Faz

### Automação de Vendas em Pipeline Completo

| Estágio | O Que a IA Faz |
|---------|----------------|
| **Captura de Leads** | Auto-detecta mensagens recebidas, cria registros no CRM, extrai informações-chave |
| **Qualificação BANT** | Conversa natural para avaliar Budget (Orçamento), Authority (Autoridade), Need (Necessidade), Timeline (Prazo) |
| **Pesquisa** | Busca empresa do prospect, LinkedIn, notícias — atualiza pontuação ICP |
| **Cotação** | Gera orçamentos, envia para aprovação do proprietário, entrega ao cliente |
| **Negociação** | Rastreia contra-propostas, recomenda estratégia, escala quando necessário |
| **Relatórios** | Relatórios diários do pipeline, alertas de leads parados, resumos semanais |
| **Nutrição** | Follow-ups automatizados, notícias do setor, cuidado pós-venda |

### Conversas Humanizadas

- Responde no idioma do cliente (auto-detectado)
- Ritmo natural de mensagens com a skill delivery-queue
- Adaptação cultural (Oriente Médio, África, Sudeste Asiático, América Latina, Europa)
- Nunca revela identidade de IA — se apresenta como seu consultor de vendas

### Memória Inteligente

- **Hot memory**: Contexto da empresa carregado em cada sessão
- **Warm memory**: Logs de conversas diárias, carregados sob demanda
- **Cold memory**: Insights arquivados, pesquisáveis via banco de dados vetorial

## As 7 Camadas Explicadas

| Camada | Arquivo | Propósito |
|--------|---------|-----------|
| **Identity** | `IDENTITY.md` | Informações da empresa, definição de papel, estágios do pipeline, classificação de leads |
| **Soul** | `SOUL.md` | Personalidade da IA, estilo de comunicação, regras rígidas, mentalidade de crescimento |
| **Agents** | `AGENTS.md` | Workflow de vendas em 8 estágios, qualificação BANT, política de segurança |
| **User** | `USER.md` | Perfil do proprietário, linhas de produtos, pontuação ICP, concorrentes |
| **Heartbeat** | `HEARTBEAT.md` | Inspeção automatizada do pipeline — novos leads, negócios parados, qualidade de dados |
| **Memory** | `MEMORY.md` | Arquitetura de memória em 3 níveis, princípios de eficácia do SDR |
| **Tools** | `TOOLS.md` | Comandos CRM, configuração de canais, pesquisa web, acesso a e-mail |

## Skills

Capacidades pré-construídas que estendem seu SDR com IA:

| Skill | Descrição |
|-------|-----------|
| **delivery-queue** | Agenda mensagens com atrasos humanizados. Campanhas gotejamento, follow-ups programados. |
| **supermemory** | Motor de memória semântica. Auto-captura insights de clientes, busca em todas as conversas. |
| **sdr-humanizer** | Regras para conversa natural — ritmo, adaptação cultural, anti-padrões. |

### Perfis de Skills

Escolha um conjunto de skills pré-configurado baseado em suas necessidades:

| Perfil | Skills | Melhor Para |
|--------|--------|-------------|
| `b2b_trade` | 28 skills | Empresas de exportação B2B (padrão) |
| `lite` | 16 skills | Começando, baixo volume |
| `social` | 14 skills | Vendas focadas em mídias sociais |
| `full` | 40+ skills | Tudo habilitado |

## Exemplos por Indústria

Configurações prontas para uso para verticais comuns de exportação B2B:

| Indústria | Diretório | Destaques |
|-----------|-----------|-----------|
| **Veículos Pesados** | `examples/heavy-vehicles/` | Caminhões, maquinário, vendas de frotas, mercados África/Oriente Médio |
| **Eletrônicos de Consumo** | `examples/electronics/` | OEM/ODM, vendedores Amazon, vendas por amostra |
| **Têxteis & Vestuário** | `examples/textiles/` | Tecidos sustentáveis, certificação GOTS, mercados EU/EUA |

Para usar um exemplo, copie-o para seu workspace:

```bash
cp examples/heavy-vehicles/IDENTITY.md workspace/IDENTITY.md
cp examples/heavy-vehicles/USER.md workspace/USER.md
# Depois personalize para seu negócio específico
```

## Base de Conhecimento de Produtos

Estruture seu catálogo de produtos para que a IA possa gerar orçamentos precisos:

```
product-kb/
├── catalog.json                    # Catálogo de produtos com especificações, MOQ, prazos
├── products/
│   └── example-product/info.json   # Informações detalhadas do produto
└── scripts/
    └── generate-pi.js              # Gerador de fatura proforma
```

## Deployment

### Pré-requisitos

- Um servidor Linux (Ubuntu 20.04+ recomendado)
- Node.js 18+
- Uma chave de API de modelo de IA (OpenAI, Anthropic, Google, Kimi, etc.)
- Conta WhatsApp Business (opcional mas recomendado)

### Configuração

Toda a configuração está em `deploy/config.sh`. Seções principais:

```bash
# Servidor
SERVER_HOST="ip-do-seu-servidor"

# Modelo de IA
PRIMARY_API_KEY="sk-..."

# Canais
WHATSAPP_ENABLED=true
TELEGRAM_BOT_TOKEN="..."

# CRM
SHEETS_SPREADSHEET_ID="seu-id-google-sheets"

# Admin (quem pode gerenciar a IA)
ADMIN_PHONES="+1234567890"
```

### Deployment Gerenciado

Não quer hospedar você mesmo? **[PulseAgent](https://ai.pulseagent.io)** oferece agentes SDR B2B totalmente gerenciados com:

- Deployment com um clique
- Dashboard & analytics
- Gerenciamento multi-canal
- Suporte prioritário

[Comece Agora →](https://ai.pulseagent.io)

## Contribuindo

Contribuições são bem-vindas! Áreas onde adoraríamos ajuda:

- **Templates de indústria**: Adicione exemplos para sua indústria
- **Skills**: Construa novas capacidades
- **Traduções**: Traduza templates do workspace para outros idiomas
- **Documentação**: Melhore guias e tutoriais

## Licença

MIT — use para qualquer coisa.

---

<p align="center">
  Feito com ❤️ por <a href="https://ai.pulseagent.io">PulseAgent</a><br/>
  <em>Context as a Service — AI SDR para Exportação B2B</em>
</p>
