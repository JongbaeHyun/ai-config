# BRIDGE — Claude ↔ Codex 멀티모델 공유 계약

claude-config(표 A)와 codex-config(표 B/C)가 맞물리는 규약. 누가 드라이버든(Claude Code / Codex CLI) 아래를 지킨다.

## 공유 아티팩트 (각 프로젝트의 `.claude/`)

| 파일 | 역할 | 쓰는 주체 |
|---|---|---|
| `.claude/spec.md` | **유일 진실원** — 목표·비목표·제약·인수 기준(검증법 포함)·완성 임계 | 드라이버가 작성, 사람 승인 |
| `AGENTS.md` (프로젝트) | 드라이버 무관 운영 규칙(전역과 병합). Codex·Claude 둘 다 읽음 | 드라이버 |
| `.claude/decisions-needed.md` | 열린 질문·추측 결정 — 사람이 일괄 결정 | 드라이버가 누적 |

## 모델 라우팅

| 상황 | 드라이버 | 구현 | 리뷰·협력 |
|---|---|---|---|
| **표 A (평소)** | Claude Code | Opus (설계 Fable) | `codex review`·`codex exec` + 로컬 DeepSeek |
| **표 B (Claude 한도)** | Codex CLI | Codex(Astra) | 로컬 DeepSeek (Claude 불가) |
| **표 C (Codex 선호)** | Codex CLI | Codex | `claude -p` + 로컬 DeepSeek |

## 크로스-CLI 호출

- Claude → Codex: `codex exec --sandbox read-only "..."` / `codex review`
- Codex → Claude: `claude -p "..."` (헤드리스, Claude 쿼터 있을 때)
- 어느 쪽 → DeepSeek: OpenAI 호환 `${DEEPSEEK_BASE_URL}` (로컬 Ollama `http://192.168.100.11:11434/v1`, 키 불필요) / 공식 API는 `DEEPSEEK_API_KEY`

## 불변 규칙

- 외부 모델은 **읽기전용 조언/생성**. 파일 수정·커밋은 **드라이버만**. 두 모델이 같은 파일 동시 편집 금지.
- 완성 = 인수 기준 충족 + 리뷰 통과(작업 개수 아님). 흐린 목표는 추측 말고 질문(사람 승인 게이트).
- 드라이버 전환(A→B)은 사람이 실행(죽은 CLI는 후계를 못 띄움). `spec.md`가 연속성 보장.
