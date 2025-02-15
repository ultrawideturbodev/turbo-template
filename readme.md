# 🚀 Turbo Flutter Template

This repository provides a comprehensive Flutter template with essential features for web and mobile applications, including Firebase authentication, UI components, and architecture support.

## 🌟 Features

- 🔐 Firebase Authentication
    - Login, Create Account, Forgot password, Verify Email, Username Creation
    - Privacy Policy Acceptance
- 🎨 UI Components
    - Responsive Design, Theme Support, Multi-language Support
    - Error Screens, Loading States
- 🏗️ Architecture
    - Dependency Injection, Route Management
    - Home Shell Screen with 2 Tabs
- 🔥 Firebase Integration
    - Firestore Communication, Analytics, Remote Config, Crash Reporting

## 📚 Usage

### 1. 🛠️ Adding the template as remote

To connect the template repo, add it as another remote in your existing Flutter project:

1. Ensure you are at the root of your Flutter project in the terminal, the one where your `lib/` is location.
2. Add the remote:
   ```bash
   git remote add turbo_template https://github.com/ultrawideturbolife/turbo-template.git
   ```

### 2. ✨ Pulling latest release

To update your project with new changes from the template:

1. Make sure you are at the root of your project in the terminal.
2. Fetch the latest changes from the remote:
   ```bash
   git fetch turbo_template
   ```
3. Pull all changes locally without committing:
   ```bash
   git checkout turbo_template/main_turbo -- lib/turbo/ scripts/ analysis_options.yaml assets/
   ```
4. Optionally we have two scripts to help you with the process:
    - `t_pull_repo.sh` located in `lib/turbo` (pulls all the latest files, without committing)
    - `t_pull_release.sh` located in `lib/turbo` (pulls only files changed in a specific release without committing, defaults to the latest)

### 3. 📂 Paste files to your own project

All files and folders will be located under the folder `turbo` and are prefixed with a `t_`. This makes it easy to use and differentiate between your regular files. You can use and changes these files as is and pull any new updates with the pull scripts. If you rather copy the files to your main lib folder follow the next instructions:

1. Run one of two copy_paste scripts under `t_release` to rename and move the files to your main folders:

   Option 1 - Copy entire repository:
   ```bash
   cd lib/turbo/release
   dart run copy_paste_repo.dart
   ```

   Option 2 - Copy latest changed files only:
   ```bash 
   cd lib/turbo/release
   dart run copy_paste_release.dart
   ```

(Optional) Edit `rLatestChanges` list in `copy_paste_release.dart` to cherry pick files and folders

The copy process will transfer all files and folders to the `lib` folder, renaming them without `t_` prefixes

### Release Management

Each release of the template will be pushed with a tag (e.g. `v0.0.1`).

To pull a specific release, **make sure you are at the root** of your project and run the following commands, replacing `v0.0.1` with the desired version and optionally selecting the files and folders you want to pull:

   ```bash
  git fetch turbo_template
  git checkout tags/v0.0.1 -- lib/turbo/ scripts/ analysis_options.yaml assets/
   ```

After pulling the files, refer to the `lib/turbo/release` folder for the latest changes and copy instructions.
