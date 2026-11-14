#!/usr/bin/env bash
# Usage: ./apply.sh https://github.com/YOU/argocd-blue-green.git
set -euo pipefail
REPO="${1:?repo url required}"
sed "s#https://github.com/YOUR_USER/argocd-blue-green.git#${REPO}#" "$(dirname "$0")/application.yaml" | kubectl apply -f -
