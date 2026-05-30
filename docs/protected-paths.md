# Protected Paths Contract

This file is the checklist-style contract for paths that must remain stable
during repo cleanup. It is stricter than the general reading guide because it is
intended for AI agents and future maintenance checks.

## Path Contract

| Protected path | Reason | Allowed operation | Forbidden operation |
| --- | --- | --- | --- |
| `TAICA_AIASE2026/homeworks/` | Official homework specs and generated homework result files may be referenced by instructor grading, student instructions, or fixed links. | Read, link, quote short references in external docs, and check for diffs. | Move, rename, rewrite, reformat, delete, regenerate, or add cleanup-only files inside this path. |
| `TAICA_AIASE2026/homeworks/HW1_result/` | Generated result page and JSON may be expected at their current paths. | Read and link from external docs. | Rebuild, edit, prettify, relocate, or remove generated outputs. |
| `final-project/` | Final project packet records deadlines, team facts, source records, proposal draft, and implementation planning. It is treated as canonical project context. | Read and link from `README.md` or `docs/`; use as source context. | Move, rename, rewrite, summarize in place, or add cleanup-only status files inside this directory. |
| `TAICA_AIASE2026/*.md` | Course lecture files, syllabus, and upstream course-facing docs should remain path-stable. | Read and link from external docs. | Rename, rewrite, reformat, split, merge, or reorder content for cleanup. |
| `TAICA_AIASE2026/*.ipynb` | Course notebook path may be referenced by teaching materials or students. | Read, inspect metadata if needed, and link from external docs. | Move, rename, execute in place, strip outputs, or re-save for cleanup. |
| `TAICA_AIASE2026/*.png` | Course image path may be referenced by Markdown or pages. | Read and link from external docs. | Move, rename, compress, replace, or regenerate for cleanup. |

## Editable Organization Paths

| Editable path | Purpose | Safe operation |
| --- | --- | --- |
| `README.md` | Human landing page. | Update repo overview, start-here links, and protected-boundary summary. |
| `AGENTS.md` | Local agent operating rules. | Update clear rules for future AI agents. |
| `docs/` | Navigation, policy, handoff, and verification docs. | Add or update external guidance without changing protected content. |
| `scripts/check_repo_boundaries.sh` | Non-destructive boundary verification. | Update checks that verify protected paths and required navigation files. |
| `notes/README.md` | Index for Jason-facing learning notes. | Update topics, reading routes, and concept index. |
| `notes/*.md` | Jason-facing personal study notes. | Add headings, indexes, summaries, and cross-links when requested; keep filenames stable unless Jason explicitly approves a rename. |

## Escalation Rule

Explicit course mirror refresh is a narrow exception: if Jason asks to copy or
refresh `../TAICA_AIASE2026/`, preserve the upstream layout exactly, exclude the
source `.git/`, and record provenance in `docs/course-mirror.md`.

If a requested change touches a protected path, pause and write down:

- the exact path
- the reason the protected file must change
- the risk to grading, links, or course automation
- the validation command or manual check that will prove the change is safe

Do not proceed with protected-path edits unless Jason explicitly confirms that
specific change.
