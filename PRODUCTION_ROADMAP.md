# Production-Grade Roadmap for Kali IDE

## Phase 1: Security & Compliance (Immediate)
- [ ] Remove hardcoded credentials from `ai_supreme_boot.sh` and `antigravity_dashboard.html`.
- [ ] Implement environment variable injection for credentials.
- [ ] Enforce stricter token handling in `antigravity_shell.js`.
- [ ] Replace `sudo` passwordless config with a secure alternative (e.g., restricted sudoers per-command).

## Phase 2: System Stability & Debugging
- [ ] Refactor `ai_supreme_boot.sh` and `build_iso.sh` into modular bash scripts in `lib/`.
- [ ] Add rigorous error handling to all shell orchestration tasks (currently `set -e` is not enough).
- [ ] Audit `gemini-cli` dependencies and native modules (`node-pty`) for build stability.

## Phase 3: Live Boot Readiness
- [ ] Modernize `bootstrap_minimal_ai_kali.sh` to use an idempotent approach.
- [ ] Implement automated testing (BATS) for boot scripts to ensure ISO integrity.
- [ ] Create finalized `Kali_AI_IDE.iso` build pipeline.
