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
│  HEARTBEAT.md  → Inspeção do pipeline em 13 pontos│
│  MEMORY.md     → Arquitetura de memória com 3 motores│
│  TOOLS.md      → CRM, canais, integrações         │
├─────────────────────────────────────────────────┤
│  Skills        → Capacidades extensíveis          │
│  Product KB    → Catálogo de produtos             │
│  Cron Jobs     → 13 tarefas agendadas automáticas │
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
# Skills:   b2b_trade (41 skills)
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

### Agendamento Automatizado (13 Cron Jobs)

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

### Sistema Anti-Amnésia de 4 Camadas

Agentes de IA perdem contexto em conversas longas e entre sessões. Nossa **arquitetura anti-amnésia de 4 camadas** garante que seu SDR com IA nunca esqueça:

```
Mensagem recebida ──→ L1 MemOS auto-recall (injeção de memória estruturada)
    │
    ├──→ L3 ChromaDB armazenamento por turno (isolamento por cliente, etiquetagem automática)
    │
    ├──→ L2 Resumo proativo a 65% dos tokens (compressão haiku, zero perda de informação)
    │
    └──→ L4 Snapshot CRM diário 12:00 (fallback de recuperação de desastres)
```

| Camada | Motor | O Que Faz |
|--------|-------|-----------|
| **L1: MemOS** | Memória estruturada | Extrai automaticamente BANT, compromissos e objeções a cada turno. Injeta no System Prompt no início da conversa. |
| **L2: Resumo Proativo** | Monitoramento de tokens | Comprime a 65% de uso do contexto via modelo classe haiku. Todos os números, cotações e compromissos preservados literalmente. |
| **L3: ChromaDB** | Armazenamento vetorial por turno | Cada turno de conversa armazenado com isolamento por `customer_id`. Etiquetagem automática de cotações, compromissos e objeções. Recuperação semântica entre sessões. |
| **L4: Snapshot CRM** | Backup diário | Armazena o estado completo do pipeline diariamente no ChromaDB como recuperação de desastres. Se qualquer camada falhar, L4 tem os dados. |

**Resultado**: Seu SDR com IA lembra de cada cliente, cada cotação, cada compromisso — mesmo após 100+ turnos, semanas de silêncio ou reinicializações do sistema.

> Veja **[ANTI-AMNESIA.md](./ANTI-AMNESIA.md)** para a especificação completa de implementação com código, prompts e guia de deployment.

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
| **chroma-memory** | Armazenamento de conversas por turno com isolamento de clientes, etiquetagem automática e snapshots do CRM. |
| **telegram-toolkit** | Comandos de bot, teclados inline, manipulação de arquivos grandes e estratégias para mercados Telegram-first. |
| **quotation-generator** | Geração automática de faturas proforma em PDF com papel timbrado da empresa, suporte multi-idioma. |

### Perfis de Skills

Escolha um conjunto de skills pré-configurado baseado em suas necessidades:

| Perfil | Skills | Melhor Para |
|--------|--------|-------------|
| `b2b_trade` | 41 skills | Empresas de exportação B2B (padrão) |
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

## Painel de Controle

Após o deployment, seu SDR com IA vem com um painel web integrado:

```
http://YOUR_SERVER_IP:18789/?token=YOUR_GATEWAY_TOKEN
```

O painel mostra:
- Status do bot em tempo real e conexão WhatsApp
- Histórico de mensagens e threads de conversa
- Status de execução dos cron jobs
- Monitoramento de saúde dos canais

O token é gerado automaticamente durante o deployment e exibido na saída. Mantenha-o privado — qualquer pessoa com a URL+token tem acesso completo.

> **Nota de segurança**: Defina `GATEWAY_BIND="loopback"` em config.sh para desabilitar o acesso remoto ao painel. O padrão é `"lan"` (acessível pela rede).

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

### Configuração do WhatsApp

Por padrão, o SDR com IA aceita mensagens de **todos os contatos do WhatsApp** (`dmPolicy: "open"`). Esta é a configuração recomendada para agentes de vendas — você quer que todo cliente potencial consiga te contatar.

| Configuração | Valor | Significado |
|--------------|-------|-------------|
| `WHATSAPP_DM_POLICY` | `"open"` (padrão) | Aceitar DMs de qualquer pessoa |
| | `"allowlist"` | Aceitar apenas de `ADMIN_PHONES` |
| | `"pairing"` | Requer código de pareamento primeiro |
| `WHATSAPP_GROUP_POLICY` | `"allowlist"` (padrão) | Responder apenas em grupos da lista branca |

Para alterar após o deployment, edite `~/.openclaw/openclaw.json` no servidor:

```json
{
  "channels": {
    "whatsapp": {
      "dmPolicy": "open",
      "allowFrom": ["*"]
    }
  }
}
```

Depois reinicie: `systemctl --user restart openclaw-gateway`

### Isolamento de IP do WhatsApp (Multi-Tenant)

Ao executar múltiplos agentes no mesmo servidor, cada um deve ter um IP de saída único para que o WhatsApp veja dispositivos independentes. Isso previne o bloqueio cruzado entre contas.

```bash
# Após fazer deploy de um cliente, isolar o IP do WhatsApp dele:
./deploy/ip-isolate.sh acme-corp

# Ou com uma porta SOCKS5 específica:
./deploy/ip-isolate.sh acme-corp 40010
```

**Como funciona:**

```
                  ┌─ wireproxy :40001 → WARP Account A → CF IP-A
                  │    ↑
tenant-a ─────────┘    ALL_PROXY=socks5://host:40001

tenant-b ─────────┐    ALL_PROXY=socks5://host:40002
                  │    ↓
                  └─ wireproxy :40002 → WARP Account B → CF IP-B
```

Cada tenant recebe:
- Uma conta dedicada gratuita do [Cloudflare WARP](https://1.1.1.1/)
- Uma instância isolada do [wireproxy](https://github.com/pufferffish/wireproxy) (~4MB RAM)
- Um IP de saída Cloudflare único para todo o tráfego de saída (incluindo WhatsApp)

Para habilitar automaticamente durante o deploy, defina `IP_ISOLATE=true` em `config.sh`.

### Deployment Gerenciado

Não quer hospedar você mesmo? **[PulseAgent](https://pulseagent.io/app)** oferece agentes SDR B2B totalmente gerenciados com:

- Deployment com um clique
- Dashboard & analytics
- Gerenciamento multi-canal
- Suporte prioritário

[Comece Agora →](https://pulseagent.io/app)

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
  Feito com ❤️ por <a href="https://pulseagent.io/app">PulseAgent</a><br/>
  <em>Context as a Service — AI SDR para Exportação B2B</em>
</p>
