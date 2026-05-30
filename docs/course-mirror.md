# Course Mirror

This file records how `TAICA_AIASE2026/` is maintained inside this repo.

## Source

- Source directory: `../TAICA_AIASE2026/`
- Source type: separate Git checkout of the course material
- Imported source commit observed during this refresh:
  `c1a0dcb Merge branch 'ktchuang:main' into main`
- Import rule: copy the source working-tree content, excluding the source
  `.git/` directory.

## Mirror Role

`TAICA_AIASE2026/` is an upstream course mirror. It is not the place for
Jason-facing interpretation, repo cleanup notes, or AI-agent planning.

Use it for:

- course README, syllabus, and weekly lecture files
- homework specs and official result pages
- course notebooks, images, and official final-project HTML

Do not use it for:

- personal explanations
- local planning notes
- final-project team decisions
- repo governance notes

Those belong in `notes/`, `final-project/`, and `docs/` respectively.

## Current Imported Surface

Course top level:

- `README.md`
- `syllabus.md`
- `W1.md`, `W1-Supplement1.md`
- `W2.md`, `W2-Supplement1.md`, `W2-Supplement2.md`
- `W2_StockHeatMap_v3.ipynb`
- `W3.md`
- `W5.md`
- `W6.md`
- `W7.md`
- `W8.md`
- invited-talk images from `318` through `527`

Homework / project surface:

- `homeworks/pre-test.md`
- `homeworks/HW1.md`
- `homeworks/HW2.md`
- `homeworks/HW3.md`
- `homeworks/HW4.md`
- `homeworks/HW4-python-starter.zip`
- `homeworks/HW1_result/`
- `homeworks/HW2_result/`
- `homeworks/HW3_result/`
- `homeworks/TAICA2026_FinalProject.html`

## Refresh Procedure

Refresh only when Jason explicitly asks to update the course mirror.

```bash
rsync -av --exclude='.git/' ../TAICA_AIASE2026/ TAICA_AIASE2026/
```

After refresh:

```bash
diff -qr --exclude='.git' ../TAICA_AIASE2026 TAICA_AIASE2026
git diff --check
```

The boundary check intentionally reports protected-path changes while a mirror
refresh is uncommitted. After the mirror refresh is committed, run:

```bash
./scripts/check_repo_boundaries.sh
```

The check should pass once the explicit mirror update is recorded in Git.
