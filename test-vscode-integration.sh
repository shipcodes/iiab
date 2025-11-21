#!/bin/bash
# VS Code Server Installation Test Script for IIAB

echo "=========================================="
echo "VS Code Server IIAB Integration Test"
echo "=========================================="
echo ""

# Check if role directory exists
if [ -d "/home/muthuri/Developer/internet-in-the-box/iiab/roles/vscode-server" ]; then
    echo "✓ VS Code Server role directory exists"
else
    echo "✗ VS Code Server role directory NOT found"
    exit 1
fi

# Check if all required files exist
echo ""
echo "Checking required files..."
files=(
    "roles/vscode-server/defaults/main.yml"
    "roles/vscode-server/tasks/main.yml"
    "roles/vscode-server/tasks/install.yml"
    "roles/vscode-server/tasks/enable-or-disable.yml"
    "roles/vscode-server/templates/vscode-server.service.j2"
    "roles/vscode-server/templates/vscode-nginx.conf.j2"
    "roles/vscode-server/README.md"
)

cd /home/muthuri/Developer/internet-in-the-box/iiab

all_files_exist=true
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✓ $file"
    else
        echo "  ✗ $file MISSING"
        all_files_exist=false
    fi
done

# Check if configuration was added to default_vars.yml
echo ""
echo "Checking configuration integration..."
if grep -q "vscode_server_install" vars/default_vars.yml; then
    echo "  ✓ VS Code Server variables added to default_vars.yml"
else
    echo "  ✗ VS Code Server variables NOT found in default_vars.yml"
    all_files_exist=false
fi

# Check if role was added to 6-generic-apps
if grep -q "vscode-server" roles/6-generic-apps/tasks/main.yml; then
    echo "  ✓ VS Code Server role registered in 6-generic-apps"
else
    echo "  ✗ VS Code Server role NOT registered in 6-generic-apps"
    all_files_exist=false
fi

echo ""
echo "=========================================="
if [ "$all_files_exist" = true ]; then
    echo "✓ All checks passed!"
    echo ""
    echo "Next steps:"
    echo "1. Test the role installation:"
    echo "   cd /opt/iiab/iiab"
    echo "   sudo ./runrole vscode-server"
    echo ""
    echo "2. Or add to /etc/iiab/local_vars.yml and run full install:"
    echo "   vscode_server_install: True"
    echo "   vscode_server_enabled: True"
    echo ""
    echo "3. After installation, access at:"
    echo "   http://box/vscode or http://box.lan/vscode"
else
    echo "✗ Some checks failed. Please review above."
    exit 1
fi
echo "=========================================="
