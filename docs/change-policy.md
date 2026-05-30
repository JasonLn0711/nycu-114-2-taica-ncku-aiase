# Change Policy

This repo uses a first-principles boundary: protect grader-facing course
content, and improve readability through external navigation layers.

## Repo Cleanup

Repo cleanup may update:

- `README.md`
- `AGENTS.md`
- `docs/`
- `scripts/check_repo_boundaries.sh`
- `notes/README.md`

Repo cleanup may add navigation, indexes, reading routes, handoff guidance,
boundary checks, and policy documents.

Repo cleanup must not move, rename, rewrite, or reformat:

- `TAICA_AIASE2026/homeworks/`
- `final-project/`
- course lectures, notebooks, images, syllabus, generated homework result
  files, or any path likely to be referenced by instructor automation

## Course Mirror Refresh

Course mirror refresh is different from repo cleanup. It may update
`TAICA_AIASE2026/` only when Jason explicitly asks to copy or refresh the
upstream course checkout.

Allowed mirror refresh:

- copy from `../TAICA_AIASE2026/` into `TAICA_AIASE2026/`
- exclude the source `.git/` directory
- preserve upstream file names and directory layout
- record provenance in `docs/course-mirror.md`
- update external indexes under `docs/` so readers can find newly mirrored
  weeks, homework specs, result pages, or official project specs

Not allowed during mirror refresh:

- rewrite course files for style
- split or rename upstream files
- move images, notebooks, homework result pages, or official specs
- mix Jason-facing notes into `TAICA_AIASE2026/`

## Notes Cleanup

Notes cleanup may update Jason-facing learning notes under `notes/` when the
task is clearly about readability or study value.

Allowed note cleanup:

- add or normalize headings
- add a local table of contents
- add short summaries
- add cross-links to course files or other notes
- clarify personal explanations without changing course specs

Avoid note cleanup that would break references:

- do not rename note files in the first cleanup phase
- do not move note files unless a later migration plan updates all links
- do not mix official homework instructions into personal notes as if they were
  the canonical source

## Final Project Handling

`final-project/` is a read-only source packet for repo organization work.

Allowed:

- read `final-project/README.md`
- link to final-project files from external docs
- create external navigation or policy files under `docs/`

Not allowed during cleanup:

- edit final-project files
- move or rename final-project files
- create new cleanup-only status files inside `final-project/`
- duplicate final-project details into multiple places where they may drift

## Protected-File Exception Process

If a protected file truly needs to change, prepare a short change note before
editing:

```text
Protected path:
Reason:
Risk:
Requested operation:
Validation:
Rollback plan:
```

Proceed only after Jason explicitly approves the specific protected-path change.

## Verification

Run the boundary check before and after repo organization work:

```bash
./scripts/check_repo_boundaries.sh
```

A passing check means required navigation files exist and protected paths have
no current Git status changes. It does not prove the course content is correct;
it proves the cleanup stayed outside the protected boundary.
