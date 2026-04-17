---
trigger: always_on
---

# FitFlow / GymOS — Production Rules & Architecture Standard
**Version:** 1.0  
**Status:** Production-ready master document  
**Purpose:** This document merges the product requirements and Flutter architecture rules into a single implementation standard for the FitFlow / GymOS project. It is the single source of truth for design, structure, performance, and development behavior.

---

## 1) Product Vision

FitFlow / GymOS is a premium gym ecosystem that digitizes the full fitness lifecycle:

- **User**: personal fitness journey tracking
- **Gym**: business, attendance, finance, and operations control
- **Trainer**: smart assignment, monitoring, and communication
- **System**: data-driven fitness lifecycle with offline-first performance

### Core outcomes
- Increase gym engagement and retention
- Reduce manual admin work
- Improve workout consistency
- Enable smart trainer decisions
- Deliver a premium, zero-lag experience

---

## 2) Product Principles

1. **Premium feel**
   - Clean, calm, motivating, high-trust UI
   - Minimal clutter
   - Strong visual hierarchy

2. **Zero-lag UX**
   - Show cached data instantly
   - Sync remote data in the background
   - Never block the interface unnecessarily

3. **Feature-first architecture**
   - Organize by business feature, not by generic screen type
   - Keep each feature self-contained

4. **Separation of concerns**
   - UI only renders
   - Controllers handle logic
   - Services handle data and APIs
   - Storage handles persistence

5. **Reusable by default**
   - Theme values centralized
   - Shared widgets centralized
   - Feature widgets stay local

---

## 3) Design System

### Color theme
Use the following palette across the app:

- **Base:** Dark Grey / Black
- **Primary:** Electric Blue
- **Secondary:** Lime Green

### UI feel
- Premium
- Minimal
- Motivating
- Clean
- Gym energy with trust

### Design rules
- Never hardcode colors, typography, spacing, or strings in feature UI
- Use centralized constants and theme files only
- Keep the experience consistent across mobile and desktop
- Use subtle glassmorphism where it adds premium depth
- Use smooth transitions and lightweight animations only

### Animation rules
- Hero animation for profile images, gym images, and key thumbnails
- Fade-in for list items
- Use motion only when it improves clarity or polish
- Avoid heavy animation packages unless truly needed

---

## 4) Non-Negotiable Flutter Architecture

### Folder structure
All application code must live inside `lib/` and follow this layout:

```text
lib/
├── core/
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_theme.dart
│   ├── constants/
│   │   ├── app_strings.dart
│   │   └── api_constants.dart
│   ├── services/
│   │   ├── api_service.dart
│   │   └── storage_service.dart
│   ├── utils/
│   │   ├── logger.dart
│   │   └── helpers.dart
│   └── bindings/
│       └── initial_binding.dart
├── common/
│   └── widgets/
│       ├── app_button.dart
│       ├── app_textfield.dart
│       ├── app_loader.dart
│       └── app_dialog.dart
├── modules/
│   ├── auth/
│   ├── user/
│   └── admin/
├── routes/
│   ├── app_routes.dart
│   └── app_pages.dart
└── main.dart
```

### Module standard
Every feature module must follow this pattern:

```text
feature_name/
├── page.dart
├── controller.dart
└── widgets/
```

### Mandatory meaning of each file
- **page.dart** → UI only
- **controller.dart** → business logic only
- **widgets/** → local UI parts only

---

## 5) State Management Standard

### Approved approach
- Use **GetX**
- Use `.obs` only for reactive state
- Use `Obx()` only where the smallest widget needs to rebuild
- Avoid wrapping full pages in reactive widgets unless absolutely necessary

### Controller lifecycle
- Fetch initial data in `onInit()`
- Use `Get.lazyPut()` in Bindings
- Keep controllers focused and small

### Controller responsibilities
Controllers may:
- call services
- manage loading states
- manage error states
- transform API data into UI-ready data
- coordinate cache and sync flows

Controllers may not:
- build UI
- contain widget code
- contain route definitions
- contain direct storage implementation details

---

## 6) Data Strategy: Offline-First + Sync-Second

### Required flow
1. Load data from local cache first
2. Show UI immediately
3. Fetch latest data from API in the background
4. Update UI with fresh data
5. Save fresh data back to local storage

### Local storage standard
Use **Hive** for caching and lightweight persistence.

### Why Hive
- Fast
- Simple
- Ideal for cache-first UX
- Avoids unnecessary complexity for this product stage

### Forbidden patterns
- Fetching API data every time the page opens without cache
- Blocking the UI until the network responds
- Using heavy storage systems where Hive is enough
- Storing business logic inside storage classes

---

## 7) Data Flow Standard

### Required app flow
**UI → Controller → Service → Storage**

### Correct responsibilities
- **UI**: display and user interaction
- **Controller**: orchestration and state
- **Service**: API and data access
- **Storage**: local cache and persistence

---

## 8) Coding Standards

### Naming
- **Files:** snake_case
- **Classes:** PascalCase
- **Variables and functions:** camelCase

### Safety
- Use full null-safety
- Wrap all API and storage calls in try-catch
- Provide clear, user-friendly error messages
- Handle empty states, loading states, and offline states

### Code quality
- Keep methods small
- Split large widgets into smaller widgets
- Use `const` constructors wherever possible
- Prefer readability over clever code

### UI rules
- UI must never contain business logic
- UI must never call APIs directly
- UI must never manage storage directly
- UI must remain declarative and lightweight

---

## 9) Theme and Constants Rules

### Mandatory theme files
- `app_colors.dart`
- `app_text_styles.dart`
- `app_theme.dart`

### Mandatory constants files
- `app_strings.dart`
- `api_constants.dart`

### Rule
Never hardcode:
- colors
- strings
- font sizes
- spacing values
- repeated API paths

All repeated values must be centralized.

---

## 10) Common Widgets Standard

Use `common/widgets/` only for reusable components that are shared across multiple modules.

Examples:
- buttons
- text fields
- loaders
- dialogs
- empty states
- error states
- confirmation cards

### Rule
If a widget is reused in more than one feature, move it to `common/widgets/`.

---


## 14) Smart Systems

These are core product differentiators and must be considered in every major feature flow.

### Required smart systems
- Equipment load balancing
- Smart workout suggestion
- Missed workout recovery
- Cross-gym data portability
- Full lifecycle tracking

### Operational logic examples
- Avoid assigning the same muscle group on consecutive high-load days
- Suggest rest or recovery when the user misses multiple days
- Balance workout groups to reduce machine congestion
- Preserve user history across branches when permitted

---

## 15) Performance Rules

### Mandatory performance approach
- Use `const` wherever possible
- Keep widget trees shallow
- Keep rebuild areas small
- Use local cache before network
- Avoid unnecessary re-rendering

### Avoid
- setState for everything
- large monolithic widgets
- API calls inside widgets
- repeated expensive computations in build methods
- unnecessary heavy libraries

### Required
- lazy controller injection
- background synchronization
- small reusable widgets
- fast initial render
- smooth transitions

---

## 16) Error Handling Standard

Every data operation must handle:
- success
- loading
- empty
- error
- offline

### Required user experience
- Show a loader during sync
- Show friendly messages for failures
- Keep cached content visible when network fails
- Never crash the screen because of one failed request

---

## 17) API Standards

### Service layer rules
- API requests must live in services
- Controllers may call services, but never embed raw request logic in pages
- Parse and validate response data before exposing it to the UI

### API handling rules
- Wrap every request in try-catch
- Validate response format
- Avoid direct assumptions about data shape
- Return consistent model objects wherever possible

---

## 18) Folder Discipline

### Keep feature code inside modules
Examples:
- `modules/user/home/`
- `modules/user/profile/`
- `modules/admin/dashboard/`
- `modules/auth/login/`

### Keep shared code inside core/common
Examples:
- colors
- themes
- strings
- services
- helpers
- reusable widgets

### Rule
Do not create random top-level folders that break the feature-first structure.

---

## 19) Documentation and Team Rules

### Required team behavior
- Follow the same architecture in every feature
- Keep module boundaries clean
- Keep code review focused on separation of concerns
- Prefer maintainability over quick hacks

### Long-term maintainability goals
- Easy onboarding for new developers
- Predictable file locations
- Simple debugging
- Safe scaling to a larger codebase

---

## 20) Final Production Checklist

Before merging any feature, confirm:

- [ ] UI contains no business logic
- [ ] Controller contains no widget code
- [ ] API calls are isolated in services
- [ ] Local cache is shown first
- [ ] Fresh data sync runs in the background
- [ ] Error, loading, and empty states exist
- [ ] Theme values come from centralized files
- [ ] Strings come from constants
- [ ] The feature follows module structure
- [ ] The feature uses GetX correctly
- [ ] The feature uses `Get.lazyPut()`
- [ ] The feature uses `const` where possible
- [ ] The feature is responsive
- [ ] The feature is reusable
- [ ] The code is null-safe

---

## 21) Final Standard

This project must always remain:

- feature-first
- premium
- offline-first
- fast
- maintainable
- reusable
- team-friendly
- production-ready

**The product goal is not just to build an app.  
The goal is to build a scalable gym operating system with a premium user experience.**


