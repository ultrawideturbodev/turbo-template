# 🐳 How We Set Up Local and Isolated Containers

## 📝 Introduction
We sometimes use two different container configurations for development: a local sync container for immediate feedback in IDE, and an isolated container for clean environment testing. Both configurations share host Flutter SDK and support Firebase CLI commands while maintaining different workspace isolation levels.

## 🎯 Suggested Approach
- [ ] Choose between local sync or isolated container setup
- [ ] Create appropriate devcontainer configuration file
- [ ] Configure container mounts and environment variables
- [ ] Set up workspace mounting strategy
- [ ] Test Flutter and Firebase CLI commands

## 👨‍🏫 Tutorial

### 1. Choose Container Setup
```bash
# Local Sync (immediate IDE feedback)
.devcontainer.local.json

# Isolated Environment (clean testing)
.devcontainer.isolated.json
```

### 2. Create Configuration File
For local sync (.devcontainer.local.json):
```json
{
    "name": "Flutter Local Sync Container",
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/devcontainers/features/node:1": {}
    },
    "mounts": [
        "source=/Users/${localEnv:USER}/flutter,target=/Users/${localEnv:USER}/flutter,type=bind,consistency=cached",
        "source=/Users/${localEnv:USER}/.vscode-server,target=/home/vscode/.vscode-server,type=bind,consistency=cached"
    ],
    "remoteEnv": {
        "PATH": "${containerEnv:PATH}:/Users/${localEnv:USER}/flutter/bin",
        "FLUTTER_ROOT": "/Users/${localEnv:USER}/flutter"
    }
}
```

For isolated environment (.devcontainer.isolated.json):
```json
{
    "name": "Flutter Isolated Container",
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/devcontainers/features/node:1": {}
    },
    "mounts": [
        "source=/Users/${localEnv:USER}/flutter,target=/opt/flutter,type=bind,readonly,consistency=cached"
    ],
    "remoteEnv": {
        "PATH": "${containerEnv:PATH}:/opt/flutter/bin",
        "FLUTTER_ROOT": "/opt/flutter"
    },
    "workspaceMount": "source=${localWorkspaceFolder},target=/workspaces/app,type=bind",
    "workspaceFolder": "/workspaces/app"
}
```

### 3. Start Container
```bash
# For local sync (uses current directory)
devpod up --devcontainer-path .devcontainer.local.json

# For isolated environment (uses git repository)
devpod up --devcontainer-path .devcontainer.isolated.json "YOUR_REPO_URL"
```

### 4. Verify Setup
```bash
# Test Flutter CLI
flutter --version

# Test Firebase CLI
firebase --version
```

### 5. Use Workspace
Local sync container:
- Changes reflect immediately in local IDE
- Direct file system access
- Perfect for active development
- VS Code server is cached between sessions

Isolated container:
- Clean environment for testing
- Fresh clone from repository
- Read-only SDK access
- Prevents host system conflicts