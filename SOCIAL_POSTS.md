# Social Media Posts for wofi-glassmorphism v1.0.0
# Repo: https://github.com/ziuus/wofi-glassmorphism

---

## 🐙 GitHub (Release Notes - already published)
✅ Done via `gh release create v1.0.0`

---

## 🤖 X / Twitter

### Option A - Visual focus (with screenshot)
Just pushed wofi-glassmorphism v1.0.0 — a premium glass morphic theme for @wofi_launcher on Wayland.

✨ True backdrop blur, layered shadows, micro-interactions
🎨 Themeable via CSS variables (Catppuccin, Rose Pine, Tokyo Night presets)
⚡ One-command installer with compositor auto-detection
♿ High contrast & reduced motion support

https://github.com/ziuus/wofi-glassmorphism

#Linux #Hyprland #Wayland #LinuxRicing #OpenSource

---

### Option B - Technical focus
Built a glass morphic wofi theme that actually respects your compositor.

Key details:
- Backdrop blur via compositor (Hyprland native, swayfx, KWin, picom)
- CSS custom properties for complete theming
- Staggered entry animations, hover/selection states
- Installer detects your compositor & guides setup
- CI tests on Arch container

https://github.com/ziuus/wofi-glassmorphism

#Linux #Wayland #Hyprland #Dotfiles #OpenSource

---

### Reply thread (post after main tweet)
**Install:**
```bash
git clone https://github.com/ziuus/wofi-glassmorphism
cd wofi-glassmorphism && ./install.sh
```

**Hyprland keybind:**
```
bindd = , SUPER, exec, wofi --show drun
```

**Customize colors** in `styles/style.css` — all in `:root`:
```css
--accent: #89b4fa;        /* Catppuccin blue */
--glass-bg: rgba(15,15,20,0.72);
--glass-border: rgba(255,255,255,0.12);
```

Presets included: Catppuccin, Rose Pine, Tokyo Night, Nord, Dracula, Gruvbox.

---

## 📱 Reddit

### r/unixporn (strongest fit)
**Title:** [OC] wofi-glassmorphism — glass morphic launcher theme with true backdrop blur

**Body:**
Been working on a proper glass morphic theme for wofi. Most "glass" themes just use semi-transparent backgrounds — this one actually leverages compositor backdrop blur for the real effect.

**Features:**
- True glass morphism via compositor blur (Hyprland, swayfx, KWin, picom)
- Layered shadows, highlight borders, inset glows
- Staggered entry animations + smooth hover/selection transitions
- Fully themeable via CSS variables — 6 accent presets included (Catppuccin, Rose Pine, Tokyo Night, Nord, Dracula, Gruvbox)
- Respects `prefers-contrast` and `prefers-reduced-motion`
- One-command installer with compositor detection
- CI-tested on Arch Linux

**Repo:** https://github.com/ziuus/wofi-glassmorphism

**Install:**
```bash
git clone https://github.com/ziuus/wofi-glassmorphism
cd wofi-glassmorphism && ./install.sh
```

**Hyprland config for blur:**
```conf
decoration {
    blur { enabled = true; size = 8; passes = 3; }
}
windowrulev2 = blur, class:^(wofi-launcher)$
```

Screenshot in the repo (preview.png). Happy to hear feedback!

---

### r/hyprland
**Title:** wofi-glassmorphism v1.0.0 — glass morphic wofi theme with native Hyprland blur support

**Body:**
Released a wofi theme built specifically for Hyprland's native blur. No picom hacks needed.

**Why this over other themes:**
- Uses `windowrulev2 = blur, class:^(wofi-launcher)$` for native Hyprland blur
- CSS architecture with custom properties — change colors in one place
- Proper micro-interactions: staggered entry animations, selection glow, hover states
- Installer auto-detects Hyprland and shows the exact config you need
- Accessibility: high contrast mode, reduced motion support

**Quick setup:**
```bash
git clone https://github.com/ziuus/wofi-glassmorphism
cd wofi-glassmorphism && ./install.sh
# Add to hyprland.conf:
bindd = , SUPER, exec, wofi --show drun
```

Repo: https://github.com/ziuus/wofi-glassmorphism

---

### r/linux (open-source angle)
**Title:** wofi-glassmorphism — a compositor-aware glass morphic theme for wofi (Wayland)

**Body:**
Open-sourced a wofi theme that adapts to your compositor instead of fighting it.

**Technical approach:**
- Detects Hyprland/swayfx/KWin/picom at install time
- Uses compositor-native blur APIs (no screenshot hacks)
- CSS custom properties for maintainable theming
- GitHub Actions CI runs install test in fresh Arch container
- MIT licensed

**Presets included:** Catppuccin Mocha, Rose Pine, Tokyo Night, Nord, Dracula, Gruvbox

https://github.com/ziuus/wofi-glassmorphism

---

### r/archlinux (only if genuinely Arch-relevant)
**Title:** wofi-glassmorphism — glass morphic wofi theme with Arch-tested installer

**Body:**
Built a wofi theme with an installer that's CI-tested on Arch Linux.

The install script:
- Detects your compositor (Hyprland, sway, picom, etc.)
- Backs up existing configs
- Links the theme and adds the CSS file reference
- Prints the exact keybind for your WM

Tested in GitHub Actions on `archlinux:latest` container.

https://github.com/ziuus/wofi-glassmorphism

---

## 💼 LinkedIn

**Post:**
Open-sourced a project this week: **wofi-glassmorphism** — a premium glass morphic theme for the wofi Wayland launcher.

**Why it matters technically:**
- **Compositor-aware design**: Instead of fake transparency, it leverages native backdrop blur APIs (Hyprland, swayfx, KWin, picom). The installer detects your environment and guides configuration.
- **Maintainable CSS architecture**: All visual tokens live in CSS custom properties (`:root`). Swapping color schemes (Catppuccin, Tokyo Night, etc.) is a one-line change.
- **Accessibility built-in**: Respects `prefers-reduced-motion` and `prefers-contrast` media queries — no extra work for users who need them.
- **CI/CD discipline**: GitHub Actions validates config syntax, CSS structure, and runs a full install test in a clean Arch Linux container on every push.

**The stack**: Pure CSS + bash installer + wofi (GTK3/Wayland). No JS frameworks, no build step.

**Repo**: https://github.com/ziuus/wofi-glassmorphism

#Linux #Wayland #OpenSource #Dotfiles #SystemsEngineering

---

## 💬 Discord (Hyprland/Linux ricing servers)
**Message:**
Just released wofi-glassmorphism v1.0.0 — glass morphic wofi theme with native compositor blur support.

Repo: https://github.com/ziuus/wofi-glassmorphism

Highlights:
- Native Hyprland blur via `windowrulev2` (no picom needed)
- 6 accent presets (Catppuccin, Rose Pine, Tokyo Night, Nord, Dracula, Gruvbox)
- CSS variables for easy theming
- Installer auto-detects compositor
- Staggered animations, selection glow, reduced motion support
- MIT licensed

Preview: https://github.com/ziuus/wofi-glassmorphism/blob/master/preview.png

---

## 🦞 Lobsters
**Title:** wofi-glassmorphism: a compositor-aware glass morphic theme for wofi

**Body:**
https://github.com/ziuus/wofi-glassmorphism

Technical notes:
- Uses compositor-native backdrop blur (Hyprland, swayfx, KWin, picom dual_kawase) instead of screenshot-based fake blur
- CSS custom properties architecture — all design tokens in `:root`, enabling 6 included color presets
- Installer detects compositor at runtime and outputs exact configuration snippets
- GitHub Actions CI runs full install test in fresh `archlinux:latest` container
- Accessibility: `prefers-reduced-motion` and `prefers-contrast` media queries respected
- MIT licensed

Not just a rice screenshot — the installer, CI, and CSS architecture are the interesting parts.

---

## 📰 Hacker News
**Only if you have a stronger technical story.** Current state: "here's my wofi theme" — unlikely to gain traction.

**Potential angle for HN:** "How I built a compositor-aware theming system for Wayland launchers using only CSS custom properties and bash" — but you'd need a technical blog post to go with it.

---

## ✅ Checklist
- [x] GitHub topics added
- [x] GitHub release published
- [ ] X/Twitter post
- [ ] Reddit r/unixporn
- [ ] Reddit r/hyprland
- [ ] Reddit r/linux
- [ ] Reddit r/archlinux
- [ ] LinkedIn post
- [ ] Discord communities
- [ ] Lobsters submission