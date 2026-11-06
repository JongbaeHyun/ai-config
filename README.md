# ai-config

Claude + Codex 멀티모델 개발 환경의 **우산 repo**. 두 독립 설정을 git submodule로 연결만 한다(흡수하지 않음).

```
ai-config/
├── claude-config/   → submodule (JongbaeHyun/claude-config)  — 표 A, ~/.claude 배포
├── codex-config/    → submodule (JongbaeHyun/codex-config)   — 표 B/C, ~/.codex/AGENTS.md 배포
├── BRIDGE.md         두 설정이 맞물리는 공유 계약(spec.md·AGENTS.md·라우팅·크로스-CLI)
└── install.sh        두 설치 스크립트를 한 번에
```

## 운영 모드

| 모드 | 드라이버 | 언제 |
|---|---|---|
| A | Claude Code | 평소 (설계 Fable·구현 Opus) |
| B | Codex CLI | Claude 사용량 한도로 멈춤 → Codex 승격 |
| C | Codex CLI | Codex 주력 선호 (+ Claude `claude -p` 협력) |

자세한 라우팅·규약은 `BRIDGE.md`.

## 설치 (새 머신)

```bash
git clone --recursive git@github.com:JongbaeHyun/ai-config.git
cd ai-config && ./install.sh            # 복사 모드
# 개발 머신(수정 즉시 반영): ./install.sh --link
```

이미 clone 했는데 submodule이 비어 있으면: `git submodule update --init --recursive`.

## 동기화

- 각 설정 수정은 **해당 submodule**(claude-config / codex-config)에서 커밋·푸시.
- 그 뒤 ai-config에서 포인터 갱신: `git add claude-config codex-config && git commit -m "bump submodules" && git push`.
- 다른 머신: `git pull && git submodule update --init --recursive` 후 설치 스크립트 재실행(링크 모드 제외).

## 독립성

claude-config·codex-config는 각자 독립 repo(자기 원격·배포)다. ai-config는 **특정 커밋을 가리키는 포인터**만 가진다. 우산 없이 각 repo를 단독으로 써도 된다.
