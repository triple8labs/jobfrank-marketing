#!/usr/bin/env bash
set -euo pipefail

if [ ! -f .env ]; then
  cp .env.example .env
  echo ".env created from .env.example — fill in secrets before continuing"
  exit 1
fi

docker compose up -d
echo ""
echo "n8n:     http://localhost:5678"
echo "mailpit: http://localhost:8026"
