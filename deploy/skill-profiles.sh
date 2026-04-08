#!/bin/bash
# ═══════════════════════════════════════════════════════════
#  B2B SDR Agent — Skill Profiles
#  Pre-configured skill combinations for different use cases
# ═══════════════════════════════════════════════════════════

# ─── Core Skills (always installed) ──────────────────────
SKILLS_CORE=(
  "sales"
  "supermemory"
  "chromadb"
  "tavily-search"
  "pdf"
  "find-skills"
  "customer-persona"
  "summarize"
  "lead-discovery"
  "quotation-generator"
)

# ─── B2B Sales Skills ────────────────────────────────────
SKILLS_B2B_SALES=(
  "cold-outreach"
  "cold-email"
  "lead-researcher"
  "ai-lead-generator-skill"
  "competitor-analysis-report"
  "go-to-market"
  "business-development"
  "apollo"
  "nyne-enrichment"
  "nyne-search"
)

# ─── Social Media Skills ─────────────────────────────────
SKILLS_SOCIAL=(
  "postiz"
  "simplified-social-media"
  "social-media-lead-generation"
  "content-creator"
  "bird"
  "bluesky"
  "moments-copy"
  "blog-writer"
)

# ─── Advertising Skills ──────────────────────────────────
SKILLS_ADS=(
  "meta-ads-report"
  "ad-ready"
  "google-analytics"
  "performance-reporter"
)

# ─── Research & Analytics Skills ──────────────────────────
SKILLS_RESEARCH=(
  "lead-generation"
  "brw-linkedin-profile-optimizer"
  "social-graph"
  "data-analyst"
  "graphify"
)

# ─── Email Skills ─────────────────────────────────────────
SKILLS_EMAIL=(
  "clawemail"
  "email-autoreply"
  "email-marketing-2"
  "daily-brief-digest"
)

# ─── Automation Skills ────────────────────────────────────
SKILLS_AUTOMATION=(
  "agent-browser"
  "listing-swarm"
  "foxreach"
  "campaign-orchestrator"
)

# ═══════════════════════════════════════════════════════════
#  Profiles
# ═══════════════════════════════════════════════════════════

profile_b2b_trade() {
  echo "${SKILLS_CORE[@]} ${SKILLS_B2B_SALES[@]} ${SKILLS_SOCIAL[@]} ${SKILLS_ADS[@]} ${SKILLS_EMAIL[@]}"
}

profile_lite() {
  echo "${SKILLS_CORE[@]} ${SKILLS_B2B_SALES[@]}"
}

profile_social() {
  echo "${SKILLS_CORE[@]} ${SKILLS_SOCIAL[@]} ${SKILLS_ADS[@]}"
}

profile_full() {
  echo "${SKILLS_CORE[@]} ${SKILLS_B2B_SALES[@]} ${SKILLS_SOCIAL[@]} ${SKILLS_ADS[@]} ${SKILLS_RESEARCH[@]} ${SKILLS_EMAIL[@]} ${SKILLS_AUTOMATION[@]}"
}

get_skills_for_profile() {
  local profile="$1"
  case "$profile" in
    b2b_trade|b2b) profile_b2b_trade ;;
    lite|minimal)  profile_lite ;;
    social)        profile_social ;;
    full|all)      profile_full ;;
    none|skip)     echo "" ;;
    *)
      echo "⚠ Unknown skill profile '$profile', falling back to b2b_trade" >&2
      profile_b2b_trade
      ;;
  esac
}
