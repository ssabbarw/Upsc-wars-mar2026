# CLAUDE.md — UPSC Wars

This file gives Claude Code the full context of this project.
Read this entirely before writing or modifying any code.

---

## Project Overview

**UPSC Wars** is a gamified UPSC (Civil Services) exam preparation app for Android and iOS.
It helps aspirants practice MCQs through topic-wise, subject-wise, and mock tests — with plans
for real-time multiplayer MCQ battles in a future phase.

**Target Users:** UPSC CSE aspirants (and state PCS) preparing for Prelims.
**Target Platforms:** Android & iOS

---

## Development Phases

### Phase 1 (Current) — Local, No Backend
- Guest mode only — no login/auth
- All MCQ data loaded from bundled JSON files in `assets/data/`
- Local storage via **sqflite** and **Hive**
- No network calls in this phase — `dio` is set up but not actively used yet
- Focus: tests, bookmarks, revision, offline-first experience

### Phase 2 (Planned) — Firebase Backend
- Firebase Auth (email/password + Google)
- Firestore for question bank and user data
- Real-time multiplayer MCQ battles

> ⚠️ Always write code with Phase 2 migration in mind.
> Repository interfaces must abstract data sources so swapping local → Firebase requires
> only a new implementation, not restructuring the domain or presentation layers.

---

## Architecture — Clean Architecture (Strict)

```
lib/
├── core/
│   ├── constants/        # App-wide constants (no magic numbers/strings)
│   ├── errors/           # Failure classes, exceptions
│   ├── logger/           # Logging wrapper (see Logging section)
│   ├── router/           # go_router route definitions
│   ├── theme/            # App theme, colors, text styles
│   └── utils/            # Generic helpers/extensions
├── features/
│   ├── splash/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── home/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── l10n/                 # ARB localization files
```

### Layer Rules

| Layer | Contains | Dependencies |
|---|---|---|
| `domain` | Entities, Repository interfaces, Use cases | Pure Dart only — no Flutter, no packages |
| `data` | Models (freezed), Repo implementations, Data sources | Can use sqflite, hive, dio |
| `presentation` | Screens, Widgets, Riverpod providers/notifiers | Can use Flutter + Riverpod |

- **Never** import `presentation` into `domain` or `data`
- **Never** call data sources directly from `presentation` — always go through a use case
- **Never** put business logic inside widget files or `build()` methods

### Adding a New Feature

Always create the full three-layer structure:
```
features/
└── new_feature/
    ├── data/
    │   ├── datasources/
    │   ├── models/
    │   └── repositories/
    ├── domain/
    │   ├── entities/
    │   ├── repositories/   # Abstract interfaces only
    │   └── usecases/
    └── presentation/
        ├── providers/
        ├── screens/
        └── widgets/
```

---

## Features (Phase 1)

### 1. Tests
- **Topic-wise test** — questions filtered by topic
- **Subject-wise test** — questions filtered by subject (Polity, History, Geography, Economy, Environment, Science)
- **Mock test** — timed, full-length simulation (100 questions, 2 hours)
- Questions loaded from bundled JSON (`assets/data/questions.json`)
- Results shown at end: score, correct/incorrect breakdown, explanations

### 2. Bookmarks & Revision
- User can bookmark any MCQ during a test
- Bookmarks persisted in **Hive**
- Dedicated revision screen to practice only bookmarked questions
- Test of incorrect answers from past attempts (stored in **sqflite**)

### 3. Offline First
- All question data is bundled in assets — zero network dependency in Phase 1
- Test history and bookmarks stored locally
- App must be fully functional with no internet connection

### 4. Multiplayer MCQ Battles (Phase 2 — Do Not Build Yet)
- Real-time battles between two aspirants
- Do not scaffold, stub, or plan this feature yet
- It will be built separately when Phase 2 begins

---

## Data Storage Strategy

| Data | Storage | Reason |
|---|---|---|
| Question bank (read-only) | JSON assets → loaded into memory | Bundled at build time |
| Test history / attempts | sqflite | Relational, queryable |
| Bookmarks | Hive | Fast key-value, simple |
| User preferences | Hive | Fast key-value |

- **sqflite** for anything relational or that needs querying/filtering
- **Hive** for simple key-value storage (bookmarks, preferences, settings)
- Never store the question bank in sqflite or Hive — always read from assets JSON

---

## Key Packages & Usage

| Package | Purpose | Notes |
|---|---|---|
| `riverpod` + `riverpod_annotation` | State management | Use code generation (`@riverpod`) |
| `freezed` | Immutable models & unions | All data models must use freezed |
| `json_serializable` | JSON parsing | Used with freezed models |
| `go_router` | Navigation | All routes defined in `core/router/` |
| `fpdart` | Functional error handling | Use `Either<Failure, T>` for all repo returns |
| `dio` | HTTP client | Set up but unused in Phase 1; keep it ready |
| `sqflite` | Relational local DB | Test history, attempts |
| `hive` | Key-value local storage | Bookmarks, preferences |
| `logger` | Logging | Never use print() |

> Do not suggest replacing or adding alternatives to these packages.
> These decisions are final for this project.

---

## Error Handling

- All repository methods must return `Either<Failure, T>` using `fpdart`
- Define domain-level `Failure` classes in `core/errors/failures.dart`
- Never throw raw exceptions from data layer — catch and return `Left(Failure)`
- In presentation, always handle three states: **loading**, **error**, **success**
- Use `AsyncValue` from Riverpod for async state in providers

Example pattern:
```dart
// domain/repositories/question_repository.dart
abstract class QuestionRepository {
  Future<Either<Failure, List<Question>>> getQuestionsByTopic(String topic);
}

// data/repositories/question_repository_impl.dart
class QuestionRepositoryImpl implements QuestionRepository {
  @override
  Future<Either<Failure, List<Question>>> getQuestionsByTopic(String topic) async {
    try {
      // implementation
      return Right(questions);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
```

---

## State Management (Riverpod)

- Always use `@riverpod` annotation (code generation)
- Use `AsyncNotifier` for async state, `Notifier` for sync state
- Keep providers in `presentation/providers/` inside each feature
- Use `ref.watch` in `build()` — never `ref.read` inside `build()`
- Never put business logic in providers — delegate to use cases

---

## Navigation (go_router)

- All route paths and names defined as constants in `core/router/app_router.dart`
- Never hardcode route strings in widget files
- Use named routes for navigation throughout the app

---

## Coding Conventions

- **Simplicity first** — always prefer the simplest working solution
- **Strict null safety** — never use `!` force-unwrap unless unavoidable; add a `// safe:` comment explaining why
- use verbose names, i don't mind long names of classes, methods and variables. their name should explain what they do or are used for. Eg; readFilesOneByOneAndPutQuestionsinDBUsingBatchingFromAnIsolate -> this is perfectly acceptable  
- Use `const` constructors and widgets everywhere possible
- All public classes, methods, and fields must have `///` dartdoc comments
- Use `final` by default — only use `var` if the value will change
- No magic numbers or hardcoded strings — use `core/constants/`
- Keep `build()` methods short — extract into private widgets if it grows beyond ~40 lines
- All localized strings must use `l10n` — never hardcode user-visible text

## Responsive Sizing
- Never hardcode pixel values for height, width, padding, margin, or font size
- Always use `context.hp()`, `context.wp()`, `context.sp()` from `core/utils/responsive.dart`
- For breakpoint checks, use `Responsive.of(context).isTablet` etc.
- ✅ `SizedBox(height: context.hp(12))`  ❌ `SizedBox(height: 104)`
- ✅ `fontSize: context.sp(16)`  ❌ `fontSize: 16`
- Only exception: border widths and divider thickness ≤ 2px can be hardcoded
---

## Logging

- **Never use `print()`** — it will be rejected
- Use the logger wrapper from `core/logger/app_logger.dart`
- Log levels:
  - `AppLogger.debug()` — development info
  - `AppLogger.warning()` — degraded state, unexpected but recoverable
  - `AppLogger.error()` — failures and exceptions
- Remove or downgrade debug logs before merging to main

---

## Code Generation

This project uses `build_runner` for:
- `freezed` — immutable models
- `json_serializable` — JSON parsing
- `riverpod_generator` — provider generation

After creating or modifying any annotated file, remind the user to run:
```bash
dart run build_runner build --delete-conflicting-outputs
```

Never manually write generated files (`.freezed.dart`, `.g.dart`).
Never modify generated files directly.

---

## DO NOT TOUCH

- `lib/l10n/` ARB files — localization strings are managed separately
- Any `*.freezed.dart` or `*.g.dart` files — these are generated
- `assets/data/` JSON files — question bank is managed separately
- Anything related to multiplayer battles — that is Phase 2

---

## What Claude Should Always Do

- Read existing code in the relevant feature before writing anything new
- Follow the naming conventions already used in the project
- Place files in the correct layer and feature folder
- Use `Either<Failure, T>` for all repository return types
- Use `freezed` for all data models
- Add `const` wherever applicable
- Write `///` dartdoc on all public APIs
- Remind user to run `build_runner` after modifying annotated files
- Keep Phase 2 migration in mind — always abstract data sources behind interfaces

## What Claude Should Never Do

- Never use `print()` — use `AppLogger` instead
- Never force-unwrap with `!` without a `// safe:` comment
- Never put business logic in widgets or `build()` methods
- Never hardcode route strings, colors, text styles, or user-visible strings
- Never import across wrong layers (e.g., data into domain, presentation into data)
- Never add new packages without being explicitly asked
- Never modify generated files (`*.g.dart`, `*.freezed.dart`)
- Never write clever or over-engineered solutions — simple and readable wins
- Never call data sources directly from the presentation layer
- Never assume internet is available in Phase 1
- Never build anything related to multiplayer/battles — that is Phase 2
- Never hardcode pixel values for height, width, padding, or margin — always use responsive sizing utils


---

## Before Making Any Change

1. Identify which feature and which layer the change belongs to
2. Check if a similar pattern already exists in the codebase — follow it exactly
3. Keep changes minimal and scoped — don't refactor unrelated code
4. If adding a new feature, scaffold the full `data/domain/presentation` structure
5. If adding annotated files, remind the user to run `build_runner`