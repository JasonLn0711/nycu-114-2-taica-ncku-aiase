# NYCU / TAICA / NCKU AIASE Course Workspace

This repository is a local course workspace for `生成式 AI 應用系統與工程`
(`Generative AI Application Systems and Engineering`, AIASE 2026). It keeps
course-facing material, Jason-facing learning notes, and final-project planning
references in one place while preserving grading-sensitive paths.

## Start Here

- Course material and homework specs: [TAICA_AIASE2026/](TAICA_AIASE2026/)
- Personal study notes: [notes/](notes/)
- Final project planning packet: [final-project/](final-project/)
- Repo structure and edit boundaries: [docs/repo-map.md](docs/repo-map.md)
- Human reading route: [docs/reading-guide.md](docs/reading-guide.md)
- AI agent handoff rules: [docs/agent-handoff.md](docs/agent-handoff.md)
- Protected-path contract: [docs/protected-paths.md](docs/protected-paths.md)
- Change policy: [docs/change-policy.md](docs/change-policy.md)

## Protected Areas

The following areas are treated as grading-sensitive or upstream course
material. Do not move, rename, rewrite, or reformat them unless Jason explicitly
asks for that exact change.

- `TAICA_AIASE2026/homeworks/`
- `final-project/`
- course lecture files, notebooks, images, and syllabus under `TAICA_AIASE2026/`
- any path that a course script, GitHub Pages link, GitHub Classroom workflow,
  or instructor grader may expect to remain stable

## Editable Organization Layer

This repo is organized by adding navigation and context around the protected
content instead of changing the protected content itself.

- Root-level `README.md` gives the human landing page.
- `AGENTS.md` gives local agent operating rules.
- `docs/` stores repo maps, reading routes, and handoff instructions.
- `notes/README.md` indexes Jason-facing learning notes without renaming them.
- `scripts/check_repo_boundaries.sh` verifies that protected paths remain
  unchanged and required navigation files exist.

## Boundary Check

Before and after repo organization work, run:

```bash
./scripts/check_repo_boundaries.sh
```

This check confirms that protected paths have no current Git status changes and
that the navigation layer is present.

## Current Reading Priority

For course review, start with [TAICA_AIASE2026/README.md](TAICA_AIASE2026/README.md).
For personal study, start with [notes/README.md](notes/README.md). For final
project context, read [final-project/README.md](final-project/README.md) as a
reference packet only; do not edit files under `final-project/` as part of repo
cleanup.
