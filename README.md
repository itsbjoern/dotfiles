# First Setup

Set `.ssh/config` for ghostty support
```
Host *
  SetEnv TERM=xterm-256color
```

## Settings

### Keyboard -> Keyboard Shortcuts

Spotlight
* Change "Show Spotlight Search" to Alt+Space

Modifier Keys
* Change "Caps Lock" to "Escape"

## Homebrew

If brew is installed as specific user, add the following line to sudoers (visudo) file for any brew user:
```
bjoern          ALL = (bjoern) NOPASSWD: /opt/homebrew/bin/brew, /usr/sbin/installer
```

## Other

Enabled TouchID for sudo:
`cd /etc/pam.d/` then add the line `auth sufficient pam_tid.so`
