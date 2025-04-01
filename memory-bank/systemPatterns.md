# System Patterns

## Architecture Overview
The dotfiles repository follows a modular architecture organized by function and environment. The system is designed to be flexible, allowing selective application of configurations based on the target environment.

## Directory Structure
```
dotfiles/
├── box/                 # Environment-specific setup scripts
│   ├── arch/            # Arch Linux configurations
│   └── macos/           # macOS configurations
├── docs/                # Documentation
├── home/                # Home directory configurations
│   ├── bin/             # Executable scripts and utilities
│   ├── docker/          # Docker configurations
│   ├── dots/            # Shell configurations by context
│   └── profiles/        # Profile-specific configurations
└── scripts/             # Installation and setup scripts
    └── utils/           # Utility functions for scripts
```

## Key Design Patterns

### 1. Environment-Based Configuration
The repository separates configurations by environment (macOS, Arch Linux, etc.) to accommodate different system requirements while maintaining consistency where possible.

**Implementation:**
- Use of environment-specific directories (box/arch/, box/macos/)
- Configuration files with environment-specific extensions (.linux, .macos)
- Environment detection in installation scripts

### 2. Symlink Management
Configuration files are deployed using symbolic links to maintain a single source of truth in the repository.

**Implementation:**
- Dotbot configuration files (dotbot.*.conf.yaml)
- Symlink creation during installation process
- Environment-specific symlink configurations

### 3. Modular Shell Configuration
Shell configurations are organized modularly to improve maintainability and allow selective loading.

**Implementation:**
- Core configuration files (.bashrc, .zshrc)
- Topical organization (.aliases, .functions, .exports)
- Context-specific configurations (personal/, work/)

### 4. Secret Management
Sensitive information is segregated and protected.

**Implementation:**
- .secret extension for files containing sensitive data
- .gitignore patterns to exclude sensitive files
- Scripts to handle secret files (reveal-secret)

### 5. Installation Automation
Automated installation processes reduce setup time and ensure consistency.

**Implementation:**
- Installation scripts (install.sh, deploy.sh)
- Package management automation (packages.sh)
- Environment-specific setup scripts (setup.sh)

## Component Relationships

### Configuration Loading Flow
1. Core shell configuration (.zshrc/.bashrc)
2. Profile-specific settings (profiles/*)
3. Common configurations (dots/personal/, dots/work/)
4. Environment-specific configurations (.linux, .macos)
5. Context-specific customizations

### Installation Process Flow
1. Environment detection
2. Dependency installation
3. Package installation
4. Configuration deployment (symlink creation)
5. Post-installation setup

## Critical Implementation Paths

### System Bootstrap
```
scripts/install.sh → scripts/dependencies.sh → box/[env]/packages.sh → scripts/deploy.sh → box/[env]/setup.sh
```

### Configuration Updates
```
scripts/sync.sh → scripts/deploy.sh
```

### Profile Management
```
.zshrc/.bashrc → profiles/common.sh → profiles/[specific-profile].sh
```
