---
name: Kinetic Infrastructure
colors:
  surface: '#f8f9fa'
  surface-dim: '#d9dadb'
  surface-bright: '#f8f9fa'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f3f4f5'
  surface-container: '#edeeef'
  surface-container-high: '#e7e8e9'
  surface-container-highest: '#e1e3e4'
  on-surface: '#191c1d'
  on-surface-variant: '#464555'
  inverse-surface: '#2e3132'
  inverse-on-surface: '#f0f1f2'
  outline: '#777587'
  outline-variant: '#c7c4d8'
  surface-tint: '#4d44e3'
  primary: '#3525cd'
  on-primary: '#ffffff'
  primary-container: '#4f46e5'
  on-primary-container: '#dad7ff'
  inverse-primary: '#c3c0ff'
  secondary: '#4442e3'
  on-secondary: '#ffffff'
  secondary-container: '#5f5ffd'
  on-secondary-container: '#fffbff'
  tertiary: '#7e3000'
  on-tertiary: '#ffffff'
  tertiary-container: '#a44100'
  on-tertiary-container: '#ffd2be'
  error: '#EF4444'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e2dfff'
  primary-fixed-dim: '#c3c0ff'
  on-primary-fixed: '#0f0069'
  on-primary-fixed-variant: '#3323cc'
  secondary-fixed: '#e1dfff'
  secondary-fixed-dim: '#c1c1ff'
  on-secondary-fixed: '#09006b'
  on-secondary-fixed-variant: '#2c24ce'
  tertiary-fixed: '#ffdbcc'
  tertiary-fixed-dim: '#ffb695'
  on-tertiary-fixed: '#351000'
  on-tertiary-fixed-variant: '#7b2f00'
  background: '#f8f9fa'
  on-background: '#191c1d'
  surface-variant: '#e1e3e4'
  text-main: '#111827'
  text-muted: '#6B7280'
  success: '#10B981'
  warning: '#F59E0B'
  info: '#3B82F6'
  border-subtle: '#E5E7EB'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  body-sm:
    fontFamily: Inter
    fontSize: 13px
    fontWeight: '400'
    lineHeight: 18px
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
  label-sm:
    fontFamily: Inter
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 14px
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 4px
  gutter: 24px
  margin-mobile: 16px
  margin-desktop: 32px
  container-max-width: 1440px
---

## Brand & Style

This design system is engineered for high-density Venue Management, balancing the information density of enterprise software with the aesthetic clarity of modern SaaS. The brand personality is professional, reliable, and efficient, designed to instill confidence in venue operators managing complex logistics.

The visual style is **Corporate / Modern**, heavily influenced by the precision of Stripe’s interface and the functional vibrancy of Monday.com. It utilizes a "Utility-First" aesthetic: every visual element serves a functional purpose. The interface uses a clean, light-mode-first approach with expansive whitespace, thin borders, and a systematic application of color to denote status and priority. The goal is to reduce cognitive load while providing all necessary data at a glance.

## Colors

The palette is centered around a refined Indigo primary, which provides a trustworthy and systematic anchor for the UI. 

- **Primary & Secondary:** The Primary Indigo (#4F46E5) is reserved for high-priority actions, focus states, and primary navigation. The Secondary Blue (#6161FF) is used for decorative elements or secondary highlights.
- **Surface & Background:** A clear distinction is made between the page background (#F9FAFB) and surface elements (#FFFFFF) to create natural depth without heavy shadows.
- **Functional Colors:** Success, Warning, Error, and Info colors are strictly mapped to system statuses. These should be used with high-saturation backgrounds for badges or low-opacity tints for alert banners.
- **Typography:** Contrast is maintained through the use of Slate-based grays, ensuring readability while avoiding the harshness of pure black.

## Typography

This design system uses **Inter** exclusively to achieve a systematic, neutral, and highly legible interface. The hierarchy is established through weight and color rather than excessive size differences.

- **Scale:** A tight scale is used to accommodate high-density data views. `body-sm` (13px) is the workhorse for data tables and sidebars.
- **Labels:** Use `label-md` for section headers and table columns; the uppercase styling with increased letter spacing ensures they are distinct from interactive text.
- **Readability:** Line heights are kept tight (1.4x to 1.5x) to maintain the "airy but dense" feel required for dashboard environments.

## Layout & Spacing

The layout utilizes a **Fixed-Fluid Hybrid** model. The sidebar navigation is fixed, while the main content area utilizes a fluid 12-column grid that caps at a maximum width of 1440px to prevent excessive line lengths on ultra-wide monitors.

- **Rhythm:** A 4px baseline grid governs all spacing. Gutters between cards and primary layout sections are set to 24px.
- **Density:** For data-heavy views, vertical padding within table rows and list items is reduced to 8px or 12px, while high-level dashboard views use 24px-32px padding to provide "air."
- **Breakpoints:**
  - **Mobile (<768px):** Sidebar collapses into a hamburger menu. Margins reduce to 16px. Cards stack vertically.
  - **Tablet (768px - 1024px):** Sidebar collapses to an icon-only rail.
  - **Desktop (>1024px):** Full expanded sidebar (240px). 12-column grid active.

## Elevation & Depth

Depth is achieved through a combination of **Tonal Layers** and **Subtle Ambient Shadows**.

- **Level 0 (Background):** The base canvas uses #F9FAFB.
- **Level 1 (Cards/Surfaces):** White (#FFFFFF) surfaces with a 1px border (#E5E7EB). This is the standard for dashboard widgets and table containers.
- **Level 2 (Dropdowns/Modals):** Elements that sit above the UI use a soft, diffused shadow (0px 4px 6px -1px rgba(0,0,0,0.1)) to indicate interactivity and focus.
- **Interactions:** Buttons and interactive cards should not use heavy shadows. Instead, use subtle background color shifts (e.g., Gray-50 to Gray-100) and 1px inset borders on active states to mimic a tactile press.

## Shapes

The design system uses a **Rounded** (8px default) shape language. This softens the high-density professional environment, making the software feel modern and approachable.

- **Standard Elements:** Buttons, Input fields, and Cards use the 8px (0.5rem) base radius.
- **Large Elements:** Side drawers and large modals use 16px (1rem) for the outer corners to emphasize them as distinct containers.
- **Status Badges:** Use a fully rounded "pill" shape (9999px) to differentiate them from interactive buttons.

## Components

- **Sidebar Navigation:** Use a vertical layout with a 240px width. Active states should be indicated by a primary color vertical bar on the left and a subtle background tint (Primary-50).
- **KPI Cards:** Feature a large `headline-lg` value, a `label-sm` title, and a compact Sparkline (line chart) using the Primary or Status color to show 7-day trends.
- **Data Tables:** Use `body-sm` for content. Row height should be 48px. Status badges should use low-opacity backgrounds with high-opacity text (e.g., Success badge: 10% green background, 100% green text).
- **Multi-tenant Indicator:** A persistent "Venue Switcher" dropdown in the top-left or sidebar-top, featuring a small square avatar/icon for the venue and the venue name in `body-md` bold.
- **Side Drawers:** Used for quick edits of table rows. These should slide in from the right, covering 30-40% of the screen, with a backdrop blur on the main content.
- **Tabbed Interfaces:** Use underline-style tabs for detail views, where the active tab has a 2px primary color border and bold text.
- **Input Fields:** Use 1px borders (#E5E7EB) that transition to the primary color on focus. Labels should always be visible above the field using `label-sm`.