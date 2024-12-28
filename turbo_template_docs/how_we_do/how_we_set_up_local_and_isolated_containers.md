# 🐳 How We Set Up Local and Isolated Containers

## 📝 Introduction
We sometimes use two different container configurations for development: a local sync container for immediate feedback in IDE, and a GitHub container for clean environment testing. Both configurations use a minimal Ubuntu base image, allowing you to install tools as needed.

## 🎯 Suggested Approach
- [ ] Choose between local sync or GitHub container setup
- [ ] Create appropriate devcontainer configuration file
- [ ] Configure workspace mounting or GitHub cloning
- [ ] Set up development tools in container as needed
- [ ] Test your setup

## 👨‍🏫 Tutorial

### 1. Choose Container Setup
```bash
# Local Sync (immediate IDE feedback)
.devcontainer.local.json

# GitHub Environment (clean testing)
.devcontainer.json
```

### 2. Create Configuration File
For local sync (.devcontainer.local.json):
```json
{
    "name": "Flutter Local Sync Container",
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "mounts": [
        "source=${localWorkspaceFolder},target=/workspaces/${localWorkspaceFolderBasename},type=bind,consistency=cached"
    ]
}
```

For GitHub environment (.devcontainer.json):
```json
{
    "name": "Flutter GitHub Container",
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "workspaceFolder": "/workspaces/app"
}
```

### 3. Start Container
```bash
# For local sync (uses current directory)
devpod up --devcontainer-path .devcontainer.local.json

# For GitHub environment (uses git repository)
devpod up --devcontainer-path .devcontainer.json "YOUR_REPO_URL"