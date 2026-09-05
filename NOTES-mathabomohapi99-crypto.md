\## Assignment 1.3



\### Question 1 — Choosing a workflow for this sprint

For this sprint, I'd choose feature-branch over Gitflow or trunk-based. Gitflow's develop/release/hotfix structure is overhead our group doesn't need — we're not managing scheduled releases, just a single short sprint. Trunk-based would undercut the point of the assignment: our required status check and CODEOWNERS review only matter if changes sit in a PR long enough to be checked and reviewed, which trunk-based discourages by design. Feature-branch fits how our group actually worked — each task (CI setup, CODEOWNERS, the pre-commit hook, individual notes files) went on its own branch and merged independently via PR, without blocking anyone else's parallel work.



\### Question 2 — Auditing your own history

1\. "Complete Assignment 1.2 reflection" → docs (writing reflection/notes content)

2\. "Remove duplicate incomplete Assignment 1.2 section from NOTES.md" → chore (cleanup of existing content, not new documentation or a functional fix)

3\. "Restore missing QA Tester entry in team.txt" → fix (correcting missing/incorrect data)

4\. "wire up role search prompt" → feat (new user-facing functionality)

5\. "Add Search-TeamMembersByRole function" → feat (new functionality)



Commit #2 doesn't map perfectly cleanly — it's really a mix of "chore" (cleanup) and arguably "docs" since it touches NOTES.md. That tells me the commit was doing simple, low-risk work, but the message itself was written a bit loosely — it describes \*what\* was removed rather than clearly framing it as a docs cleanup, which is a small habit I'd tighten up going forward: name the type of change, not just the action.



\### Question 3 — Where your group's rebase risk lives

The clearest rebase risk in our workflow is in Task 9: one member creates a branch, a second member fetches or pulls it, and then the first member rebases and force-pushes their own branch. If that happens, the second member's local branch now points at commits that no longer exist on the remote — their history has diverged from the rewritten one. If they try to pull normally, they'll get confusing conflicts or duplicate commits, because git is trying to reconcile two different versions of "the same" history. Instead of rebasing a branch someone else has already pulled, the first member should communicate before rewriting shared history, or simply merge instead of rebase once others are already working off that branch. If a rebase is unavoidable, everyone else needs to be told to discard their local copy and re-fetch, rather than trying to merge the old and new histories together.



\### Question 4 — Designing your group's rules

Our group enabled: required pull request before merging, required 1 approval, required status check (the CI workflow), disallowed force-push, and CODEOWNERS-required review on specific paths. We chose 1 approval instead of 2 because with only 3-4 people, requiring 2 approvals risks stalling a merge if one person is busy or unavailable — a real risk in a short sprint window. To make up for the lower approval count, we rely on CODEOWNERS to guarantee that at least the right person reviews any change to their specific path, even though the group-wide rule only requires one approval overall.







\## NOTES.md Updates



\### 3. The rebase recovery

I was the one who rebased and force-pushed in Task 9. After my partner had already fetched the original branch, I amended my last commit (changing its hash) and force-pushed the rewritten history to rebase-demo. This meant my partner's local branch and the remote had diverged — same branch name, but pointing at two different, incompatible histories. I told her not to run git pull directly, since that risks a messy merge or conflict between the old and new histories. Instead, she ran git fetch origin to safely download the new history without changing her working files, then git status confirmed the divergence. Since she had no unique local work to lose, she recovered cleanly with git reset --hard origin/rebase-demo, which discarded her outdated local commit and matched her branch exactly to the rewritten remote one.

