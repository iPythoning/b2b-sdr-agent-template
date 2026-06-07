# Modèle d'Agent SDR B2B

> Transformez n'importe quelle entreprise d'export B2B en machine de vente IA en 5 minutes.

Un modèle open-source prêt pour la production pour créer des représentants commerciaux IA (SDR) qui gèrent **l'intégralité du pipeline de vente** — de la capture de leads à la conclusion des affaires — via WhatsApp, Telegram et email.

Construit sur [OpenClaw](https://openclaw.dev), éprouvé avec de vraies entreprises d'export B2B.

**🌐 [English](./README.md) | [中文](./README.zh-CN.md) | [Español](./README.es.md) | Français | [العربية](./README.ar.md) | [Português](./README.pt-BR.md) | [日本語](./README.ja.md) | [Русский](./README.ru.md)**

---

## Architecture : Système de Contexte à 7 Couches

```
┌─────────────────────────────────────────────────┐
│              Agent SDR IA                        │
├─────────────────────────────────────────────────┤
│  IDENTITY.md   → Qui suis-je ? Entreprise, rôle  │
│  SOUL.md       → Personnalité, valeurs, règles    │
│  AGENTS.md     → Workflow de vente complet (10 étapes)│
│  USER.md       → Profil propriétaire, ICP, scoring│
│  HEARTBEAT.md  → Inspection du pipeline en 13 points│
│  MEMORY.md     → Architecture mémoire à 3 moteurs │
│  TOOLS.md      → CRM, canaux, intégrations        │
├─────────────────────────────────────────────────┤
│  Skills        → Capacités extensibles            │
│  Product KB    → Votre catalogue produits         │
│  Cron Jobs     → 13 tâches planifiées automatiques│
├─────────────────────────────────────────────────┤
│  OpenClaw Gateway (WhatsApp / Telegram / Email)  │
└─────────────────────────────────────────────────┘
```

Chaque couche est un fichier Markdown que vous personnalisez pour votre entreprise. L'IA lit toutes les couches à chaque conversation, lui donnant un contexte approfondi sur votre entreprise, vos produits et votre stratégie de vente.

## Démarrage Rapide

### Option A : Utilisateurs OpenClaw (1 Commande)

Si vous avez déjà [OpenClaw](https://openclaw.dev) en cours d'exécution :

```bash
clawhub install b2b-sdr-agent
```

Terminé. Le skill installe le système de contexte complet à 7 couches, delivery-queue et sdr-humanizer dans votre workspace. Ensuite, personnalisez :

```bash
# Éditez les fichiers clés pour votre entreprise
vim ~/.openclaw/workspace/skills/b2b-sdr-agent/references/IDENTITY.md
vim ~/.openclaw/workspace/skills/b2b-sdr-agent/references/USER.md

# Ou copiez dans votre workspace principal
cp ~/.openclaw/workspace/skills/b2b-sdr-agent/references/*.md ~/.openclaw/workspace/
```

Remplacez tous les `{{placeholders}}` par les informations réelles de votre entreprise, et votre SDR IA est en ligne.

### Option B : Déploiement Complet (5 Minutes)

#### 1. Cloner & Configurer

```bash
git clone https://github.com/iPythoning/b2b-sdr-agent-template.git
cd b2b-sdr-agent-template

# Éditez les 7 fichiers workspace pour votre entreprise
vim workspace/IDENTITY.md   # Infos entreprise, rôle, pipeline
vim workspace/USER.md       # Vos produits, ICP, concurrents
vim workspace/SOUL.md       # Personnalité et règles de l'IA
```

#### 2. Configurer le Déploiement

```bash
cd deploy
cp config.sh.example config.sh
vim config.sh               # Remplissez : IP serveur, clé API, numéro WhatsApp
```

#### 3. Déployer

```bash
./deploy.sh my-company

# Sortie :
# ✅ Deploy Complete: my-company
# Gateway:  ws://your-server:18789
# WhatsApp: Enabled
# Skills:   b2b_trade (41 skills)
```

C'est tout. Votre SDR IA est en ligne sur WhatsApp et prêt à vendre.

## Ce qu'il Fait

### Automatisation Complète du Pipeline de Vente (10 Étapes)

| Étape | Ce que l'IA Fait |
|-------|------------------|
| **1. Capture de Leads** | Détection automatique des messages entrants (WhatsApp/Telegram/pubs CTWA), création d'enregistrements CRM |
| **2. Qualification BANT** | Conversation naturelle pour évaluer Budget, Autorité, Besoin, Calendrier |
| **3. Saisie CRM** | Capture de données structurées — nom, entreprise, pays, score ICP, intérêt produit |
| **4. Recherche & Enrichissement** | Recherche web Jina AI + analyse du site web de l'entreprise, pipeline d'enrichissement à 3 couches |
| **5. Devis** | Génération automatique de devis PDF, multi-langues, envoi au propriétaire pour approbation |
| **6. Négociation** | Suivi des contre-offres, recommandation de stratégie, escalade si nécessaire |
| **7. Reporting** | Rapports quotidiens du pipeline à 09:00, alertes blocage à 15:00, résumés hebdomadaires |
| **8. Nurture** | Suivis automatisés, actualités du secteur, service après-vente, bilans trimestriels |
| **9. Email Outreach** | Séquences d'emails à froid personnalisées (Jour 1/3/7/14), suivi automatique |
| **10. Orchestration Multicanal** | Coordination inter-canaux (WhatsApp + Email + Telegram), basculement automatique |

### Planification Automatisée (13 Cron Jobs)

| Horaire | Tâche |
|---------|-------|
| Toutes les 30 min | Scan de la boîte Gmail pour les réponses clients |
| Quotidien 09:00 | Rapport du pipeline au propriétaire via WhatsApp |
| Quotidien 10:00 | Découverte de leads par IA (rotation de marchés : Afrique/MO/ASE/LatAm) |
| Quotidien 11:00 | Vérification de la séquence de suivi email |
| Quotidien 15:00 | Détection des leads bloqués |
| Hebdo Mer | Campagne de nurture |
| Hebdo Ven | Collecte de renseignements concurrentiels |
| Hebdo Lun | Rapport résumé hebdomadaire |

### Conversations Naturelles

- Répond dans la langue du client (détection automatique)
- Rythme naturel des messages avec le skill delivery-queue (délais de 3-90s, découpage des messages)
- Envoi adapté au fuseau horaire (7 mappings de fuseaux horaires de marchés)
- Adaptation culturelle (Moyen-Orient, Afrique, Asie du Sud-Est, Amérique latine, Europe)
- Ne révèle jamais l'identité IA — se présente comme votre consultant commercial

### Scoring ICP Dynamique

- Score initial basé sur 5 dimensions pondérées (volume d'achat, adéquation produit, région, capacité de paiement, autorité)
- **S'auto-ajuste** selon l'interaction : réponse rapide +1, demande de devis +2, mentionne un concurrent +2, 7j sans réponse -1
- Leads chauds (ICP>=7) signalés automatiquement, propriétaire notifié immédiatement

### Mémoire Intelligente (3 Moteurs)

- **Supermemory** : Notes de recherche, renseignements concurrentiels, insights marché — consulté avant chaque contact
- **MemoryLake** : Contexte de session, résumés de conversations — rappelé automatiquement par conversation
- **MemOS Cloud** : Patterns comportementaux inter-sessions — capturé automatiquement

### Système Anti-Amnésie à 4 Couches

Les agents IA perdent le contexte dans les longues conversations et entre les sessions. Notre **architecture anti-amnésie à 4 couches** garantit que votre SDR IA n'oublie jamais :

```
Message entrant ──→ L1 MemOS auto-recall (injection de mémoire structurée)
    │
    ├──→ L3 ChromaDB stockage par tour (isolation client, étiquetage automatique)
    │
    ├──→ L2 Résumé proactif à 65% des tokens (compression haiku, zéro perte d'information)
    │
    └──→ L4 Snapshot CRM quotidien 12:00 (secours de reprise après sinistre)
```

| Couche | Moteur | Ce qu'elle fait |
|--------|--------|-----------------|
| **L1 : MemOS** | Mémoire structurée | Extraction automatique de BANT, engagements, objections à chaque tour. Injection dans le System Prompt au début de la conversation. |
| **L2 : Résumé Proactif** | Surveillance des tokens | Compression à 65% d'utilisation du contexte via un modèle classe haiku. Tous les chiffres, devis et engagements sont préservés textuellement. |
| **L3 : ChromaDB** | Stockage vectoriel par tour | Chaque tour de conversation stocké avec isolation par `customer_id`. Étiquetage automatique des devis, engagements et objections. Recherche sémantique inter-sessions. |
| **L4 : Snapshot CRM** | Sauvegarde quotidienne | Stocke l'état complet du pipeline quotidiennement dans ChromaDB en tant que reprise après sinistre. Si une couche échoue, L4 a les données. |

**Résultat** : Votre SDR IA se souvient de chaque client, chaque devis, chaque engagement — même après 100+ tours, des semaines de silence ou des redémarrages système.

> Consultez **[ANTI-AMNESIA.md](./ANTI-AMNESIA.md)** pour la spécification complète d'implémentation avec code, prompts et guide de déploiement.

## Les 7 Couches Expliquées

| Couche | Fichier | Objectif |
|--------|---------|----------|
| **Identity** | `IDENTITY.md` | Infos entreprise, définition du rôle, étapes pipeline, hiérarchisation leads |
| **Soul** | `SOUL.md` | Personnalité IA, style de communication, règles strictes, mindset de croissance |
| **Agents** | `AGENTS.md` | Workflow de vente en 10 étapes, qualification BANT, orchestration multicanal |
| **User** | `USER.md` | Profil propriétaire, gammes de produits, scoring ICP, concurrents |
| **Heartbeat** | `HEARTBEAT.md` | Inspection automatique du pipeline — nouveaux leads, affaires bloquées, qualité des données |
| **Memory** | `MEMORY.md` | Architecture mémoire à 3 niveaux, principes d'efficacité SDR |
| **Tools** | `TOOLS.md` | Commandes CRM, configuration canaux, recherche web, accès email |

## Skills

Capacités préconstruites qui étendent votre SDR IA :

| Skill | Description |
|-------|-------------|
| **delivery-queue** | Planification de messages avec délais naturels. Campagnes goutte-à-goutte, suivis programmés. |
| **supermemory** | Moteur de mémoire sémantique. Capture automatique des insights clients, recherche dans toutes les conversations. |
| **sdr-humanizer** | Règles pour conversation naturelle — rythme, adaptation culturelle, anti-patterns. |
| **lead-discovery** | Découverte de leads par IA. Recherche web de clients potentiels, évaluation ICP, saisie automatique CRM. |
| **chroma-memory** | Stockage des conversations par tour avec isolation par client, étiquetage automatique et snapshots CRM. |
| **telegram-toolkit** | Commandes bot, claviers inline, gestion de fichiers volumineux et stratégies pour les marchés Telegram-first. |
| **quotation-generator** | Génération automatique de factures proforma PDF avec en-tête d'entreprise, support multi-langues. |

### Profils de Skills

Choisissez un ensemble de skills préconfiguré selon vos besoins :

| Profil | Skills | Idéal Pour |
|---------|--------|------------|
| `b2b_trade` | 41 skills | Entreprises d'export B2B (par défaut) |
| `lite` | 16 skills | Démarrage, faible volume |
| `social` | 14 skills | Ventes axées sur les médias sociaux |
| `full` | 40+ skills | Tout activé |

## Exemples par Secteur

Configurations prêtes à l'emploi pour les verticales d'export B2B courantes :

| Secteur | Répertoire | Points Clés |
|---------|------------|-------------|
| **Véhicules Lourds** | `examples/heavy-vehicles/` | Camions, machines, ventes de flottes, marchés Afrique/Moyen-Orient |
| **Électronique Grand Public** | `examples/electronics/` | OEM/ODM, vendeurs Amazon, ventes basées sur échantillons |
| **Textile & Vêtements** | `examples/textiles/` | Tissus durables, certifié GOTS, marchés UE/US |

Pour utiliser un exemple, copiez-le dans votre workspace :

```bash
cp examples/heavy-vehicles/IDENTITY.md workspace/IDENTITY.md
cp examples/heavy-vehicles/USER.md workspace/USER.md
# Puis personnalisez pour votre entreprise spécifique
```

## Base de Connaissances Produits

Structurez votre catalogue produits pour que l'IA puisse générer des devis précis :

```
product-kb/
├── catalog.json                    # Catalogue produits avec specs, MOQ, délais
├── products/
│   └── example-product/info.json   # Infos détaillées produit
└── scripts/
    └── generate-pi.js              # Générateur de facture proforma
```

## Tableau de Bord

Après le déploiement, votre SDR IA est livré avec un tableau de bord web intégré :

```
http://YOUR_SERVER_IP:18789/?token=YOUR_GATEWAY_TOKEN
```

Le tableau de bord affiche :
- Statut du bot en temps réel et connexion WhatsApp
- Historique des messages et fils de conversation
- Statut d'exécution des cron jobs
- Surveillance de la santé des canaux

Le token est auto-généré lors du déploiement et affiché dans la sortie. Gardez-le privé — quiconque possède l'URL+token a un accès complet.

> **Note de sécurité** : Définissez `GATEWAY_BIND="loopback"` dans config.sh pour désactiver l'accès distant au tableau de bord. La valeur par défaut est `"lan"` (accessible depuis le réseau).

## Déploiement

### Prérequis

- Un serveur Linux (Ubuntu 20.04+ recommandé)
- Node.js 18+
- Une clé API de modèle IA (OpenAI, Anthropic, Google, Kimi, etc.)
- Compte WhatsApp Business (optionnel mais recommandé)

### Configuration

Toute la configuration se trouve dans `deploy/config.sh`. Sections clés :

```bash
# Serveur
SERVER_HOST="your-server-ip"

# Modèle IA
PRIMARY_API_KEY="sk-..."

# Canaux
WHATSAPP_ENABLED=true
TELEGRAM_BOT_TOKEN="..."

# CRM
SHEETS_SPREADSHEET_ID="your-google-sheets-id"

# Admin (qui peut gérer l'IA)
ADMIN_PHONES="+1234567890"
```

### Configuration WhatsApp

Par défaut, le SDR IA accepte les messages de **tous les contacts WhatsApp** (`dmPolicy: "open"`). C'est le paramètre recommandé pour les agents commerciaux — vous voulez que chaque client potentiel puisse vous contacter.

| Paramètre | Valeur | Signification |
|-----------|--------|---------------|
| `WHATSAPP_DM_POLICY` | `"open"` (par défaut) | Accepter les DMs de n'importe qui |
| | `"allowlist"` | Accepter uniquement de `ADMIN_PHONES` |
| | `"pairing"` | Nécessite un code d'appairage d'abord |
| `WHATSAPP_GROUP_POLICY` | `"allowlist"` (par défaut) | Répondre uniquement dans les groupes de la liste blanche |

Pour modifier après le déploiement, éditez `~/.openclaw/openclaw.json` sur le serveur :

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

Puis redémarrez : `systemctl --user restart openclaw-gateway`

### Isolation IP WhatsApp (Multi-Tenant)

Lors de l'exécution de plusieurs agents sur le même serveur, chacun doit avoir une IP de sortie unique pour que WhatsApp voie des appareils indépendants. Cela empêche le blocage croisé des comptes.

```bash
# Après avoir déployé un client, isoler son IP WhatsApp :
./deploy/ip-isolate.sh acme-corp

# Ou avec un port SOCKS5 spécifique :
./deploy/ip-isolate.sh acme-corp 40010
```

**Comment ça marche :**

```
                  ┌─ wireproxy :40001 → WARP Account A → CF IP-A
                  │    ↑
tenant-a ─────────┘    ALL_PROXY=socks5://host:40001

tenant-b ─────────┐    ALL_PROXY=socks5://host:40002
                  │    ↓
                  └─ wireproxy :40002 → WARP Account B → CF IP-B
```

Chaque tenant obtient :
- Un compte [Cloudflare WARP](https://1.1.1.1/) dédié gratuit
- Une instance [wireproxy](https://github.com/pufferffish/wireproxy) isolée (~4 Mo de RAM)
- Une IP de sortie Cloudflare unique pour tout le trafic sortant (y compris WhatsApp)

Pour activer automatiquement lors du déploiement, définissez `IP_ISOLATE=true` dans `config.sh`.

### Déploiement Géré

Vous ne voulez pas auto-héberger ? **[PulseAgent](https://pulseagent.io/app)** offre des agents SDR B2B entièrement gérés avec :

- Déploiement en un clic
- Dashboard & analytics
- Gestion multi-canaux
- Support prioritaire

[Commencer →](https://pulseagent.io/app)

## Contribuer

Les contributions sont les bienvenues ! Domaines où nous aimerions de l'aide :

- **Modèles sectoriels** : Ajoutez des exemples pour votre secteur
- **Skills** : Créez de nouvelles capacités
- **Traductions** : Traduisez les modèles workspace dans d'autres langues
- **Documentation** : Améliorez les guides et tutoriels

## Licence

MIT — utilisez-le pour tout.

---

<p align="center">
  Fait avec ❤️ par <a href="https://pulseagent.io/app">PulseAgent</a><br/>
  <em>Context as a Service — AI SDR for B2B Export</em>
</p>
