#!/usr/bin/env bash
# 우산 설치 — claude-config + codex-config 설치 스크립트를 한 번에 실행.
# 기본 복사 모드. --link = 개발 머신(수정 즉시 반영).
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ARG="${1:-}"

# submodule이 비어 있으면 초기화
if [ ! -e "$REPO_DIR/claude-config/install-linux.sh" ] || [ ! -e "$REPO_DIR/codex-config/install-codex-linux.sh" ]; then
  echo "submodule 초기화..."
  git -C "$REPO_DIR" submodule update --init --recursive
fi

echo "=== claude-config ==="
( cd "$REPO_DIR/claude-config" && ./install-linux.sh $ARG )
echo ""
echo "=== codex-config ==="
( cd "$REPO_DIR/codex-config" && ./install-codex-linux.sh $ARG )
echo ""
echo "완료. settings.json(머신별)·멀티모델 키/로그인은 각 repo README 참고."
