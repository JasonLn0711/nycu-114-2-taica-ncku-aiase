# Agent Instructions

This repository is organized with a strict separation between protected course
content and editable navigation content.

## Operating Rule

Add context around grading-sensitive material; do not reorganize the grading
material itself.

## Read-Only By Default

Treat these paths as read-only unless Jason explicitly asks for a specific edit:

- `TAICA_AIASE2026/homeworks/`
- `final-project/`
- `TAICA_AIASE2026/*.md`
- `TAICA_AIASE2026/*.ipynb`
- `TAICA_AIASE2026/*.png`
- `TAICA_AIASE2026/homeworks/HW1_result/`

Reason: these files may be referenced by instructor pages, auto-graders,
GitHub Classroom workflows, or course links. Stable paths and unchanged content
are more important than aesthetic cleanup.

For the checklist-style rule table, read
`docs/protected-paths.md`. For exception handling, read
`docs/change-policy.md`.

## Editable Areas

Agents may update these areas for organization, indexing, and handoff context:

- `README.md`
- `AGENTS.md`
- `docs/`
- `scripts/check_repo_boundaries.sh`
- `notes/README.md`
- Jason-facing learning notes under `notes/`, when the requested task is clearly
  about improving personal notes rather than course-facing assignments

## Handoff Expectations

Before editing, inspect `git status --short` and protect unrelated user work. If
grading-sensitive files appear modified or deleted, stop and resolve that
boundary before making new organizational edits.

Run `./scripts/check_repo_boundaries.sh` before and after organizational edits
when the script is available.

When adding status, reading routes, or project context, prefer external index
files in `docs/` over changing `final-project/` or `TAICA_AIASE2026/`.

Use Traditional Chinese for Jason-facing durable guidance when it improves
clarity, while preserving English technical terms, file names, commands, and
course titles.
