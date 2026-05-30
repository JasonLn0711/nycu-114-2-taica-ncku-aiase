# Agent Handoff

This file gives AI agents a stable operating contract for this repo.

## First Commands

Run these before editing:

```bash
pwd
git status --short
find . -maxdepth 3 -type f | sort
./scripts/check_repo_boundaries.sh
```

If `TAICA_AIASE2026/` or `final-project/` files appear modified, deleted, or
renamed, treat that as a protected-content boundary issue before adding new
organizational work.

## Read-Only Boundaries

Do not automatically rename, move, reformat, or rewrite:

- `TAICA_AIASE2026/homeworks/`
- `final-project/`
- lecture files, syllabus, notebooks, result HTML/JSON, and images under
  `TAICA_AIASE2026/`

These paths may be used by automated grading, GitHub Pages, instructor scripts,
or final-project submission workflows.

## Preferred Edit Targets

For organization and readability tasks, prefer:

- `README.md`
- `AGENTS.md`
- `docs/repo-map.md`
- `docs/course-mirror.md`
- `docs/reading-guide.md`
- `docs/agent-handoff.md`
- `docs/protected-paths.md`
- `docs/change-policy.md`
- `scripts/check_repo_boundaries.sh`
- `notes/README.md`

For Jason-facing personal learning improvements, `notes/` can be edited when
the requested task clearly targets notes. Keep existing note filenames stable
unless Jason explicitly approves a rename.

## Current Active Context

The active final-project context is recorded in
`final-project/README.md`. Use it as a read-only source packet. If additional
status needs to be recorded during repo organization, create or update an
external tracking file in `docs/` instead of modifying `final-project/`.

`TAICA_AIASE2026/` is a source mirror from `../TAICA_AIASE2026/`. Refresh it
only on explicit request, keep the upstream layout intact, and never copy the
source `.git/` directory.

## Completion Check

Before finishing organizational work, verify:

- required navigation files exist
- protected homework and final-project files are not modified
- no course lecture, notebook, image, or generated result path was moved
- new docs link to protected content instead of copying or rewriting it
- `./scripts/check_repo_boundaries.sh` passes
