---
argument-hint: [reference]
description: "🖼️ - Save clipboard images to /tmp for further processing."
---

Save clipboard images to /tmp with custom reference names and load them into context for further processing.

This command captures images from the clipboard, saves them with a meaningful reference name, and reads them to make them available for analysis or processing in the current conversation. Supports loading multiple images with descriptive names.

Steps:
1. Take the reference argument provided by the user
2. Save clipboard contents to `/tmp/clipboard_image_{reference}.png` using xclip
3. Read the saved image file to load it into context
4. Provide a brief description of what's in the image and show the saved filename

Usage:
- Syntax: `/load-img-in-context <reference>`
- Example: `/load-img-in-context page-1-mockup`
- Images are saved as `/tmp/clipboard_image_{reference}.png`
- You can then ask questions about any or all of the loaded images by their reference names
- Use meaningful reference names to easily identify images later

Flow example:
1. Copy 1st image → `/load-img-in-context homepage-design` → saved as clipboard_image_homepage-design.png
2. Copy 2nd image → `/load-img-in-context login-page` → saved as clipboard_image_login-page.png
3. Copy 3rd image → `/load-img-in-context dashboard-mockup` → saved as clipboard_image_dashboard-mockup.png
4. Ask: "Compare the homepage-design and dashboard-mockup" or "What's the color scheme in the login-page?"

Arguments:
- `<reference>`: A descriptive name for the image (required). Will be used in the filename as clipboard_image_{reference}.png

The images persist in /tmp until system reboot, allowing you to reference them by name throughout your session.
