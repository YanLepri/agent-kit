---
root: false
targets: ["*"]
description: "Run everything you generate through the antislop skills before delivering it"
globs: ["**/*"]
---

# Antislop

Nothing you generate is delivered before it passes through the antislop skills. This covers code, UI, copy, documentation, commit messages, code comments, and the explanations you write for the user. Subagents are no exception: each one runs its own pass, because its output reaches the user.

1. Pick the skills by the kind of output. If more than one applies, apply all of them.
   - `antislop`: baseline for any output.
   - `antislop-code`: source code, tests, scripts, configuration, and code comments.
   - `antislop-copywriting`: user-facing text such as UI labels, error and empty-state messages, marketing copy, READMEs, and commit messages.
   - `antislop-human`: prose written for a person, such as explanations, summaries, reports, and pull request descriptions.
   - `antislop-ui`: the visual design of interfaces.
   - `antislop-layoutmobile`: responsive and mobile layouts.
2. Work in two steps: draft, then review the draft against the skill and fix what it flags. Deliver the revised version, never the first draft.
3. Do not narrate the pass inside the deliverable. In your final message, state in one line which antislop skills you applied.
4. If a skill is not installed, say so in that same line, apply the others, and do not improvise its rules.
5. Project conventions win. If an antislop skill asks for something that differs from the project's established pattern, follow the Golden Rule: ask before deviating.
