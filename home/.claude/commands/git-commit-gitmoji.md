Check the staged changes and generate a gitmoji-style commit message. If no changes are staged, remind me to stage them first. 

First, run `git diff --staged` to see what changes are staged.

Then generate a commit message following this format:
- Format: `<emoji> <prefix>: <title>`
- Max 72 characters total
- Use the appropriate gitmoji:
  - ✨ - New feature
  - 🐛 - Bug fix  
  - 🔧 - Configuration or tooling
  - 💄 - UI or styling changes
  - ♻️ - Refactor code
  - 🔥 - Remove code or files
  - 🚀 - Deploy stuff
  - 📦 - Add or update packages
  - 🔒 - Security improvement
  - ⚡ - Performance improvement
  - 📝 - Documentation
  - 🗑️ - Deprecation or removal
- Prefix = affected component (e.g. polybar, aichat, arch)
- Use colon + space after prefix
- Title uses sentence-style capitalization

Also generate a brief commit body (3 lines max) that explains:
- Why the change was made
- What problem it solves
- Any important implementation details

Present the commit message and body, then offer options:
- [c] - Commit with just the message
- [b] - Commit with message and body
- [r] - Show the git command to refine manually
- [a] - Abort

Execute the chosen action accordingly.