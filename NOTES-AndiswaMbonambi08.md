\## Assignment 1.3



\### Question 1 — Choosing a workflow for this sprint

Feature-branch is the right choice for this sprint, not Gitflow or trunk-based. Gitflow's

release/develop/hotfix branch structure exists to manage staged releases across environments —

overhead this sprint doesn't need, since there's no release train or production/staging split to

coordinate. Trunk-based works well when a team has mature CI and a habit of small, frequent merges

straight to main, but it assumes low review friction; for a group whose branch protection rules are

being configured for the first time, skipping PRs entirely would remove the exact practice (real

review, real conflict resolution) this assignment is testing. Feature-branch gives each person an

isolated space to work in parallel, creates a natural point for review before code lands on main, and

lines up directly with the branch protection rules already in place (PR required, approval required).



\### Question 2 — Auditing your own history

1\. c2327c7 "Add Search-TeamMembersByRole function" → feat

2\. be0a33b "wire up role search prompt" → feat

3\. 2bd1168 "Restore missing QA Tester entry in team.txt" → fix

4\. 08c302a "Remove stray file created by mistyped command" → chore

5\. dba9443 "made change to the layout and Add details to team.txt" → doesn't map cleanly (feat + style

&#x20;  bundled together). This commit mixed a layout change with a new data entry — two unrelated concerns

&#x20;  in one commit. It should have been split: one commit for the layout, one for the data. Bundling them

&#x20;  makes the history harder to scan, and a revert of one change would drag the other with it.



\### Question 3 — Where your group's rebase risk lives

The clearest rebase-risk moment is Task 9 itself: one member creates a branch, a second member

fetches or pulls it to review or build on, and then the first member rebases and force-pushes their

own branch. Once that happens, the second member's local branch history no longer matches the

remote — their commits are now based on commits that no longer exist upstream, so their next

`git pull` either fails or creates a confusing duplicate history. What they should do instead of guessing

is stop, communicate with whoever rebased, confirm whether their own local work has anything unique

worth keeping, and if not, run `git fetch` followed by `git reset --hard origin/<branch>` to snap their

local branch back in line with the rewritten remote history — rather than attempting to merge or rebase

on top of a branch that already changed underneath them.



\### Question 4 — Designing your group's rules, before you configure them

Enable: required PR before merging, 1 required approval, disallowed force-push, a required status

check, and CODEOWNERS-required review on the path it covers. Skip requiring 2 approvals — with a

3-4 person group, 1 approval keeps merges moving without becoming a bottleneck if someone is

temporarily unavailable, while still enforcing a second set of eyes on every change. Trade-off: if the one

person CODEOWNERS designates for a given path is unavailable, PRs touching that path stall until they

review. The group's answer to that is naming a backup reviewer for that path, so a merge is never

blocked indefinitely on a single person's availability.


### Task 4 — Pre-commit hook (Husky)
Set up a Husky pre-commit hook that blocks any commit staging a .env file.
Demonstrated live: staged a test .env file and attempted to commit —
the commit was rejected with:

"Commit blocked: .env file is staged. Remove it before committing."
husky - pre-commit script failed (code 1)

The .env file was never actually committed; it was reset and removed
immediately after the demonstration.

