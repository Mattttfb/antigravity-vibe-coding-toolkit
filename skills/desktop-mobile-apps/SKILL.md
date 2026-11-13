---
name: desktop-mobile-apps
description: >-
  Workflows, scaffolding, and architectures for building native and cross-platform desktop applications (Tauri, Electron)
  and mobile applications (Android Native, Jetpack Compose, React Native) utilizing the system's Rust (cargo), Node, and Android toolchains.
---

# Desktop & Mobile App Development

This skill guides the creation of desktop applications for Windows/Mac/Linux and mobile apps for Android.

---

## 1. Desktop Development with Tauri (Rust + Web)

Tauri produces extremely lightweight (a few megabytes), blazing-fast native binaries using Rust as the backend and any web frontend (React/Vite).

- **Prerequisites Available**:
  - `cargo` (Rust 1.99+)
  - `node` & `pnpm`
- **Bootstrapping a Tauri App**:
  ```bash
  pnpm create tauri-app my-desktop-app --template react-ts
  cd my-desktop-app
  pnpm install
  pnpm tauri dev
  ```
- **IPC (Inter-Process Communication)**:
  - Rust command (`src-tauri/src/main.rs`):
    ```rust
    #[tauri::command]
    fn greet(name: &str) -> String {
        format!("Hello, {}! You've been greeted from Rust!", name)
    }
    ```
  - Frontend call:
    ```typescript
    import { invoke } from "@tauri-apps/api/core";
    const message = await invoke("greet", { name: "User" });
    ```

---

## 2. Desktop with Electron

- When Node.js direct filesystem access without Rust is preferred:
  ```bash
  npx create-electron-app my-electron-app --template=vite-typescript
  ```

---

## 3. Mobile Development (Android & Jetpack Compose)

- Use the integrated `android-cli` plugin and sidecars:
  - List devices/emulators: `android devices`
  - Render Compose preview: `android preview render`
  - UI inspection: `android layout`, `android screen`
  - Sidecar device hub: mirror and control devices with touch/mouse wheel.
