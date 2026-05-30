#!/usr/bin/env sh
set -eu

failures=0

fail() {
  printf 'FAIL %s\n' "$1" >&2
  failures=$((failures + 1))
}

pass() {
  printf 'OK %s\n' "$1"
}

check_required_file() {
  path=$1
  if [ -f "$path" ]; then
    pass "required file exists: $path"
  else
    fail "required file missing: $path"
  fi
}

check_clean_path() {
  path=$1
  if [ ! -e "$path" ]; then
    fail "protected path missing: $path"
    return
  fi

  status=$(git status --short -- "$path")
  if [ -z "$status" ]; then
    pass "protected path unchanged: $path"
  else
    fail "protected path has changes: $path"
    printf '%s\n' "$status" >&2
  fi
}

if ! git rev-parse --show-toplevel >/dev/null 2>&1; then
  fail "not inside a git repository"
else
  repo_root=$(git rev-parse --show-toplevel)
  cd "$repo_root"
fi

check_clean_path "TAICA_AIASE2026"
check_clean_path "TAICA_AIASE2026/homeworks"
check_clean_path "final-project"

check_required_file "README.md"
check_required_file "AGENTS.md"
check_required_file "docs/repo-map.md"
check_required_file "docs/reading-guide.md"
check_required_file "docs/agent-handoff.md"
check_required_file "docs/protected-paths.md"
check_required_file "docs/change-policy.md"
check_required_file "notes/README.md"
check_required_file "scripts/check_repo_boundaries.sh"

if [ "$failures" -eq 0 ]; then
  printf 'Boundary check passed.\n'
  exit 0
fi

printf 'Boundary check failed with %s issue(s).\n' "$failures" >&2
exit 1
