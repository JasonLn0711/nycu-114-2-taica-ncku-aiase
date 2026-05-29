# AIASE 2026 Final Project Packet

本資料夾是 `生成式AI應用系統與工程 Generative AI Application Systems and
Engineering` 期末專案的執行紀錄與規劃中心。課程正式繳交 repo 之後會由
GitHub Classroom 建立；在正式 repo 出現前，這裡先保存需求、隊伍決策、
brainstorming、proposal 草稿與開工路線。

## Source Record

- Official final project spec:
  <https://ktchuang.github.io/TAICA_AIASE2026/homeworks/TAICA2026_FinalProject.html>
- Course email PDF:
  `/home/jnclaw/Downloads/National Yang Ming Chiao Tung University Mail - Final Project 說明： 生成式AI應用系統與工程 Generative AI Application Systems and Engineering.pdf`
- LINE screenshots from `2026-05-29 11:40-11:44`, recorded in
  [team-line-record.md](team-line-record.md).

## Current Decision

- Team direction: apply as a two-person team.
- Team name from LINE: `Jamie'sLookingOut`.
- Confirmed teammate: 杜承諺.
- Teammate student ID from LINE: `514559010`.
- Teammate GitHub ID from LINE: `uttercontainer`.
- Jason GitHub ID to use unless GitHub Classroom roster says otherwise:
  `JasonLn0711`.
- Immediate owner for the Team-of-Two form: Jason volunteered to write it.
- Topic work mode: Jason starts topic ideation first; 杜承諺 finishes the video
  compression assignment and HW4, then reviews and brainstorms together later.

## Hard Deadlines

All official project deadlines use `Asia/Taipei (UTC+8)`.

| Item | Deadline | Source | Operating meaning |
| --- | --- | --- | --- |
| Team-of-Two proposal | `2026-06-02 23:59` | Official spec and course email | Submit the Google Form before this time if working as a two-person team; unapproved teams become solo submissions. |
| Final submission: `skills + report` | `2026-06-16 23:59` | Official spec and course email | The default branch on GitHub at this instant is the graded version. Commits pushed after `2026-06-16 23:59:00` are not counted. |
| Demo Day / grading run | `2026-06-17` class time | Official spec and course email | Course staff clone repos and run skills on the course Hermes Agent. No oral fix, live 補交, or post-deadline explanation can repair missing repo content. |
| NTU COOL grade entry | `2026-06-22 23:59` | Course email | Instructor-side grade-entry target. |
| GitHub Classroom invite | Weekend after `2026-05-29` | Course email | Wait for invite; create the real final repo when available. |

Team proposal form from the email:
<https://docs.google.com/forms/d/e/1FAIpQLSfaGk_Er0ehcWuvNhCGeaeThFHlCcPlyasonra2Cdox11bWNw/viewform>

## Project Thesis

This final project is a verifiable Hermes Agent skill engineering assignment.
The core design principle is to wrap a probabilistic LLM agent loop with a
deterministic skill harness: `SKILL.md` defines when and how the skill should
act, and `scripts/` provides repeatable validation, retry, parsing, and
structured-output controls.

The grading target is execution inside Hermes, not visual novelty. A focused,
installable, callable, verifiable skill earns more project value than a broad
idea that cannot survive automated grading.

## Required Tracks

All three tracks are required.

| Track | Weight | Required surface | Grading path |
| --- | ---: | --- | --- |
| Basic Track | 30 | Text2SQL skill | Hidden test automatic scoring; output contract and runnable SQL are gates. |
| Pairwise Track | 20 | Code Author or Bug Hunter role, declared in `PAIRWISE_ROLE.md` | Automatic scoring against staff/reference/student counterparts. |
| Open Track | 40 | Self-designed verifiable skill, declared in `OPEN_TRACK.md` | Compliance gate, self-declared scenario metric, staff perturbation, and interaction log quality. |
| Report + Demo Day | 10 | `report.md` | Design decisions, failure analysis with logs, improvement path, references, and actual team division. |

## Required Repo Shape

The official repo is expected to behave as a Hermes skill tap:

```text
aiase-2026-final-<github_id>/
├── skills/
│   ├── text2sql-<github_id>/
│   │   ├── SKILL.md
│   │   └── scripts/
│   ├── code-author-<github_id>/ or bug-hunter-<github_id>/
│   │   ├── SKILL.md
│   │   └── scripts/
│   └── open-<short-name>-<github_id>/
│       ├── SKILL.md
│       └── scripts/
├── PAIRWISE_ROLE.md
├── OPEN_TRACK.md
└── report.md
```

For a two-person team, the proposal and final `report.md` must explain planned
and actual division of work. The exact skill folder GitHub ID should follow the
GitHub Classroom roster mapping once the official repo is created.

## Global Output Contract

Each skill must end with one final fenced JSON block. The evaluator reads the
last ````json` fenced block from `hermes chat --toolsets skills -q` stdout.
The JSON must be a top-level object, parse cleanly, preserve `task_id` when the
input has one, and match the track-specific schema. Natural-language answers,
tables, XML, YAML, traceback-only failures, multiple JSON objects, trailing
commas, `NaN`, and hidden extra assumptions are not valid grading surfaces.

## Engineering Constraints

- Put deterministic helper logic in `scripts/`; do not require an MCP server for
  local checks.
- Keep paths relative to the repo or skill folder; no hardcoded local absolute
  paths.
- Put non-standard Python dependencies in `scripts/requirements.txt`.
- Do not depend on personal API keys, private GitHub resources, Google Drive,
  Notion, personal servers, cloud databases, or live external network access.
- Design skills to be model-agnostic. Development can use course-provided
  models, while grading uses a held-out official model choice.
- Preserve installability, `hermes skills list` discoverability, and
  non-interactive `hermes chat --toolsets skills -q` execution.

## Open Track Direction

Recommended default direction:
[brainstorming.md](brainstorming.md) proposes a `Hermes Skill Contract Auditor`
Open Track. It checks whether a skill folder satisfies installability,
frontmatter, section, script, output-contract, and scenario declaration rules,
then emits a machine-readable compliance report.

This topic is strong because it is:

- aligned with the course's verifiability mindset;
- useful for our own final repo before grading;
- naturally testable with public fixtures and staff perturbations;
- easy to split across two people without turning into a vague chatbot;
- compatible with a deterministic `scripts/` checker and clear JSON schema.

## Immediate Next Actions

- [ ] Fill the Team-of-Two proposal by `2026-06-02 23:59`.
- [ ] Confirm Jason's official GitHub Classroom ID and whether a two-person repo
  skill name should use one or both GitHub IDs.
- [ ] Ask 杜承諺 to confirm that `514559010` and `uttercontainer` are the exact
  values to submit.
- [ ] Choose Pairwise role strategy after reading the starter repo.
- [ ] Freeze the Open Track topic by `2026-05-31`.
- [ ] When the GitHub Classroom repo appears, scaffold the required files and
  copy this packet's decisions into `OPEN_TRACK.md`, `PAIRWISE_ROLE.md`, and
  `report.md` as appropriate.

## Related Files

- [team-line-record.md](team-line-record.md) records the LINE conversation facts.
- [brainstorming.md](brainstorming.md) records candidate topics and the current
  recommended Open Track implementation path.
- [team-of-two-proposal-draft.md](team-of-two-proposal-draft.md) is the
  proposal-form draft.
