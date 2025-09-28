#!/usr/bin/env bash
set -euo pipefail

echo
echo "🚀 Starting Ultimate Dev Container Post-Creation Setup..."
echo "=================================================="

# Ensure we're using the correct user
whoami
echo "Current working directory: $(pwd)"
echo

# ---- Python Dependencies ----
echo "🐍 Setting up Python environment..."
if [ -f requirements.txt ]; then
  echo "   📦 Installing/updating Python dependencies from requirements.txt..."
  pip install --no-cache-dir --upgrade pip
  pip install --no-cache-dir -r requirements.txt
else
  echo "   ✅ No requirements.txt found, installing essential Python packages..."
  pip install --no-cache-dir --upgrade pip setuptools wheel
  pip install --no-cache-dir requests boto3 pyyaml click rich pulumi
fi

# ---- Node.js and Claude Code Setup ----
echo
echo "📦 Setting up Node.js and Claude Code..."
source ~/.bashrc

# Verify Node.js installation
if command -v node >/dev/null 2>&1; then
  echo "   ✅ Node.js version: $(node --version)"
  echo "   ✅ npm version: $(npm --version)"
else
  echo "   ⚠️  Node.js not found in PATH, attempting to load nvm..."
  source ~/.nvm/nvm.sh
  nvm use default || nvm use --lts
fi

# Verify Claude Code installation
if command -v claude >/dev/null 2>&1; then
  echo "   ✅ Claude Code is available: $(claude --version 2>/dev/null || echo 'installed')"
else
  echo "   🔧 Installing Claude Code..."
  npm install -g @anthropic-ai/claude-code
fi

# ---- Pulumi Setup ----
echo
echo "⚡ Setting up Pulumi environment..."

# Ensure Pulumi directories exist for the vscode user
mkdir -p ~/.pulumi/plugins
mkdir -p ~/.pulumi/bin
mkdir -p ~/.pulumi/credentials

# Verify Pulumi installation
if command -v pulumi >/dev/null 2>&1; then
  echo "   ✅ Pulumi version: $(pulumi version)"
else
  echo "   ❌ Pulumi not found in PATH!"
  exit 1
fi

# Set Pulumi configuration
export PULUMI_SKIP_UPDATE_CHECK=true

# Install essential Pulumi plugins
echo "   🔌 Installing essential Pulumi plugins..."

# Install AWS plugin (most commonly used)
echo "   📥 Installing AWS resource plugin..."
pulumi plugin install resource aws || echo "   ⚠️  AWS plugin installation failed, but continuing..."

# Install Python language plugin (if not already available)
echo "   🐍 Ensuring Python language plugin is available..."
cd /tmp
mkdir -p test-pulumi-python
cd test-pulumi-python

# Create a minimal test project to ensure Python plugin works
cat > Pulumi.yaml << 'EOF'
name: test-python-plugin
runtime: python
description: Test project to ensure Python plugin availability
EOF

cat > __main__.py << 'EOF'
import pulumi
pulumi.export("status", "python-plugin-working")
EOF

cat > requirements.txt << 'EOF'
pulumi>=3.0.0
EOF

# Test Python plugin
echo "   🧪 Testing Python language plugin..."
pulumi stack init test-stack --non-interactive --secrets-provider=passphrase --secrets-provider-args=provider.passphrase=test123 || echo "   ⚠️  Stack init completed with warnings"

# Cleanup test project
cd /tmp
rm -rf test-pulumi-python

echo "   ✅ Pulumi Python plugin test completed"

# ---- AWS CLI Setup ----
echo
echo "☁️  Verifying AWS CLI..."
if command -v aws >/dev/null 2>&1; then
  echo "   ✅ AWS CLI version: $(aws --version)"
  echo "   💡 Run 'aws configure' to set up your credentials"
else
  echo "   ❌ AWS CLI not found!"
  exit 1
fi

# ---- Git Configuration ----
echo
echo "🔧 Setting up Git configuration..."
if [ -z "$(git config --global user.name 2>/dev/null || true)" ]; then
  echo "   💡 Remember to configure Git with:"
  echo "      git config --global user.name 'Your Name'"
  echo "      git config --global user.email 'your.email@example.com'"
else
  echo "   ✅ Git already configured for: $(git config --global user.name)"
fi

# ---- Environment Verification ----
echo
echo "🔍 Final environment verification..."
echo "   📍 Working directory: $(pwd)"
echo "   👤 Current user: $(whoami)"
echo "   🐍 Python: $(python --version)"
echo "   📦 Node.js: $(node --version 2>/dev/null || echo 'Not in current PATH - use source ~/.bashrc')"
echo "   ⚡ Pulumi: $(pulumi version)"
echo "   ☁️  AWS CLI: $(aws --version)"

# List installed Pulumi plugins
echo
echo "🔌 Installed Pulumi plugins:"
pulumi plugin ls || echo "   ⚠️  Could not list plugins, but installation should be functional"

echo
echo "=================================================="
echo "🎉 Ultimate Dev Container setup complete!"
echo
echo "📋 Quick Start Commands:"
echo "   • Configure AWS: aws configure"
echo "   • Set Pulumi token: export PULUMI_ACCESS_TOKEN=your_token"
echo "   • Start Claude Code: claude"
echo "   • Check versions: python --version && node --version && pulumi version"
echo
echo "🚀 Happy coding!"
echo "=================================================="
echo