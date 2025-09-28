#!/usr/bin/env bash
set -euo pipefail

# Post-start script runs every time the container starts
# Keep this lightweight and fast

echo
echo "🌟 Ultimate Dev Container is ready!"
echo "=================================="

# Display current environment status
echo "📍 Container Status:"
echo "   🐍 Python: $(python --version)"
echo "   📦 Node.js: $(source ~/.bashrc && node --version 2>/dev/null || echo 'Loading... (run: source ~/.bashrc)')"
echo "   ⚡ Pulumi: $(pulumi version)"
echo "   ☁️  AWS CLI: $(aws --version)"
echo "   🤖 Claude Code: $(claude --version 2>/dev/null || echo 'Available (run: claude)')"

echo
echo "🚀 Quick Setup Reminders:"
echo "   • AWS Configuration: aws configure"
echo "   • Pulumi Token: export PULUMI_ACCESS_TOKEN=your_token_here"
echo "   • Claude Code Login: claude (then follow authentication prompts)"

# Check if AWS is configured
if aws configure list >/dev/null 2>&1 && [ "$(aws configure get aws_access_key_id 2>/dev/null || echo '')" != "" ]; then
  echo "   ✅ AWS CLI appears to be configured"
else
  echo "   ⚠️  AWS CLI not configured - run: aws configure"
fi

# Check if Pulumi token is set
if [ -n "${PULUMI_ACCESS_TOKEN:-}" ] || pulumi whoami >/dev/null 2>&1; then
  echo "   ✅ Pulumi authentication configured"
else
  echo "   ⚠️  Pulumi not authenticated - set PULUMI_ACCESS_TOKEN or run: pulumi login"
fi

# Check Node.js environment
if source ~/.bashrc && command -v node >/dev/null 2>&1; then
  echo "   ✅ Node.js environment ready"
else
  echo "   ℹ️  Run 'source ~/.bashrc' to load Node.js environment"
fi

echo
echo "💡 Useful Commands:"
echo "   claude          - Start Claude Code AI assistant"
echo "   pulumi new      - Create new Pulumi project"
echo "   aws s3 ls       - Test AWS connectivity"
echo "   python -m pip list - Show installed Python packages"
echo "   npm list -g     - Show global npm packages"

echo
echo "🎯 Ready for development!"
echo "=================================="
echo