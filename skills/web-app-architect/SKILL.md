---
name: web-app-architect
description: >-
  Expert guidelines and workflows for creating, architecting, and deploying modern websites and web applications.
  Covers React, Next.js, Vite, TypeScript, Tailwind CSS, Lucide Icons, Shadcn UI, state management, routing, and deployment.
---

# Web App Architect & Modern Frontend Development

This skill provides step-by-step guidance and architectural blueprints for developing web applications, single-page apps (SPAs), dynamic websites, landing pages, and web dashboards.

---

## 1. Stack & Tooling Selection

- **Vite + React + TypeScript**:
  - Best for: Fast client-side SPAs, interactive dashboards, internal tools, portfolio sites.
  - Quick setup:
    ```bash
    pnpm create vite my-app --template react-ts
    cd my-app
    pnpm install
    pnpm add -D tailwindcss postcss autoprefixer
    pnpm dlx tailwindcss init -p
    pnpm add lucide-react clsx tailwind-merge
    ```
- **Next.js (App Router)**:
  - Best for: Fullstack web apps, SEO-critical sites, e-commerce, server-side rendered (SSR) apps.
  - Quick setup:
    ```bash
    npx create-next-app@latest my-app --typescript --tailwind --eslint --app --src-dir --import-alias "@/*"
    ```
- **Static Preview & Testing**:
  - Serve static HTML or built apps locally:
    ```bash
    serve dist -l 3000
    ```

---

## 2. Component Architecture & UI Standards

1. **Atomic & Composable Structure**:
   - `components/ui/`: Base primitives (Button, Input, Card, Modal, Dropdown).
   - `components/features/`: Domain-specific components (UserProfile, CheckoutForm, DashboardGrid).
   - `layouts/`: Header, Navigation, Footer, Sidebar, Shell.
   - `hooks/`: Reusable custom React hooks (`useDebounce`, `useLocalStorage`, `useFetch`).
   - `lib/`: Utilities (`utils.ts`, `cn` helper for Tailwind class merging).

2. **Tailwind Class Merging Utility (`lib/utils.ts`)**:
   ```typescript
   import { clsx, type ClassValue } from "clsx";
   import { twMerge } from "tailwind-merge";

   export function cn(...inputs: ClassValue[]) {
     return twMerge(clsx(inputs));
   }
   ```

3. **Accessibility & Responsive Standards**:
   - Mobile-first breakpoints: `sm:` (640px), `md:` (768px), `lg:` (1024px), `xl:` (1280px).
   - High-contrast color tokens and keyboard navigation focus rings (`focus-visible:ring-2`).
   - Support dark mode using CSS variables or `class="dark"` with Tailwind `dark:`.

---

## 3. UI Component Registries: Shadcn UI, Magic UI & 21st.dev

We leverage the open-source Shadcn registry architecture to pull production-ready UI blocks and micro-animations with a single command:

1. **Base Shadcn UI Initialization**:
   ```bash
   pnpm dlx shadcn@latest init
   pnpm dlx shadcn@latest add button card dialog dropdown-menu input table tabs avatar
   ```

2. **Magic UI (Animated Hero Blocks & Micro-Interactions)**:
   - We have the `frontend-craft-magicui` MCP server connected to search and inspect items (`bento-grid`, `marquee`, `animated-beam`, `border-beam`, `particles`, `dock`, `number-ticker`).
   - Direct installation into project:
     ```bash
     pnpm dlx shadcn@latest add "https://magicui.design/r/bento-grid"
     pnpm dlx shadcn@latest add "https://magicui.design/r/marquee"
     pnpm dlx shadcn@latest add "https://magicui.design/r/border-beam"
     ```

3. **21st.dev (The Community Component Registry)**:
   - The largest open-source catalog of custom components created by design engineers worldwide.
   - Install any component directly from 21st.dev using its registry URL:
     ```bash
     pnpm dlx shadcn@latest add "https://21st.dev/r/<author>/<component-name>"
     ```

4. **Aceternity UI & High-Impact Visual Effects (Vibe Coding)**:
   - For viral, high-converting SaaS landing pages and hero sections.
   - Core motion dependencies:
     ```bash
     pnpm add framer-motion clsx tailwind-merge canvas-confetti
     pnpm add -D @types/canvas-confetti
     ```
   - Standard components: Spotlight background, 3D Pin Card, Background Beams, Aurora Background, Floating Dock.

5. **Instant Mock & Seed Data Workflow**:
   - Never build a UI with empty states or "Lorem Ipsum".
   - Generate realistic Brazilian/global datasets instantly with the dev-toolkit:
     ```bash
     python "C:/Users/User/.gemini/config/scripts/dev-toolkit/seed_data.py" users 20 --out src/data/users.json
     python "C:/Users/User/.gemini/config/scripts/dev-toolkit/seed_data.py" metrics 30 --out src/data/metrics.json
     python "C:/Users/User/.gemini/config/scripts/dev-toolkit/seed_data.py" products 15 --out src/data/products.json
     ```

6. **Awesome-Shadcn-UI Ecosystem**:
   - Reference curated patterns for full-page dashboards, authentication shells, settings layouts, and e-commerce carts without rebuilding foundations from scratch.

---

## 4. Production Readiness & Verification

- Before declaring a web project complete:
  1. Verify zero TypeScript errors (`pnpm tsc --noEmit` or `npm run build`).
  2. Test local dev server responsiveness (`pnpm dev` or `npm run dev`).
  3. Validate fallback states: Loading spinners/skeletons, Empty states, Error boundaries.
