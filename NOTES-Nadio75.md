# NOTES-Nadio75

## Assignment 1.3

### Question 1 — Choosing a workflow for this sprint

For a 5-person group working on a small shared codebase over a short sprint window, I'd choose **feature-branch workflow** over Gitflow or trunk-based.

Gitflow adds overhead this project doesn't need — separate `develop`/`release`/`hotfix` branches make sense for software with staged releases and long-lived versions, but a short sprint has no release cycle to manage, so the extra branch types would just add friction without solving a real problem.

Trunk-based development (everyone committing small changes close to `main`, frequently) works well for teams with mature CI and high commit discipline, but with 5 people learning these rules for the first time, integrating every change near-instantly to `main` raises the risk of half-finished or conflicting work landing before it's reviewed — exactly what this sprint's branch protection rules are meant to prevent.

Feature-branch fits best: each person can work in isolation on their own branch, open a PR when ready, and go through review and required checks before merging — which matches the assignment's actual requirements (PR review, status checks, CODEOWNERS) far more naturally than trunk-based would.

### Question 2 — Auditing your own history

Five real commits from my Assignment 1.1/1.2 history, reclassified with Conventional Commits types:

**"Add search function to filter team by name"** reclassifies as `feat`, since it adds new functionality — a capability the CLI didn't have before.

**"Handle missing team.json file gracefully"** reclassifies as `fix`, since it addresses a failure case (crash or bad behavior) rather than adding new behavior.

**"Add usage instructions to README"** reclassifies as `docs`, since it's documentation only, with no code changed.

**"Add CI workflow to verify required documentation files exist"** reclassifies as `chore` (arguably `ci`). This is tooling/infrastructure rather than app behavior — some Conventional Commits configs add a dedicated `ci` type for exactly this, which this commit would fit even better than `chore`.

**"Resolve README conflict between purpose statement and description"** doesn't map cleanly onto a single type — see below.

The "Resolve README conflict between purpose statement and description" commit doesn't fit a single Conventional Commits type. It's not a `feat` (no new capability), not really a `fix` (nothing was broken, it was two people's changes colliding), and not purely `docs` either, since the actual content of the change is really "merge conflict resolution," which isn't a type Conventional Commits accounts for at all.

That tells me this commit was doing something structurally different from the others — it wasn't a unit of *work*, it was a unit of *reconciliation* between two units of work. In hindsight, a commit like this is honest about what happened (which is good — I didn't disguise it as a `docs:` commit just to fit the convention), but it's also a sign that two people touched the same section of the same file without coordinating first, which is exactly the kind of collision Assignment 1.3's Task 8 asks us to reproduce and handle deliberately instead of accidentally.

### Question 3 — Where your group's rebase risk lives

The clearest rebase-risk moment is in Task 9 itself, but a realistic parallel risk shows up in Task 5/6: once a group member pushes their feature branch and a teammate reviewing their PR (Task 7) pulls that branch locally to test it, if the original author then rebases and force-pushes to "clean up" their commits before merging, the reviewer's local copy diverges from the remote.

If that happened, the reviewer's next `git pull` would either fail or create a messy merge tangling the old and rebased history together — and if they pushed that merge back up, it could reintroduce commits the author had intentionally rewritten.

What should happen instead: once a branch has been fetched or pulled by someone else, treat it as shared history — don't rebase it. If cleanup is genuinely needed, communicate first so the puller knows to discard their local copy and re-fetch, rather than silently force-pushing and letting them discover it themselves.

### Question 4 — Designing your group's rules, before you configure them

Our group will enable:
- **Require a pull request before merging** — no direct commits to `main`, so every change is visible and reviewable.
- **Require at least 1 approval** — with 5 people, requiring 2 approvals risks stalling merges if two people are unavailable at once; 1 approval still forces review without creating a bottleneck.
- **Require status checks to pass** — so CI catches breakage before merge, not after.
- **Disallow force pushes to `main`** — protects shared history integrity.
- **CODEOWNERS-required review** for specific paths, so the person most familiar with that part of the code is looped in automatically.

Trade-off: requiring only 1 approval means a PR could theoretically merge with an approval from someone unfamiliar with that area of the code, rather than the most relevant reviewer. We're accepting that risk in exchange for merge speed, and mitigating it partially through CODEOWNERS auto-requesting the relevant person — though CODEOWNERS review isn't strictly *required* to merge (that's Stretch Goal A), so it's a soft mitigation, not a hard guarantee.


## Reflection

1. Which rule mattered most, in practice

The required status check mattered most in practice. When I opened a PR that deliberately renamed README.md to simulate a failure, the CI check genuinely failed and the merge button stayed disabled even after a teammate approved the PR — proving that approval alone wasn't enough to merge. This showed the two rules (approval and status checks) work independently, not as a single combined gate, which isn't obvious until you actually watch it happen.

2. The conflict, from the inside

I observed the Task 8 conflict resulting from two parallel feature branches — team-summary and sort-team-alphabetically — both touching the same section of README.md at the same time. When the second PR was opened, GitHub flagged a real conflict on that shared section. Resolving it meant looking at both additions and deciding how to combine them into a single coherent README section, rather than just picking one version and discarding the other's work.

3. The rebase recovery

I wasn't one of the two people directly involved in the Task 9 rebase-and-recover exercise. If it happened to me unannounced, the first thing I'd do is not panic and not try to manually patch my local branch — I'd communicate with whoever rewrote the history to understand what changed, then run git fetch followed by git reset --hard origin/<branch> if my local work had nothing unique to preserve, rather than attempting a merge that would tangle the old and rewritten history together.

4. What you'd change about your group's rules

Now that we've worked under these rules for a full sprint, I'd tighten the CODEOWNERS setup specifically — right now it maps paths to individual members but doesn't require their approval to merge (that's Stretch Goal A, which we didn't implement). During the sprint, PRs could merge with just any one approval, not necessarily the person most familiar with that file. Requiring the actual code owner's approval on their mapped paths would close that gap without adding much overhead, since we're already routing the review request to them anyway.