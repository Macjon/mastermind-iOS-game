# mastermind-iOS-game

A Mastermind-style word guessing game built with SwiftUI. A random 4-letter sequence is generated at the start and the player has 60 seconds to crack it.

## Requirements

| Tool                                              | Version     |
| ------------------------------------------------- | ----------- |
| Xcode                                             | 26 or later |
| iOS deployment target                             | 18.0+       |
| Swift                                             | 5.9+        |
| [XcodeGen](https://github.com/yonaskolb/XcodeGen) | 2.x         |

> The `.xcodeproj` file is **not** committed to source control. It is generated from `project.yml` using XcodeGen.

---

## Getting Started

### 1. Install XcodeGen

If you don't have XcodeGen installed, the easiest way is via Homebrew:

```bash
brew install xcodegen
```

Verify the installation:

```bash
xcodegen --version
```

### 2. Clone / open the repository

```bash
cd /path/to/mastermind-iOS-game
```

### 3. Generate the Xcode project

Run XcodeGen from the root of the repository (the directory that contains `project.yml`):

```bash
xcodegen generate
```

This reads `project.yml` and writes `mastermindiOSGame.xcodeproj` next to it. You should see:

```
⚙️  Generating plists...
⚙️  Generating project...
⚙️  Writing project...
Created project at /path/to/mastermind-iOS-game/mastermindiOSGame.xcodeproj
```

> Re-run `xcodegen generate` any time you add, remove, or rename source files, or change project settings in `project.yml`. You never need to touch the `.xcodeproj` manually.

### 4. Open in Xcode

```bash
open mastermindiOSGame.xcodeproj
```

Select an iPhone simulator (iOS 18+) and press **Run** (`⌘R`).
