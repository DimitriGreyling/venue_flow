# Design System Specification: The Architectural Flow

## 1. Overview & Creative North Star
**Creative North Star: "The Orchestrated Atmosphere"**

In venue management, the magic happens when complex logistics feel effortless to the guest. This design system moves away from the "data-entry" aesthetic of traditional B2B SaaS. Instead, it adopts an **Editorial High-End** approach. We treat every dashboard like a curated floor plan and every data point like a VIP invitation.

To break the "template" look, we utilize **Intentional Asymmetry** and **Tonal Depth**. By avoiding rigid, boxy grids and instead using layered surfaces and expansive whitespace, we create a sense of "Air"—giving the user the mental room to manage high-pressure events with calm authority.

---

## 2. Colors: Tonal Architecture
The palette is built on a foundation of "Atmospheric Blues" and "Architectural Greens." We do not use color just to decorate; we use it to define space.

### The "No-Line" Rule
**Borders are prohibited for sectioning.** To separate a sidebar from a main content area, do not draw a 1px line. Instead, use a background shift:
* **Main Canvas:** `surface` (#f8f9ff)
* **Sidebar/Navigation:** `surface-container-low` (#eff4ff)
* **Active Interaction Areas:** `surface-container-high` (#dce9ff)

### Surface Hierarchy & Nesting
Treat the UI as a physical stack of materials.
1. **Base Layer:** `background` (#f8f9ff) - The floor of the application.
2. **Mid Layer:** `surface-container` (#e5eeff) - Grouping related content blocks.
3. **Top Layer:** `surface-container-lowest` (#ffffff) - High-priority cards that should "pop" against the tinted background.

### The "Glass & Gradient" Rule
For primary actions and high-level summaries, use **Signature Textures**.
* **Primary CTAs:** Apply a subtle linear gradient from `primary_container` (#004a31) to `primary` (#00311f) at a 135-degree angle. This adds "soul" and weight to the emerald accent.
* **Floating Modals:** Use `surface_container_lowest` with a 85% opacity and a `24px` backdrop-blur to create a "frosted glass" effect, ensuring the venue data beneath stays visible but non-distracting.

---

## 3. Typography: Editorial Authority
We utilize two distinct typefaces to balance character with utility.

* **Display & Headlines (Manrope):** Chosen for its geometric precision and modern "tech-boutique" feel. Use `display-lg` to `headline-sm` for page titles and key metrics. This is your "Editorial" voice.
* **Body & Labels (Inter):** Chosen for its unparalleled legibility in data-heavy views. Use `body-md` for general content and `label-sm` for micro-data.

**Hierarchy Strategy:**
Use `on_surface_variant` (#444651) for secondary labels to create a soft contrast against the high-contrast `on_surface` (#0b1c30) headlines. This "muted-to-bold" transition guides the eye naturally through complex booking forms.

---

## 4. Elevation & Depth: Tonal Layering
We reject the standard "Drop Shadow" approach. Depth is a result of light and material, not black ink.

* **The Layering Principle:** A card should never have a border. If you place a `surface-container-lowest` (#ffffff) card on a `surface-container-low` (#eff4ff) background, the 2% shift in brightness is enough to define the boundary.
* **Ambient Shadows:** If an element must float (like a dropdown or a "New Event" FAB), use a shadow color tinted with the brand: `rgba(11, 28, 48, 0.06)` (a deep blue tint) with a `32px` blur and `8px` Y-offset.
* **The "Ghost Border" Fallback:** In extreme high-density data tables where separation is mandatory, use a "Ghost Border": `outline-variant` (#c5c5d3) at 15% opacity.

---

## 5. Components

### Buttons & Chips
* **Primary Button:** Gradient fill (`primary_container` to `primary`), `8px` (DEFAULT) corner radius. Use `on_primary` (#ffffff) text.
* **Action Chips:** Use `secondary_container` (#8fa7fe) with `on_secondary_container` (#1d3989) text. Shape should be `full` (pill-shaped) to contrast against the architectural squareness of the cards.

### Input Fields
* **Style:** Minimalist. No background fill; only a `surface-variant` bottom-stroke or a `Ghost Border`.
* **Focus State:** Transition the border to `secondary` (#4059aa) and add a soft `secondary_fixed` glow (4px spread).

### Cards & Lists
* **The Divider Ban:** Never use horizontal lines to separate list items. Use vertical padding (`16px` from the spacing scale) and a subtle hover state change to `surface_container_low`.
* **Venue Cards:** Use `xl` (1.5rem) corner radius for image containers within cards to give them a premium, mobile-app-like feel.

### Specialized Venue Components
* **Occupancy Gauges:** Use a thick `primary_fixed` track with a `primary` indicator.
* **Timeline Scrubber:** A semi-transparent `glass` overlay that moves across the event schedule, blurring the "past" and highlighting the "present."

---

## 6. Do's and Don'ts

### Do:
* **Do** use `surface_container_highest` (#d3e4fe) for "Destructive" or "Alert" background areas to keep the palette harmonious even in error states.
* **Do** embrace extreme whitespace. If you think there is enough margin, add 8px more.
* **Do** use `manrope` for numbers. Its geometric nature makes revenue and occupancy figures look "designed."

### Don't:
* **Don't** use pure black (#000000). Always use `on_surface` (#0b1c30) for text to maintain the deep-blue professional tone.
* **Don't** use 1px solid borders to define the layout. Let the background colors do the heavy lifting.
* **Don't** use "Alert Red" for everything. Use the `tertiary` (#4b1c00) tones for warnings that require attention but aren't system-critical, reserving `error` (#ba1a1a) for data loss.