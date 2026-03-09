# Claude Code setup

## Adding your API key to macOS Keychain

```sh
security add-generic-password -a joey.hardy -s claude-api-key -w "YOUR_API_KEY"
```

To update an existing key:

```sh
security delete-generic-password -a joey.hardy -s claude-api-key
security add-generic-password -a joey.hardy -s claude-api-key -w "YOUR_API_KEY"
```

To verify it works:

```sh
~/.claude/get-key.sh
```
