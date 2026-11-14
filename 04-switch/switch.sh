#!/usr/bin/env bash
# GitOps switch: edit the Service selector in Git, Argo CD syncs it.
# Usage: ./switch.sh green|blue   (run from inside the git repo)
set -euo pipefail
COLOR="${1:?blue|green}"
[[ "$COLOR" =~ ^(blue|green)$ ]] || { echo "blue or green"; exit 1; }
F="$(git rev-parse --show-toplevel)/02-app/overlays/active/patch-service.yaml"
sed -i -E "s/^(\s*color:\s*).*/\1${COLOR}/" "$F"
git add "$F"
git commit -m "switch live traffic to ${COLOR}"
git push
command -v argocd >/dev/null && argocd app sync bluegreen-demo || echo "Auto-sync will pick it up (~3 min, or click Refresh in UI)."
