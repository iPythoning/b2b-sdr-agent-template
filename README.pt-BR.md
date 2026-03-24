# Template de Agente SDR B2B

> Transforme qualquer negócio de exportação B2B em uma máquina de vendas com IA em 5 minutos.

Um template open-source e pronto para produção para construir Representantes de Desenvolvimento de Vendas (SDRs) com IA que gerenciam o **pipeline de vendas completo** — desde a captura de leads até o fechamento de negócios — através de WhatsApp, Telegram e e-mail.

Construído com [OpenClaw](https://openclaw.dev), testado em batalha com empresas reais de exportação B2B.

**🌐 [English](./README.md) | [中文](./README.zh-CN.md) | [Español](./README.es.md) | [Français](./README.fr.md) | [العربية](./README.ar.md) | Português | [日本語](./README.ja.md) | [Русский](./README.ru.md)**

---

## Arquitetura: Sistema de Contexto em 7 Camadas

```
┌─────────────────────────────────────────────────┐
│              Agente SDR com IA                   │
├─────────────────────────────────────────────────┤
│  IDENTITY.md   → Quem sou eu? Empresa, papel     │
│  SOUL.md       → Personalidade, valores, regras   │
│  AGENTS.md     → Workflow completo de vendas (10 estágios)│
│  USER.md       → Perfil do proprietário, ICP, pontuação│
│  HEARTBEAT.md  → Inspeção do pipeline em 10 pontos│
│  MEMORY.md     → Arquitetura de memória com 3 motores│
│  TOOLS.md      → CRM, canais, integrações         │
├─────────────────────────────────────────────────┤
│  Skills        → Capacidades extensíveis          │
│  Product KB    → Catálogo de produtos             │
│  Cron Jobs     → 10 tarefas agendadas automáticas │
├─────────────────────────────────────────────────┤
│  OpenClaw Gateway (WhatsApp / Telegram / Email)  │
└─────────────────────────────────────────────────┘
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

### Automação de Vendas em Pipeline Completo (10 Estágios)

| Estágio | O Que a IA Faz |
|---------|----------------|
| **1. Captura de Leads** | Auto-detecta mensagens recebidas (WhatsApp/Telegram/anúncios CTWA), cria registros no CRM |
| **2. Qualificação BANT** | Conversa natural para avaliar Budget (Orçamento), Authority (Autoridade), Need (Necessidade), Timeline (Prazo) |
| **3. Registro CRM** | Captura de dados estruturados — nome, empresa, país, pontuação ICP, interesse em produto |
| **4. Pesquisa e Enriquecimento** | Busca web com Jina AI + análise do site da empresa, pipeline de enriquecimento em 3 camadas |
| **5. Cotação** | Gera orçamentos PDF automáticos, multi-idioma, envia para aprovação do proprietário |
| **6. Negociação** | Rastreia contra-propostas, recomenda estratégia, escala quando necessário |
| **7. Relatórios** | Relatórios diários do pipeline às 09:00, alertas de estagnação às 15:00, resumos semanais |
| **8. Nutrição** | Follow-ups automatizados, notícias do setor, cuidado pós-venda, check-ins trimestrais |
| **9. Email Outreach** | Sequências de email frio personalizadas (Dia 1/3/7/14), follow-up automático |
| **10. Orquestração Multicanal** | Coordenação entre canais (WhatsApp + Email + Telegram), troca automática |

### Agendamento Automatizado (10 Cron Jobs)

| Horário | Tarefa |
|---------|--------|
| A cada 30 min | Scan da caixa de entrada Gmail para respostas de clientes |
| Diário 09:00 | Relatório do pipeline para o proprietário via WhatsApp |
| Diário 10:00 | Descoberta de leads com IA (rotação de mercados: África/OM/ASE/LatAm) |
| Diário 11:00 | Verificação da sequência de follow-up por email |
| Diário 15:00 | Detecção de leads parados |
| Semanal Qua | Campanha de nutrição |
| Semanal Sex | Coleta de inteligência competitiva |
| Semanal Seg | Relatório resumo semanal |

### Conversas Humanizadas

- Responde no idioma do cliente (auto-detectado)
- Ritmo natural de mensagens com a skill delivery-queue (atrasos de 3-90s, divisão de mensagens)
- Envio com consciência de fuso horário (7 mapeamentos de fusos horários de mercados)
- Adaptação cultural (Oriente Médio, África, Sudeste Asiático, América Latina, Europa)
- Nunca revela identidade de IA — se apresenta como seu consultor de vendas

### Pontuação ICP Dinâmica

- Pontuação inicial baseada em 5 dimensões ponderadas (volume de compra, adequação do produto, região, capacidade de pagamento, autoridade)
- **Auto-ajusta** com base na interação: resposta rápida +1, pede cotação +2, menciona concorrente +2, 7d sem resposta -1
- Leads quentes (ICP>=7) sinalizados automaticamente, proprietário notificado imediatamente

### Memória Inteligente (3 Motores)

- **Supermemory**: Notas de pesquisa, inteligência competitiva, insights de mercado — consultado antes do contato
- **MemoryLake**: Contexto de sessão, resumos de conversas — recuperado automaticamente por conversa
- **MemOS Cloud**: Padrões de comportamento entre sessões — capturado automaticamente

## As 7 Camadas Explicadas

| Camada | Arquivo | Propósito |
|--------|---------|-----------|
| **Identity** | `IDENTITY.md` | Informações da empresa, definição de papel, estágios do pipeline, classificação de leads |
| **Soul** | `SOUL.md` | Personalidade da IA, estilo de comunicação, regras rígidas, mentalidade de crescimento |
| **Agents** | `AGENTS.md` | Workflow de vendas em 10 estágios, qualificação BANT, orquestração multicanal |
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
| **lead-discovery** | Descoberta de leads por IA. Busca web de compradores potenciais, avaliação ICP, entrada automática no CRM. |
| **quotation-generator** | Geração automática de faturas proforma em PDF com papel timbrado da empresa, suporte multi-idioma. |

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
