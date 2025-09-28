# 🚀 Ultimate Development Container

**A comprehensive, ready-to-use development environment for modern software development**

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main&repo=your-repo-id&machine=standardLinux32gb&devcontainer_path=.devcontainer%2Fdevcontainer.json&location=WestUs2)

## ✨ Features

🤖 **AI-Powered Development**
- Claude Code - Anthropic's AI coding assistant
- GitHub Copilot integration
- Rich development environment

☁️ **Cloud-Native Tools**
- AWS CLI v2 (latest)
- Pulumi infrastructure as code
- Multi-architecture support (AMD64/ARM64)

🐍 **Modern Python Stack**
- Python 3.11 with essential packages
- FastAPI, pandas, pytest pre-installed
- Jupyter notebooks ready

📦 **Node.js Ecosystem**
- Latest LTS via NVM
- npm and yarn available
- TypeScript support

🛠️ **Developer Experience**
- VS Code optimized
- 20+ curated extensions
- Beautiful themes and icons
- Shell enhancements

## 🚀 Get Started in 30 Seconds

### Option 1: GitHub Codespaces (Click the badge above!)
1. Click "Open in GitHub Codespaces"
2. Wait 3-5 minutes for setup
3. Start coding immediately!

### Option 2: Local Development
```bash
git clone https://github.com/yourusername/ultimate-dev-container.git
cd ultimate-dev-container
code .
# VS Code will prompt to open in container
```

## 🎯 Perfect For

- **🏗️ Infrastructure as Code** - Pulumi + AWS
- **🤖 AI Development** - Claude Code integration
- **🐍 Python Projects** - FastAPI, data science, automation
- **☁️ Cloud Development** - AWS, serverless, containers
- **📊 Data Science** - Jupyter, pandas, numpy
- **🌐 Web Development** - Node.js, TypeScript, APIs

## 📋 What's Pre-Installed

| Tool | Version | Purpose |
|------|---------|---------|
| Python | 3.11 | Core development |
| Node.js | LTS (via NVM) | JavaScript/TypeScript |
| AWS CLI | v2 | Cloud operations |
| Pulumi | Latest | Infrastructure as Code |
| Claude Code | Latest | AI coding assistant |
| Git + GitHub CLI | Latest | Version control |
| Docker | Available | Containerization |

## ⚙️ Quick Setup

After container starts:

```bash
# Configure AWS
aws configure

# Set Pulumi token
export PULUMI_ACCESS_TOKEN=your_token

# Start Claude Code
claude

# Configure Git
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

## 📁 Project Structure

```
ultimate-dev-container/
├── .devcontainer/
│   ├── Dockerfile           # Container definition
│   ├── devcontainer.json    # VS Code configuration
│   ├── post-create.sh       # Setup automation
│   ├── post-start.sh        # Startup script
│   └── README.md            # Detailed documentation
├── requirements.txt         # Python dependencies
└── README.md               # This file
```

## 🎨 Example Usage

### Create Infrastructure with Pulumi
```bash
mkdir my-infrastructure && cd my-infrastructure
pulumi new aws-python
# Edit __main__.py
pulumi up
```

### AI-Assisted Development
```bash
claude
# Ask Claude Code to help with your project
```

### Python Web API
```bash
pip install fastapi uvicorn
# Create main.py with FastAPI app
uvicorn main:app --reload
```

## 🔧 Customization

Add your own dependencies to `requirements.txt`:
```txt
tensorflow
streamlit
opencv-python
```

Modify VS Code settings in `.devcontainer/devcontainer.json`

## 🆘 Need Help?

- 📖 **Detailed docs**: Check `.devcontainer/README.md`
- 🐛 **Issues**: Open a GitHub issue
- 💬 **Discussions**: Use GitHub Discussions
- 📚 **Tool docs**: [Claude Code](https://docs.claude.com/claude-code) | [Pulumi](https://pulumi.com/docs) | [AWS CLI](https://docs.aws.amazon.com/cli/)

## 📄 License

MIT License - Use freely for personal or commercial projects.

---

**🎯 Ready to build? Click the Codespaces badge above and start coding in seconds!**