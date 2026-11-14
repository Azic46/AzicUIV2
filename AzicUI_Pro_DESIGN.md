# Azic UI Pro — design system

## Direction
A restrained dark interface with dimensional depth: layered surfaces, subtle gradients, a single live accent, crisp type and motion that never gets in the way. The design is intentionally serious rather than neon-heavy.

## Tokens
- Background: `#0D0D13`
- Panel: `#14141D`
- Element: `#1D1D2A`
- Primary text: `#ECECF5`
- Secondary text: `#94A3B8`
- Outline: `#2E2E42`
- Accent: `#8B5CFF`
- Risk: `#FF555F`

## Depth and motion
- Use layered panels and gradient highlights to suggest depth without excessive blur.
- Keep one accent color, switchable through `Library:SetAccent(Color3)`.
- Enter transitions are soft and quick; exit transitions are faster.
- Respect `Library.ReducedMotion` and `Library.AmbientEffects`.
- Press feedback must not change layout bounds.

## Icon system
- `Library.IconNames` contains 619 semantic icon keys.
- Register an image for a key with `Library:RegisterIcon("home", "rbxassetid://...")`.
- Pass a registered key or direct image ID to `Window:AddTab("Home", "home")`.
- Icon images are not bundled: creators provide asset IDs they have permission to use.
- Until a key is registered, a small letter tile is shown rather than a missing-image placeholder.

## Interaction
- Floating open/close button remains visible when the main window is hidden.
- Top-right close control and `RightShift` toggle remain supported.
- Touch controls use larger hit targets.
