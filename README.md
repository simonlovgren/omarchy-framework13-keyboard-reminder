# Framework 13 Keyboard Reminder

Omarchy bar plugin. Click `Fn` in bar: popup shows ANSI keyboard layout and
Framework Laptop 13 top-row shortcuts.

Colors, borders, spacing, and type use Omarchy `Color` and `Style` variables,
so theme and font changes reskin it automatically.

## Function row

Hold `Fn` with top-row key:

| Key | Function |
| --- | --- |
| F1 / F2 | Display brightness down / up |
| F3 / F4 | Keyboard backlight down / up |
| F5 | Wireless toggle |
| F6 | Microphone mute |
| F7 / F8 / F9 | Previous / play-pause / next media track |
| F10 | Speaker mute |
| F11 / F12 | Volume down / up |

## Install

```bash
omarchy plugin add /absolute/path/to/framework13-fn-keys --enable --yes
omarchy bar move maustronaut.framework13-keyboard-reminder --section right
```

Or copy checkout to
`~/.config/omarchy/plugins/maustronaut.framework13-keyboard-reminder/`, then:

```bash
omarchy-shell shell rescanPlugins
omarchy plugin enable maustronaut.framework13-keyboard-reminder
```

Plugin uses Omarchy's `bar-widget` and `KeyboardPanel` interfaces. No commands
run and no system settings change.

## License

[MIT](LICENSE)
