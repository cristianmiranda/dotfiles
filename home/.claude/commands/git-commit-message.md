Check the staged changes and generate a conventional commit message based on the current branch prefix. If no changes are staged, remind me to stage them first.

First, run `git diff --staged` to see what changes are staged.

Then get the current branch name and extract its prefix (the part before the first underscore).

Generate a commit message following these rules:
- Subject line format: `<branch_prefix> <context>: <description>`
- Max 72 characters including prefix and context
- Don't start description with capital letter
- Context = name of the module or program being changed
- Focus on WHAT and WHY, not HOW

Also generate an optional commit body with more details if needed (keep it concise).

Present the commit message with formatting:
```
Branch prefix: <prefix>
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

<subject line>

<body if applicable>

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Then show the git commit command that would be executed:
```
git commit -m "<subject>" [-m "<body>"]
```

Offer options:
- [c] - Execute the commit
- [e] - Edit the message manually
- [a] - Abort

Execute the chosen action accordingly.