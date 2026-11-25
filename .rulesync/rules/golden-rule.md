---
root: false
targets: ["*"]
description: "Always follow the project's established conventions first; ask before any deviation and state the current pattern"
globs: ["**/*"]
---

# Golden Rule: Project Conventions First

The project's established conventions come first. They take precedence over any skill, rule, subagent instruction, or default best practice, including the antislop, framework, and design skills.

1. **Find the convention before you write.** Before creating or changing code, tests, configuration, documentation, or copy, identify how the project already does that thing. Read the neighboring files and the closest existing implementation, and check the linter, formatter, TypeScript, and build configuration, the `README`, `CONTRIBUTING`, and any ADRs. Use CodeGraph to find examples.
2. **Follow it.** Match naming, structure, libraries, error handling, test style, formatting, commit style, and language, even when a skill describes something it considers better.
3. **Stop and ask when an instruction would deviate.** If a skill, rule, or subagent instruction would make the implementation differ from the project's pattern, do not implement it and do not mix both styles. Ask first. The question must contain:
   - **Current pattern:** what the project does today, with a file path as evidence.
   - **The instruction:** what is being asked, and which skill, rule, or agent asks it.
   - **The deviation:** how the implementation would depart from the pattern, and what would become inconsistent or affected.
   - **Options:** follow the project pattern (recommended by default), deviate in this change only, or deviate and propose migrating the rest.

   Wait for the answer before proceeding.
4. **If you cannot ask** (for example, you run as a subagent without direct access to the user), stop and return that question to the caller instead of choosing.
5. **Apply the answer consistently.** If a deviation is approved, apply it consistently across the change and suggest recording the decision, for example as an ADR.
6. **Explicit user requests.** A specific request from the user is already their decision. Follow it, but state in one line which project convention it departs from.
7. **No convention yet.** If the project has no established pattern for the thing (an empty area or a new project), follow the skills and say which convention you are establishing.
8. **Conflicting conventions.** If the project is inconsistent, follow the most recent or dominant pattern, say which one you chose and why, and ask if it is unclear.
