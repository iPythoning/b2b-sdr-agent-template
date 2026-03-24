# B2B SDR エージェントテンプレート

> あらゆる B2B 輸出ビジネスを 5 分で AI 駆動のセールスマシンに変換。

リードキャプチャから商談クロージングまで、**完全なセールスパイプライン**を WhatsApp、Telegram、Email で処理する AI セールス開発担当者（SDR）を構築するための、オープンソースで本番環境対応のテンプレート。

[OpenClaw](https://openclaw.dev) をベースに構築され、実際の B2B 輸出企業で実戦テスト済み。

**🌐 [English](./README.md) | [中文](./README.zh-CN.md) | [Español](./README.es.md) | [Français](./README.fr.md) | [العربية](./README.ar.md) | [Português](./README.pt-BR.md) | 日本語 | [Русский](./README.ru.md)**

---

## アーキテクチャ：7 層コンテキストシステム

```
┌─────────────────────────────────────────────────┐
│              AI SDR エージェント                  │
├─────────────────────────────────────────────────┤
│  IDENTITY.md   → 私は誰？企業、役割              │
│  SOUL.md       → パーソナリティ、価値観、規則    │
│  AGENTS.md     → 完全なセールスワークフロー（10段階）│
│  USER.md       → オーナープロフィール、ICP、スコアリング│
│  HEARTBEAT.md  → 10項目パイプライン検査          │
│  MEMORY.md     → 3エンジンメモリアーキテクチャ   │
│  TOOLS.md      → CRM、チャネル、統合             │
├─────────────────────────────────────────────────┤
│  Skills        → 拡張可能な機能                  │
│  Product KB    → 製品カタログ                    │
│  Cron Jobs     → 10 個の自動スケジュールタスク   │
├─────────────────────────────────────────────────┤
│  OpenClaw Gateway (WhatsApp / Telegram / Email) │
└─────────────────────────────────────────────────┘
```

各層はビジネスに合わせてカスタマイズする Markdown ファイルです。AI は会話のたびにすべての層を読み込み、企業、製品、セールス戦略に関する深いコンテキストを持ちます。

## クイックスタート

### オプション A：OpenClaw ユーザー（1 コマンド）

すでに [OpenClaw](https://openclaw.dev) を実行している場合：

```bash
clawhub install b2b-sdr-agent
```

完了です。このスキルは、完全な 7 層コンテキストシステム、delivery-queue、sdr-humanizer をワークスペースにインストールします。その後、カスタマイズします：

```bash
# ビジネスに合わせて主要ファイルを編集
vim ~/.openclaw/workspace/skills/b2b-sdr-agent/references/IDENTITY.md
vim ~/.openclaw/workspace/skills/b2b-sdr-agent/references/USER.md

# またはメインワークスペースにコピー
cp ~/.openclaw/workspace/skills/b2b-sdr-agent/references/*.md ~/.openclaw/workspace/
```

すべての `{{placeholders}}` を実際の企業情報に置き換えれば、AI SDR が稼働します。

### オプション B：完全デプロイ（5 分）

#### 1. クローンと設定

```bash
git clone https://github.com/iPythoning/b2b-sdr-agent-template.git
cd b2b-sdr-agent-template

# ビジネスに合わせて 7 つのワークスペースファイルを編集
vim workspace/IDENTITY.md   # 企業情報、役割、パイプライン
vim workspace/USER.md       # 製品、ICP、競合他社
vim workspace/SOUL.md       # AI のパーソナリティと規則
```

#### 2. デプロイ設定のセットアップ

```bash
cd deploy
cp config.sh.example config.sh
vim config.sh               # サーバー IP、API キー、WhatsApp 番号を記入
```

#### 3. デプロイ

```bash
./deploy.sh my-company

# 出力：
# ✅ Deploy Complete: my-company
# Gateway:  ws://your-server:18789
# WhatsApp: Enabled
# Skills:   b2b_trade (28 skills)
```

以上です。AI SDR が WhatsApp で稼働し、販売準備が整いました。

## 機能

### フルパイプラインセールス自動化（10 ステージ）

| ステージ | AI が行うこと |
|---------|--------------|
| **1. リードキャプチャ** | インバウンドメッセージの自動検出（WhatsApp/Telegram/CTWA 広告）、CRM レコード作成 |
| **2. BANT 資格審査** | 予算、決裁権、ニーズ、タイムラインを評価する自然な会話 |
| **3. CRM 入力** | 構造化データキャプチャ — 氏名、企業、国、ICP スコア、製品関心 |
| **4. リサーチ＆エンリッチメント** | Jina AI ウェブ検索 + 企業ウェブサイト分析、3 層エンリッチメントパイプライン |
| **5. 見積もり** | PDF 見積書を自動生成、多言語対応、オーナーの承認を求めて送信 |
| **6. 交渉** | 対案を追跡、戦略を推奨、必要に応じてエスカレーション |
| **7. レポート** | 毎日 09:00 パイプラインレポート、15:00 停滞アラート、週次サマリー |
| **8. 育成** | 自動フォローアップ、業界ニュース、アフターセールスケア、四半期チェックイン |
| **9. メールアウトリーチ** | パーソナライズされたコールドメールシーケンス（1/3/7/14 日目）、自動フォローアップ |
| **10. マルチチャネルオーケストレーション** | クロスチャネル連携（WhatsApp + Email + Telegram）、自動切り替え |

### 自動スケジューリング（10 個の Cron ジョブ）

| スケジュール | タスク |
|------------|--------|
| 30 分ごと | Gmail 受信トレイスキャン（クライアント返信） |
| 毎日 09:00 | WhatsApp 経由でオーナーにパイプラインレポート |
| 毎日 10:00 | AI リードディスカバリー（市場ローテーション：アフリカ/中東/東南アジア/中南米） |
| 毎日 11:00 | メールフォローアップシーケンスチェック |
| 毎日 15:00 | 停滞リード検出 |
| 毎週水曜 | ナーチャリングキャンペーン |
| 毎週金曜 | 競合情報収集 |
| 毎週月曜 | 週次サマリーレポート |

### 人間のような会話
- 顧客の言語で応答（自動検出）
- delivery-queue スキルによる自然なメッセージペーシング（3-90 秒遅延、メッセージ分割）
- タイムゾーン対応送信（7 市場タイムゾーンマッピング）
- 文化的適応（中東、アフリカ、東南アジア、ラテンアメリカ、ヨーロッパ）
- AI であることを明かさない — あなたのセールスコンサルタントとして提示

### ダイナミック ICP スコアリング
- 5 つの加重次元に基づく初期スコア（購買量、製品マッチ、地域、支払能力、決裁権）
- **自動調整**：素早い返信 +1、見積もり要求 +2、競合他社に言及 +2、7 日間無返信 -1
- ホットリード（ICP>=7）は自動フラグ付与、オーナーに即時通知

### スマートメモリ（3 エンジン）
- **Supermemory**：リサーチノート、競合情報、市場インサイト — アウトリーチ前に照会
- **MemoryLake**：セッションコンテキスト、会話サマリー — 会話ごとに自動リコール
- **MemOS Cloud**：クロスセッション行動パターン — 自動キャプチャ

## 7 層の説明

| 層 | ファイル | 目的 |
|----|---------|------|
| **Identity** | `IDENTITY.md` | 企業情報、役割定義、パイプラインステージ、リードティア分類 |
| **Soul** | `SOUL.md` | AI のパーソナリティ、コミュニケーションスタイル、厳格な規則、成長マインドセット |
| **Agents** | `AGENTS.md` | 10 段階セールスワークフロー、BANT 資格審査、マルチチャネルオーケストレーション |
| **User** | `USER.md` | オーナープロフィール、製品ライン、ICP スコアリング、競合他社 |
| **Heartbeat** | `HEARTBEAT.md` | 自動パイプライン検査 — 新規リード、停滞案件、データ品質 |
| **Memory** | `MEMORY.md` | 3 層メモリアーキテクチャ、SDR 有効性原則 |
| **Tools** | `TOOLS.md` | CRM コマンド、チャネル設定、Web リサーチ、Email アクセス |

## スキル

AI SDR を拡張する事前構築された機能：

| スキル | 説明 |
|-------|------|
| **delivery-queue** | 人間らしい遅延でメッセージをスケジュール。ドリップキャンペーン、タイムドフォローアップ。 |
| **supermemory** | セマンティックメモリエンジン。顧客インサイトを自動キャプチャ、すべての会話を横断検索。 |
| **sdr-humanizer** | 自然な会話のための規則 — ペーシング、文化的適応、アンチパターン。 |
| **lead-discovery** | AI 駆動のリードディスカバリー。潜在バイヤーのウェブ検索、ICP 評価、CRM 自動入力。 |
| **quotation-generator** | PDF プロフォーマインボイスを自動生成。企業レターヘッド、多言語対応。 |

### スキルプロフィール

ニーズに基づいて事前設定されたスキルセットを選択：

| プロフィール | スキル数 | 最適な用途 |
|------------|---------|----------|
| `b2b_trade` | 28 スキル | B2B 輸出企業（デフォルト） |
| `lite` | 16 スキル | 入門、低ボリューム |
| `social` | 14 スキル | ソーシャルメディア重視のセールス |
| `full` | 40+ スキル | すべてを有効化 |

## 業界別サンプル

一般的な B2B 輸出業界向けのすぐに使える設定：

| 業界 | ディレクトリ | ハイライト |
|-----|------------|-----------|
| **重車両** | `examples/heavy-vehicles/` | トラック、機械、フリート販売、アフリカ/中東市場 |
| **家電** | `examples/electronics/` | OEM/ODM、Amazon セラー、サンプル駆動型セールス |
| **繊維・衣料** | `examples/textiles/` | サステナブル生地、GOTS 認証、EU/US 市場 |

サンプルを使用するには、ワークスペースにコピーします：

```bash
cp examples/heavy-vehicles/IDENTITY.md workspace/IDENTITY.md
cp examples/heavy-vehicles/USER.md workspace/USER.md
# その後、具体的なビジネスに合わせてカスタマイズ
```

## 製品ナレッジベース

AI が正確な見積書を生成できるように製品カタログを構造化：

```
product-kb/
├── catalog.json                    # スペック、MOQ、リードタイムを含む製品カタログ
├── products/
│   └── example-product/info.json   # 詳細な製品情報
└── scripts/
    └── generate-pi.js              # プロフォーマインボイスジェネレーター
```

## デプロイメント

### 前提条件
- Linux サーバー（Ubuntu 20.04+ 推奨）
- Node.js 18+
- AI モデル API キー（OpenAI、Anthropic、Google、Kimi など）
- WhatsApp Business アカウント（オプションだが推奨）

### 設定

すべての設定は `deploy/config.sh` にあります。主要なセクション：

```bash
# サーバー
SERVER_HOST="your-server-ip"

# AI モデル
PRIMARY_API_KEY="sk-..."

# チャネル
WHATSAPP_ENABLED=true
TELEGRAM_BOT_TOKEN="..."

# CRM
SHEETS_SPREADSHEET_ID="your-google-sheets-id"

# 管理者（AI を管理できるユーザー）
ADMIN_PHONES="+1234567890"
```

### マネージドデプロイメント

セルフホスティングしたくない場合は、**[PulseAgent](https://ai.pulseagent.io)** が完全マネージド B2B SDR エージェントを提供：
- ワンクリックデプロイ
- ダッシュボード＆アナリティクス
- マルチチャネル管理
- 優先サポート

[はじめる →](https://ai.pulseagent.io)

## コントリビューション

コントリビューション歓迎！以下の分野で協力をお願いします：

- **業界テンプレート**：あなたの業界向けのサンプルを追加
- **スキル**：新しい機能を構築
- **翻訳**：ワークスペーステンプレートを他の言語に翻訳
- **ドキュメント**：ガイドとチュートリアルの改善

## ライセンス

MIT — あらゆる用途に使用可能。

---

<p align="center">
  PulseAgent が ❤️ を込めて構築<br/>
  <em>Context as a Service — B2B 輸出向け AI SDR</em>
</p>
