# VS Code Server (code-server) for IIAB

VS Code Server brings Microsoft's Visual Studio Code to the browser, making it accessible as a web application perfect for learning programming and development in offline environments.

## Features

- Full Visual Studio Code experience in the browser
- Support for extensions and themes
- Built-in terminal
- Git integration
- Syntax highlighting for 100+ languages
- IntelliSense code completion
- Debugging support

## Installation

Add to `/etc/iiab/local_vars.yml`:

```yaml
vscode_server_install: True
vscode_server_enabled: True
```

Then run:

```bash
cd /opt/iiab/iiab
./iiab-install
```

## Access

After installation, access VS Code Server at:
- http://box/vscode
- http://box.lan/vscode

Default password: `changeme` (change in `/etc/iiab/local_vars.yml`)

## Configuration

Edit `/etc/iiab/local_vars.yml` to customize:

```yaml
vscode_server_port: 8443           # Internal port
vscode_server_url: /vscode         # URL path
vscode_server_password: changeme   # Access password
```

## Managing the Service

```bash
# Check status
systemctl status vscode-server

# Restart
systemctl restart vscode-server

# View logs
journalctl -u vscode-server -f
```

## Disk Usage

Approximately 300-500 MB depending on extensions installed.

## Educational Use Cases

- Learning web development (HTML, CSS, JavaScript)
- Python programming
- Creating websites with live preview
- Git version control education
- Collaborative coding exercises
- Building IIAB customizations

## Upgrading

To upgrade VS Code Server to a newer version:

1. Update `vscode_server_version` in `/etc/iiab/local_vars.yml`
2. Run: `cd /opt/iiab/iiab && ./runrole vscode-server`

## Troubleshooting

### Service won't start

Check logs:
```bash
journalctl -u vscode-server -n 50
```

### Can't access via browser

1. Verify service is running: `systemctl status vscode-server`
2. Check nginx configuration: `nginx -t`
3. Verify port is listening: `netstat -tlnp | grep 8443`

### Password issues

Reset password in `/etc/iiab/local_vars.yml` and restart:
```bash
systemctl restart vscode-server
```

## Security Notes

- Default password should be changed in production environments
- Service runs on localhost and is proxied through nginx
- Consider integrating with IIAB's authentication system for multi-user deployments
