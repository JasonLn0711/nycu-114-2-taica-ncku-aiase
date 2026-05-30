# Repo Map

This map explains ownership boundaries and stable reading paths. It is designed
for both human readers and AI agents.

## Canonical Areas

| Path | Role | Edit policy |
| --- | --- | --- |
| `TAICA_AIASE2026/` | Course material, syllabus, lecture notes, homework specs, result pages, notebook, and course image. | Treat as upstream and grading-sensitive. Do not move, rename, or rewrite during cleanup. |
| `TAICA_AIASE2026/homeworks/` | Official homework specifications and generated HW1 result files. | Read-only unless Jason explicitly requests a targeted change. |
| `final-project/` | Final project packet with deadlines, team facts, brainstorming, proposal draft, and source records. | Read-only for repo organization work. Link to it from outside instead of editing it. |
| `notes/` | Jason-facing study notes and explanatory material. | Editable for indexing, titles, and readability when the request targets personal notes. |
| `docs/` | Navigation, repo maps, reading routes, and agent handoff context. | Preferred place for organization and cross-file guidance. |

## Current Protected Content

Protected content includes:

- all files under `TAICA_AIASE2026/homeworks/`
- all files under `final-project/`
- course lecture files such as `TAICA_AIASE2026/W1.md`, `W2.md`, `W3.md`,
  `W5.md`, and `W6.md`
- course support files such as `TAICA_AIASE2026/W2_StockHeatMap_v3.ipynb` and
  `TAICA_AIASE2026/318_invitedtalk.png`

## Preferred Organization Pattern

Use external indexes and maps:

- add repo-level context in `README.md`
- add stable boundaries in `AGENTS.md`
- add reading order in `docs/reading-guide.md`
- add agent operating context in `docs/agent-handoff.md`
- add note-level discovery in `notes/README.md`

Avoid organization by moving course files. Stable course paths are part of the
repo contract.
