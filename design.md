# Design System Document: The Editorial Concierge



This design system is crafted for a premium Wedding Venue Management System, where the user experience must mirror the high-touch, white-glove service of the industry itself. We are moving away from the "software" look and toward a "digital atelier" aesthetic.



## 1. Overview & Creative North Star: "The Digital Curator"

The Creative North Star for this system is **The Digital Curator**. Unlike standard management tools that feel like spreadsheets, this system should feel like a high-end wedding planner’s physical portfolio.



To achieve this, we break the "template" look through:

* **Intentional Asymmetry:** Using the `Spacing Scale` (specifically shifts between `16` and `20`) to create offset layouts that feel editorial rather than industrial.

* **Tonal Breathability:** Utilizing the `surface` and `ivory` tones to create expansive whitespace, ensuring the interface never feels "busy" despite the complexity of venue logistics.

* **Layered Sophistication:** Overlapping image containers with text blocks to create a sense of depth and curated intent.



## 2. Colors

Our palette balances the warmth of `champagne` and `ivory` with the authoritative weight of `deep slate`.



* **Primary (`#446464`):** Our "Deep Slate" anchor. Used for primary actions and deep navigation elements to provide a sense of grounded professionalism.

* **Secondary (`#685d4a`):** A muted, sophisticated earth tone that bridges the gap between slate and champagne.

* **Tertiary (`#735c00`):** The "Gold" accent. Reserved for high-importance highlights, "Booked" statuses, or premium milestones.

* **Surface & Neutrals:** We rely on `surface-container-lowest` (#ffffff) to `surface-dim` (#dbdbcd) to build our hierarchy.



### The "No-Line" Rule

**Explicit Instruction:** Do not use 1px solid borders to section content. Boundaries must be defined solely through background color shifts. For example, a sidebar in `surface-container-low` should sit against a main content area of `surface`. If you feel the need for a line, use whitespace (`spacing-8` or higher) instead.



### Surface Hierarchy & Nesting

Treat the UI as a series of physical layers—like stacked sheets of fine vellum paper.

* **Base:** `surface` (#fafaeb).

* **Sectioning:** `surface-container-low` (#f4f5e6).

* **Interactive Cards:** `surface-container-lowest` (#ffffff).

This nesting creates a soft, "pillowy" depth that feels expensive and intentional.



### Signature Textures

Use a subtle linear gradient for hero areas or primary CTAs:

* `linear-gradient(135deg, primary (#446464) 0%, primary-container (#cdf0ef) 100%)` at low opacity. This adds a "silk sheen" effect that flat color cannot replicate.



## 3. Typography

We utilize a high-contrast pairing to evoke the feeling of a luxury wedding invitation.



* **Display & Headlines (Noto Serif):** These are our "Editorial Voice." Use `display-lg` for dashboard welcomes and venue names. The serif evokes tradition, elegance, and timelessness.

* **Body & Labels (Manrope):** Our "Functional Voice." Manrope provides a clean, modern counterpoint to the serif. It ensures high legibility for contract details, guest counts, and scheduling data.

* **Scale Usage:** Always use `label-md` or `label-sm` for metadata, ensuring they are in `on-surface-variant` to keep the visual hierarchy focused on the `headline` elements.



## 4. Elevation & Depth

In this design system, shadows are light, and borders are invisible.



* **The Layering Principle:** Depth is achieved by stacking. Place a `surface-container-lowest` card on a `surface-container-high` background. This creates a natural "lift."

* **Ambient Shadows:** For floating elements (like modals or dropdowns), use a 32px blur with 4% opacity, tinted with the `primary` color: `box-shadow: 0 10px 32px rgba(68, 100, 100, 0.04)`. This mimics natural light through a window.

* **The "Ghost Border" Fallback:** If a divider is functionally required, use the `outline-variant` token at **15% opacity**. It should be felt, not seen.

* **Glassmorphism:** For top navigation bars or floating action buttons, use `surface` at 80% opacity with a `backdrop-blur(12px)`. This keeps the venue's imagery (the "romance") visible even as the user navigates the "logistics."



## 5. Components



### Buttons

* **Primary:** Solid `primary` with `on-primary` text. Corners use `rounded-md` (0.375rem).

* **Secondary:** `surface-container-highest` background with `primary` text. No border.

* **Tertiary:** Text-only in `primary`, using `title-sm` typography with an underline on hover only.



### Cards & Lists

* **Rule:** Forbid the use of divider lines between list items. Use `spacing-4` (1.4rem) of vertical whitespace to separate items.

* **Interaction:** On hover, a card should shift from `surface-container-low` to `surface-container-lowest`.



### Input Fields

* **Aesthetic:** Fields should use `surface-container-low` as a background with a bottom-only "Ghost Border" (10% opacity `outline`). This mimics the look of a high-end paper form.

* **Focus:** Transition the bottom border to 100% opacity `primary`.



### Specialized Components

* **Availability Calendar:** Use `tertiary-container` (#ffe7a8) for "Hold" dates and `secondary` (#685d4a) for "Booked" dates. The contrast between the warm gold and slate provides an immediate status read.

* **Venue Status Chip:** Use `rounded-full` for chips, using `secondary-container` for a soft, pillowy look that doesn't feel like a harsh "alert."



## 6. Do's and Don'ts



### Do:

* **Do** use asymmetrical margins (e.g., 8.5rem on the left, 5.5rem on the right) for hero sections to create an editorial feel.

* **Do** prioritize `notoSerif` for any text that is meant to be read as a "statement."

* **Do** use the `surface-tint` to subtly colorize backgrounds of empty states.



### Don't:

* **Don't** use 100% black (#000000) for text. Always use `on-surface` (#1b1c14) or `on-surface-variant` (#4b463d) to maintain the soft, champagne-toned aesthetic.

* **Don't** use `rounded-none`. Everything in the wedding industry has a soft edge; stick to `rounded-md` or `rounded-lg`.

* **Don't** crowd the interface. If a screen feels full, increase the container size rather than shrinking the typography.