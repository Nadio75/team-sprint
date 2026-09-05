## Assignment 1.3

### Question 1 — Choosing a workflow for this sprint

For this sprint, I would use a feature-branch workflow. We have a small group working on the same repository at the same time, so giving each piece of work its own branch allows us to work independently without making direct changes to main. It also works well with the pull request and review requirements of this assignment.

I would not choose Gitflow because it introduces extra long-lived branches such as develop and release branches, which would add unnecessary complexity for a short sprint like this. I would also not use trunk-based development because our assignment specifically requires pull requests, reviews, repository rules, and a deliberate conflict exercise. Short-lived feature branches give us enough separation while still allowing us to merge changes frequently.

### Question 2 — Auditing my own history

Looking back at my Assignment 1.1 and 1.2 history, these are five real commits I made and how I would classify them using Conventional Commits:

1. `Display team members in directory` → `feat: display team members in directory`
   This introduced user-visible functionality, so I would classify it as a feature.

2. `Add sample team member data` → `chore: add sample team member data`
   This added supporting data for the application rather than changing the main behaviour.

3. `Fix Assignment 1.2 notes heading` → `docs: fix Assignment 1.2 notes heading`
   This only corrected documentation, so `docs` is the appropriate type.

4. `Document team summary feature` → `docs: document team summary feature`
   This was a documentation change made after review feedback and did not change the feature itself.

5. `Add role counts to team summary` → `feat: add role counts to team summary`
   This extended the team summary with new functionality, so I would classify it as a feature.

These commits map reasonably well to individual Conventional Commit types. Looking back at them shows why keeping commits focused is useful: when one commit has one clear purpose, it is much easier to classify and understand later.

### Question 3 — Where our group's rebase risk lives

The biggest rebase risk is during Task 9, when one member creates a branch and another member has already fetched or pulled that branch. If the first person then rebases and force-pushes it, the commit history is rewritten and the second person's local branch will still contain the old history. The two copies will then diverge.

The person who already has the branch should not continue working as if nothing happened. The team should communicate first. If there is no unique local work that needs to be kept, the affected member can fetch the rewritten remote history and reset the local branch to `origin/<branch>`. In normal team work, we should avoid rebasing and force-pushing shared branches once other people are using them.

### Question 4 — Designing our group's rules

For this sprint, I would enable a required pull request before merging into main, at least one required approval, required status checks, disallow force-pushes on main, and use CODEOWNERS-required review for the paths assigned to specific team members.

The required pull request prevents changes from going straight into main without review. One approval gives another team member a chance to check the change before it is merged. Required status checks prevent a PR from being merged when the automated checks are failing. Disallowing force-pushes protects the history of main from being rewritten. CODEOWNERS helps make sure that changes to important paths are reviewed by the person responsible for them.

For our small group, I would require one approval rather than two. Two approvals could give more review coverage, but in a group of three or four people it could also stop the sprint if one person is unavailable. One required approval, together with CI and CODEOWNERS where appropriate, gives us protection without making it unnecessarily difficult to merge work.
