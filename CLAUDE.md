# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Plugin Overview

This is a Discourse plugin called "discourse-another-smtp" that allows configuring an alternative SMTP server for email delivery. The plugin intercepts email sending events and dynamically switches SMTP settings based on the configuration.

## Plugin Architecture

### Core Components

1. **plugin.rb** - Main plugin file that:
   - Registers the plugin with Discourse
   - Hooks into the `before_email_send` event
   - Dynamically modifies email delivery settings when enabled

2. **config/settings.yml** - Defines admin-configurable settings:
   - `discourse_another_email_enabled` - Master toggle for the plugin
   - SMTP configuration settings (address, port, username, password, authentication mode)

3. **config/locales/** - Localization files for plugin settings UI

### How It Works

The plugin uses Discourse's event system to intercept emails before they're sent. When enabled, it overrides the default SMTP settings with the configured alternative SMTP server settings by modifying the `message.delivery_method.settings` hash.

## Development Commands

### Testing
This plugin follows standard Discourse plugin testing conventions. Run tests from the main Discourse installation:
```bash
# Run plugin specs (from Discourse root)
bundle exec rake plugin:spec[discourse-another-smtp]
```

### Installation
```bash
# Clone to Discourse plugins directory
cd /var/discourse/plugins
git clone https://github.com/Lhcfl/discourse-another-smtp.git

# Rebuild Discourse
cd /var/discourse
./launcher rebuild app
```

## Key Technical Details

- Requires Discourse version 3.0.0 or higher
- Modifies email delivery settings at runtime via the `before_email_send` event
- All SMTP settings are stored as site settings accessible from admin panel
- Password field is marked as `secret: true` for security