# Team-of-Two Proposal Draft

Deadline: `2026-06-02 23:59 Asia/Taipei`.

Use this as the working content for the Team-of-Two Google Form. Final answers
should be adjusted to the exact form fields.

## Team Identity

- Team name: `Jamie'sLookingOut`
- Course: `生成式AI應用系統與工程 Generative AI Application Systems and Engineering`
- Project: AIASE 2026 Final Project, Hermes Agent verifiable skill engineering

## Members

| Member | Student ID | GitHub ID | Current confirmation state |
| --- | --- | --- | --- |
| Jason Lin | To be filled by Jason | `JasonLn0711` unless Classroom roster says otherwise | Needs final form value check. |
| 杜承諺 | `514559010` | `uttercontainer` | Provided in LINE on `2026-05-29`. |

## Proposed Project Direction

We plan to build the required Hermes Agent skill tap with Basic, Pairwise, and
Open Track deliverables. For the Open Track, our current direction is a
`Hermes Skill Contract Auditor`: a verifiable skill that inspects a Hermes skill
folder, checks frontmatter, naming, required sections, deterministic scripts,
dependency declarations, Open Track scenario declarations, and output-contract
readiness, then emits a machine-readable JSON compliance report.

This direction directly supports the course theme of deterministic shell around
probabilistic agent behavior. It can be validated through public fixture skills
and staff perturbations, and it produces concrete logs for the final report.

## Planned Division Of Work

| Member | Planned responsibility |
| --- | --- |
| Jason | Integrate official spec into repo requirements, build or co-build Basic Text2SQL baseline, draft `OPEN_TRACK.md`, define the Open Track schema and verifiability argument, write report design and failure-analysis sections. |
| 杜承諺 | Implement or co-implement Pairwise role, build Open Track fixtures and perturbation checks, help validate Hermes execution, collect logs and edge cases for report evidence. |
| Shared | Final Hermes install/run rehearsal, cross-review of `SKILL.md` files, JSON output-contract checks, default-branch submission before the deadline. |

## Two-Person Scope Justification

The two-person plan is larger than a solo implementation because it includes:

- the required Basic Track;
- a Pairwise implementation with documented role strategy;
- an Open Track with multiple independently verifiable fixture scenarios;
- deterministic checker scripts rather than a prompt-only skill;
- shared Hermes execution evidence and report-level failure analysis.

## Form Checklist

- [ ] Confirm Jason's student ID.
- [ ] Confirm exact spelling of team name.
- [ ] Confirm whether the form requires topic title or only member data.
- [ ] Confirm both GitHub IDs against GitHub Classroom roster mapping.
- [ ] Submit before `2026-06-02 23:59`.
