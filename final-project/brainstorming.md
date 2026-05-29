# Final Project Brainstorming And Implementation Planning

This file starts the topic discussion for the AIASE final project. The planning
principle is simple: choose a topic that looks good because it is verifiable,
installable, and useful inside Hermes, not because it sounds broad.

## Design Target

The Open Track should demonstrate a concrete, testable capability:

- input can be described in a fixed schema;
- success can be judged automatically;
- staff perturbation can change names, file order, wording, or edge cases
  without changing the task;
- the skill has deterministic scripts that validate and package the final JSON;
- the result produces useful logs for `report.md`.

For a two-person team, the Open Track should include at least two independently
verifiable scenarios or a clearly stronger multi-skill / multi-agent design.

## Candidate Topics

| Candidate | Skill idea | Verifiability | Strength | Risk |
| --- | --- | --- | --- | --- |
| Skill Contract Auditor | Given a Hermes skill folder, inspect `SKILL.md`, frontmatter, required sections, scripts, requirements, and output-contract declarations, then emit a JSON compliance report. | High: fixtures can encode expected pass/fail checks; deterministic file scanning can verify most fields. | Best fit for the course; helps our own final repo before grading. | Needs careful schema so the LLM cannot hand-wave missing files. |
| Assignment Deadline Extractor | Given an assignment spec/email, extract deadlines, deliverables, and submission gates into JSON. | Medium-high: public specs with gold JSON can be fixtures; perturb wording/order. | Useful for Jason's workflow and course planning. | More NLP-heavy; date ambiguity can create evaluator disputes. |
| Safe Shell Plan Reviewer | Given a proposed agent shell plan, classify destructive commands, path risks, missing confirmation gates, and safe alternatives. | High for curated fixtures; deterministic regex/AST shell parsing can support it. | Practical for agent safety and easy to explain. | Needs a bounded command grammar to avoid subjective safety calls. |
| Evidence Packet Builder | Given logs, test results, and repo metadata, create a traceability JSON for report evidence. | High when fixtures are fixed. | Directly supports report writing. | May look like packaging rather than a distinctive skill. |
| Multi-Agent Handoff Checker | Given two skill outputs, check whether information passed cleanly between agents and classify failure mode. | Medium: can use synthetic paired outputs and MAST-style labels. | Shows multi-agent thinking. | More subjective unless the schema is tightly bounded. |

## Recommended Topic

Recommendation: build `Hermes Skill Contract Auditor`.

Working title:

```text
open-skill-contract-auditor-<github_id>
```

Positive capability:

> The skill helps a Hermes developer check whether a skill folder is ready for
> automated grading: it verifies structure, naming, required sections, script
> dependencies, output-contract declarations, public scenario declarations, and
> common reproducibility risks, then emits one machine-readable JSON report.

This topic naturally turns the final project's own grading rules into a useful
engineering artifact. It also matches the team name `Jamie'sLookingOut`: the
skill "looks out" for missing contracts before the grader does.

## Proposed Input Schema

The skill receives a task like:

```json
{
  "task_id": "audit-public-001",
  "skill_path": "fixtures/skills/good_text2sql",
  "track": "open",
  "expected_skill_name": "open-skill-contract-auditor-JasonLn0711",
  "checks": [
    "frontmatter",
    "folder_name",
    "required_sections",
    "scripts",
    "output_contract",
    "open_track_scenarios"
  ]
}
```

## Proposed Output Schema

The final fenced JSON block should contain:

```json
{
  "task_id": "audit-public-001",
  "verdict": "pass",
  "score": 1.0,
  "checks": [
    {
      "id": "frontmatter.name_matches_folder",
      "status": "pass",
      "evidence": "SKILL.md name equals folder name"
    }
  ],
  "failures": [],
  "warnings": [],
  "confidence": 0.98
}
```

Allowed `verdict`: `pass`, `warn`, `fail`.

Allowed check status: `pass`, `warn`, `fail`, `not_applicable`.

## Deterministic Harness

Core scripts:

```text
skills/open-skill-contract-auditor-<github_id>/
├── SKILL.md
├── scripts/
│   ├── audit_skill.py
│   ├── check_frontmatter.py
│   ├── check_sections.py
│   ├── check_scripts.py
│   ├── check_open_track.py
│   └── json_contract.py
├── references/
│   └── checklist.md
└── fixtures/
    ├── good_skill/
    ├── missing_json_contract/
    ├── bad_frontmatter/
    └── open_track_weak_metric/
```

The deterministic part should do as much real checking as possible:

- parse YAML-like frontmatter with a small local parser;
- compare folder name against `name`;
- scan for required headings such as `When to Use`, `Procedure`,
  `Verification`, and `Pitfalls` when track-specific rules require them;
- verify `scripts/` exists when the skill claims deterministic helpers;
- read `scripts/requirements.txt` if present;
- reject absolute-path references and personal-secret patterns;
- inspect `OPEN_TRACK.md` for the seven required headings;
- ensure at least three public scenario examples exist for Open Track;
- package final output through a script that always emits valid JSON.

The LLM-facing `SKILL.md` should instruct Hermes to run `scripts/audit_skill.py`
and use its JSON result as the source of truth, rather than inventing results
from natural language.

## Public Scenario Set

At minimum:

| Scenario | Fixture | Expected result | Perturbation idea |
| --- | --- | --- | --- |
| Good skill | `fixtures/good_skill/` | `pass`, no failures | Reorder sections; keep required headings. |
| Missing output contract | `fixtures/missing_json_contract/` | `fail`, output-contract check fails | Add unrelated good prose; checker must still fail. |
| Bad frontmatter | `fixtures/bad_frontmatter/` | `fail`, name/folder mismatch | Change folder alias while preserving markdown body. |
| Weak Open metric | `fixtures/open_track_weak_metric/` | `warn` or `fail`, metric not automatable | Replace examples with keyword-only checks. |

This gives more than the three public examples required by the Open Track and
creates a credible two-person scale.

## Team Work Split Draft

This is a proposal draft, not a permanent lock.

| Owner | Work lane | Concrete outputs |
| --- | --- | --- |
| Jason | Spec integration, Basic Text2SQL baseline, Open Track contract and report narrative | `OPEN_TRACK.md`, Open Track JSON schema, `report.md` design/failure sections, Basic Track harness. |
| 杜承諺 | Pairwise role implementation, Open Track fixtures and perturbation tests | `PAIRWISE_ROLE.md`, pairwise skill implementation, fixture suite, failure-mode logs. |
| Shared | Hermes setup and final grading rehearsal | `hermes skills list`, `hermes chat --toolsets skills -q`, `python run_dev.py`, final submission checklist. |

If the starter repo strongly favors a single Pairwise role, choose the role after
reading its dev set and reference skills. For a two-person team, prefer a role
strategy that shows both members' engineering contribution in `report.md`.

## Implementation Roadmap

### Phase 0: Proposal Gate, Now To `2026-06-02`

- Submit Team-of-Two form.
- Freeze Open Track direction and team split.
- Prepare a short note for 杜承諺 to review after work.

### Phase 1: Starter Repo Scaffold

- Accept GitHub Classroom invite.
- Confirm official repo name, default branch, GitHub ID mapping, and starter
  repo version.
- Create required files: `PAIRWISE_ROLE.md`, `OPEN_TRACK.md`, `report.md`,
  Basic skill folder, Pairwise skill folder, Open skill folder.
- Install Hermes using starter repo instructions and verify `hermes doctor`.

### Phase 2: Basic And Pairwise Baselines

- Build Text2SQL as a strict output-contract skill first.
- Add `scripts/validate_sql.py` and `scripts/run.py` style wrappers.
- Choose Pairwise role and implement a smallest passing harness.
- Keep logs for failed runs immediately, because report scoring values
  concrete failure analysis.

### Phase 3: Open Track Contract Auditor

- Build fixture folders.
- Implement deterministic audit scripts.
- Write `SKILL.md` to call the audit script and emit only final fenced JSON.
- Fill `OPEN_TRACK.md` with seven required headings, three or more public
  scenarios, anti-hardcoding explanation, expected output schema, and token
  estimate.

### Phase 4: Final Hardening

- Run local `hermes chat --toolsets skills -q` commands for every track.
- Run `python run_dev.py` for Basic if starter repo provides it.
- Confirm no absolute paths, secrets, external services, MCP dependency, or
  network requirement.
- Fill `report.md` with design decisions, logs, failure analysis, improvement
  path, references, and actual two-person division.
- Merge final work to default branch before `2026-06-16 23:59`.

## Discussion Prompts For The Team

- Do we want the Open Track to audit general Hermes skills, or specifically
  audit AIASE final-project submissions?
- Should the Open Track output only pass/fail, or include a numeric score plus
  warnings?
- Which Pairwise role gives the better path for two-person contribution and
  scoring reliability?
- What is the smallest set of fixtures that proves the metric is not gameable?
- How do we keep all reference code and AI-assisted edits clearly cited?
