#!/usr/bin/env bash
# preview.sh — Generate a visual preview of the wofi theme
# Requires: imagemagick, wofi (for screenshot), or use browser-based rendering

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT="${SCRIPT_DIR}/preview.png"

echo "🎨 Generating preview..."

# Option 1: Use wofi with a fake display (headless)
# This requires Xvfb or similar - complex for CI

# Option 2: Render with HTML/CSS (simpler, shows the design)
cat > "${SCRIPT_DIR}/preview.html" << 'HTMLEOF'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>wofi-glassmorphism Preview</title>
<style>
/* Exact copy of style.css variables for accurate preview */
:root {
  --glass-bg: rgba(15, 15, 20, 0.72);
  --glass-border: rgba(255, 255, 255, 0.12);
  --glass-highlight: rgba(255, 255, 255, 0.06);
  --glass-shadow: rgba(0, 0, 0, 0.45);
  --accent: #89b4fa;
  --accent-hover: #74c7ec;
  --accent-dim: rgba(137, 180, 250, 0.18);
  --text-primary: rgba(255, 255, 255, 0.92);
  --text-secondary: rgba(255, 255, 255, 0.6);
  --text-muted: rgba(255, 255, 255, 0.35);
  --text-on-accent: #1e1e2e;
  --radius-lg: 16px;
  --radius-md: 10px;
  --radius-sm: 8px;
  --spacing: 4px;
  --item-padding: 12px 16px;
  --input-padding: 12px 16px;
}

* { box-sizing: border-box; margin: 0; padding: 0; }

body {
  min-height: 100vh;
  background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 40px;
  font-family: "JetBrains Mono", "Fira Code", "Noto Sans", monospace;
}

.preview-wrapper {
  position: relative;
  width: 100%;
  max-width: 640px;
}

/* Simulated compositor blur backdrop */
.blur-backdrop {
  position: absolute;
  inset: -20px;
  background: inherit;
  filter: blur(40px) brightness(0.6);
  border-radius: calc(var(--radius-lg) + 20px);
  z-index: -1;
  opacity: 0.6;
}

.window {
  background-color: var(--glass-bg);
  border-radius: var(--radius-lg);
  border: 1px solid var(--glass-border);
  box-shadow:
    0 0 0 1px var(--glass-border),
    0 8px 32px var(--glass-shadow),
    inset 0 1px 0 var(--glass-highlight);
  overflow: hidden;
  backdrop-filter: blur(20px) saturate(1.2);
  -webkit-backdrop-filter: blur(20px) saturate(1.2);
}

.input-row {
  padding: 12px 16px;
  border-bottom: 1px solid var(--glass-border);
  background: linear-gradient(180deg, rgba(255,255,255,0.04) 0%, transparent 100%);
}

#input {
  display: flex;
  align-items: center;
  gap: 10px;
  background-color: rgba(0, 0, 0, 0.35);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: var(--radius-md);
  padding: var(--input-padding);
  color: var(--text-primary);
  font-family: inherit;
  font-size: 11pt;
  font-weight: 500;
  width: 100%;
  outline: none;
  transition: border-color 150ms ease, box-shadow 150ms ease;
}

#input:focus {
  border-color: var(--accent);
  box-shadow: 0 0 0 2px var(--accent-dim), inset 0 2px 8px rgba(0,0,0,0.3);
}

#prompt {
  color: var(--text-secondary);
  font-weight: 600;
  user-select: none;
}

.entries {
  max-height: 360px;
  overflow-y: auto;
  padding: 8px;
}

.entry {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: var(--item-padding);
  border-radius: var(--radius-md);
  cursor: pointer;
  transition: background-color 120ms ease, color 120ms ease, transform 80ms ease, box-shadow 120ms ease;
  animation: fade-slide-in 120ms ease-out backwards;
}

.entry:nth-child(1) { animation-delay: 0ms; }
.entry:nth-child(2) { animation-delay: 20ms; }
.entry:nth-child(3) { animation-delay: 40ms; }
.entry:nth-child(4) { animation-delay: 60ms; }
.entry:nth-child(5) { animation-delay: 80ms; }
.entry:nth-child(6) { animation-delay: 100ms; }

@keyframes fade-slide-in {
  from { opacity: 0; transform: translateY(4px); }
  to { opacity: 1; transform: translateY(0); }
}

.entry:hover {
  background-color: rgba(255, 255, 255, 0.08);
}

.entry.selected {
  background-color: var(--accent-dim);
  box-shadow: inset 0 0 0 1px rgba(137, 180, 250, 0.3), 0 2px 12px rgba(137, 180, 250, 0.15);
}

.entry.selected .icon {
  filter: drop-shadow(0 1px 2px rgba(0,0,0,0.3)) drop-shadow(0 0 8px var(--accent));
}

.icon {
  width: 24px;
  height: 24px;
  flex-shrink: 0;
  filter: drop-shadow(0 1px 2px rgba(0, 0, 0, 0.3));
}

.text-column {
  display: flex;
  flex-direction: column;
  gap: 2px;
  min-width: 0;
}

.name {
  font-weight: 600;
  font-size: 11pt;
  color: var(--text-primary);
  letter-spacing: -0.01em;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.description {
  font-weight: 400;
  font-size: 10pt;
  color: var(--text-secondary);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.scrollbar-hint {
  padding: 8px 16px;
  text-align: center;
  color: var(--text-muted);
  font-size: 9pt;
  border-top: 1px solid var(--glass-border);
}

.accent-badge {
  display: inline-block;
  padding: 2px 8px;
  background: var(--accent-dim);
  border: 1px solid rgba(137, 180, 250, 0.3);
  border-radius: 4px;
  font-size: 8pt;
  color: var(--accent);
  font-weight: 600;
  margin-left: 8px;
}

.header {
  text-align: center;
  margin-bottom: 24px;
  color: var(--text-primary);
}

.header h1 {
  font-size: 1.5rem;
  font-weight: 700;
  letter-spacing: -0.02em;
  background: linear-gradient(135deg, var(--text-primary) 0%, var(--accent) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.header p {
  color: var(--text-secondary);
  margin-top: 4px;
}
</style>
</head>
<body>
<div class="preview-wrapper">
  <div class="blur-backdrop"></div>
  <div class="window">
    <div class="input-row">
      <div id="input">
        <span id="prompt">⌘</span>
        <input type="text" placeholder="Search applications..." style="border: none; background: transparent; color: inherit; font: inherit; width: 100%; outline: none;" value="term">
      </div>
    </div>
    <div class="entries">
      <div class="entry selected">
        <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <rect x="3" y="3" width="18" height="18" rx="2"/>
          <path d="M9 9h6v6H9z"/>
        </svg>
        <div class="text-column">
          <span class="name">Alacritty</span>
          <span class="description">Terminal emulator</span>
        </div>
      </div>
      <div class="entry">
        <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <polyline points="16 18 22 12 16 6"/>
          <polyline points="8 6 2 12 8 18"/>
        </svg>
        <div class="text-column">
          <span class="name">Neovim</span>
          <span class="description">Text editor</span>
        </div>
      </div>
      <div class="entry">
        <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <rect x="2" y="3" width="20" height="14" rx="2"/>
          <path d="M8 21h8"/>
          <path d="M12 17v4"/>
        </svg>
        <div class="text-column">
          <span class="name">Firefox</span>
          <span class="description">Web browser</span>
        </div>
      </div>
      <div class="entry">
        <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"/>
        </svg>
        <div class="text-column">
          <span class="name">Thunar</span>
          <span class="description">File manager</span>
        </div>
      </div>
      <div class="entry">
        <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <circle cx="12" cy="12" r="10"/>
          <path d="M12 6v6l4 2"/>
        </svg>
        <div class="text-column">
          <span class="name">Clock</span>
          <span class="description">System clock</span>
        </div>
      </div>
      <div class="entry">
        <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <circle cx="12" cy="12" r="3"/>
          <path d="M12 1v2M12 21v2M4.22 4.22l1.42 1.42M18.36 18.36l1.42 1.42M1 12h2M21 12h2M4.22 19.78l1.42-1.42M18.36 5.64l1.42-1.42"/>
        </svg>
        <div class="text-column">
          <span class="name">Settings</span>
          <span class="description">System settings</span>
        </div>
      </div>
    </div>
    <div class="scrollbar-hint">
      <span class="accent-badge">Catppuccin Mocha</span>
      Press ↑↓ to navigate · Enter to launch · Esc to close
    </div>
  </div>
</div>
<div class="header">
  <h1>wofi-glassmorphism</h1>
  <p>Premium glass morphic launcher theme for Wayland</p>
</div>
</body>
</html>
HTMLEOF

# Try to render with chromium/puppeteer if available
if command -v chromium >/dev/null 2>&1; then
  chromium --headless --disable-gpu --screenshot="$OUTPUT" --window-size=800,900 "${SCRIPT_DIR}/preview.html" 2>/dev/null
  echo "✅ Preview saved to $OUTPUT"
elif command -v google-chrome >/dev/null 2>&1; then
  google-chrome --headless --disable-gpu --screenshot="$OUTPUT" --window-size=800,900 "${SCRIPT_DIR}/preview.html" 2>/dev/null
  echo "✅ Preview saved to $OUTPUT"
else
  echo "ℹ️  No headless browser found. Open preview.html manually:"
  echo "   file://${SCRIPT_DIR}/preview.html"
  echo "   Then screenshot it for the README."
fi