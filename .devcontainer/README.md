# Ultimate Development Container

🚀 **A comprehensive, repo-less development environment for instant productivity**

This is a complete development container template that provides a fresh, isolated Ubuntu environment with all essential development tools pre-installed. Perfect for cloud development, AI projects, infrastructure as code, and general software development.

## 🎯 Purpose

**Quick and Easy Development Environment** - Clone this repository and start coding immediately without any local setup. This container is designed to be:

- **Repo-agnostic**: Use it for any project or as a playground
- **Comprehensive**: Everything you need for modern development
- **Consistent**: Same environment every time, everywhere
- **Isolated**: Clean slate for each project without conflicts

## 📦 What's Included

### 🖥️ **Core Development Environment**
- **Ubuntu 22.04 LTS** - Stable Linux base
- **Python 3.11** - Latest Python with pip and essential packages
- **Node.js LTS** - Via NVM for version management
- **Git** - Latest version with GitHub CLI integration
- **Vim/Nano** - Text editors
- **Build essentials** - gcc, make, and development tools

### 🤖 **AI & Modern Development**
- **Claude Code** - Anthropic's AI coding assistant
- **GitHub Copilot** - AI pair programming (VS Code extension)
- **Rich Python ecosystem** - requests, pyyaml, click, rich

### ☁️ **Cloud Infrastructure Tools**
- **AWS CLI v2** - Latest AWS command line interface
- **Pulumi** - Modern infrastructure as code
  - Python language support pre-configured
  - AWS resource plugin pre-installed
  - Multi-architecture support (AMD64/ARM64)

### 🛠️ **Developer Experience**
- **VS Code Extensions** - Curated selection for productivity
- **Shell enhancements** - Useful aliases and completions
- **Oh My Zsh** - Enhanced shell experience (optional)
- **Material Icon Theme** - Beautiful file icons
- **Dracula Theme** - Easy-on-the-eyes dark theme

## 🚀 Quick Start

### Option 1: GitHub Codespaces (Recommended)
1. Click the green "Use this template" button
2. Select "Open in a codespace"
3. Wait for the container to build (3-5 minutes)
4. Start coding! 🎉

### Option 2: Local VS Code with Dev Containers
1. **Prerequisites:**
   - [VS Code](https://code.visualstudio.com/)
   - [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
   - [Docker Desktop](https://www.docker.com/products/docker-desktop/)

2. **Setup:**
   ```bash
   git clone <your-repo-url>
   cd ultimate-dev-container
   code .
   ```

3. **Launch:**
   - VS Code will prompt to "Reopen in Container"
   - Click "Reopen in Container"
   - Wait for build to complete

### Option 3: Direct Docker Usage
```bash
# Clone the repository
git clone <your-repo-url>
cd ultimate-dev-container

# Build and run the container
docker build -t ultimate-dev-container .devcontainer
docker run -it --name my-dev-env -v $(pwd):/workspaces/ultimate-dev-container ultimate-dev-container
```

## ⚙️ Initial Configuration

After your container starts, run these commands to get fully set up:

### 1. Configure AWS CLI
```bash
aws configure
# Enter your AWS Access Key ID, Secret Access Key, region, and output format
```

### 2. Set up Pulumi
```bash
# Option A: Use Pulumi Cloud (recommended)
export PULUMI_ACCESS_TOKEN=your_token_here
pulumi whoami

# Option B: Use local state
pulumi login --local
```

### 3. Configure Git
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### 4. Start Claude Code
```bash
claude
# Follow the authentication prompts
```

## 📁 Container Architecture

```
.devcontainer/
├── Dockerfile              # Multi-stage container definition
├── devcontainer.json       # VS Code dev container configuration
├── post-create.sh          # One-time setup script
├── post-start.sh           # Runs every container start
└── README.md               # This file
```

### 🏗️ **Dockerfile Stages**

1. **Base Environment** - Ubuntu + Python + core tools
2. **Node.js Setup** - NVM + latest LTS + Claude Code
3. **AWS CLI** - Multi-architecture AWS CLI v2
4. **Pulumi** - Infrastructure as Code platform
5. **Shell Enhancements** - Aliases, completions, environment
6. **User Environment** - User-specific configurations
7. **Final Verification** - Ensure all tools work correctly

## 🔧 Customization

### Adding Python Packages
Create a `requirements.txt` file in the repository root:
```txt
fastapi
uvicorn
pytest
black
flake8
```

### Adding VS Code Extensions
Edit `.devcontainer/devcontainer.json`:
```json
{
  "customizations": {
    "vscode": {
      "extensions": [
        "your.extension.id"
      ]
    }
  }
}
```

### Environment Variables
Add to `.devcontainer/devcontainer.json`:
```json
{
  "containerEnv": {
    "YOUR_VARIABLE": "your_value"
  }
}
```

## 🐛 Troubleshooting

### Node.js/Claude Code Not Found
```bash
# Reload your shell environment
source ~/.bashrc

# Verify NVM and Node.js
nvm list
node --version
claude --version
```

### Pulumi Plugin Issues
```bash
# Reinstall AWS plugin
pulumi plugin install resource aws

# Check plugin status
pulumi plugin ls

# Test with a simple project
mkdir test-pulumi && cd test-pulumi
pulumi new python --yes
```

### AWS CLI Not Working
```bash
# Verify installation
aws --version

# Check configuration
aws configure list

# Test connectivity
aws sts get-caller-identity
```

### Container Build Fails
```bash
# Clean rebuild
docker system prune -a
docker build --no-cache -t ultimate-dev-container .devcontainer
```

## 🎨 Example Projects

This container is perfect for:

### ☁️ **Cloud Infrastructure**
```bash
mkdir my-infrastructure && cd my-infrastructure
pulumi new aws-python
# Edit __main__.py to define your infrastructure
pulumi up
```

### 🤖 **AI Development**
```bash
pip install openai anthropic
claude
# Use Claude Code for AI-assisted development
```

### 🐍 **Python API Development**
```bash
pip install fastapi uvicorn
# Create your API
uvicorn main:app --reload
```

### 📊 **Data Science**
```bash
pip install pandas numpy matplotlib jupyter
jupyter notebook --allow-root --ip=0.0.0.0
```

## 📊 System Requirements

- **CPU**: 4 cores minimum
- **Memory**: 8GB minimum
- **Storage**: 32GB minimum
- **Network**: Internet connection for package downloads

## 🔐 Security Notes

- Container runs as `vscode` user (non-root)
- AWS credentials are stored locally in container
- Pulumi state can be local or cloud-based
- No sensitive data is baked into the image

## 🤝 Contributing

This template is designed to be forked and customized. Feel free to:

1. Fork this repository
2. Modify for your specific needs
3. Share improvements back to the community

## 📄 License

This project is released under the MIT License. Use it freely for personal or commercial projects.

## 🆘 Support

- **Issues**: Create GitHub issues for bugs or feature requests
- **Discussions**: Use GitHub Discussions for questions
- **Claude Code**: Check [official documentation](https://docs.claude.com/claude-code)
- **AWS CLI**: Check [AWS CLI documentation](https://docs.aws.amazon.com/cli/)
- **Pulumi**: Check [Pulumi documentation](https://www.pulumi.com/docs/)

---

**🚀 Ready to build something amazing? Clone this repo and start coding in seconds!**