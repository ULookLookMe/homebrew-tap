# ULookLookMe/homebrew-tap

Homebrew formulae for [agentmode](https://github.com/ULookLookMe/agent-mode), which keeps a MacBook awake for
coding agents, lid open or closed, with automatic safety pauses.

```sh
brew install ulooklookme/tap/agentmode
zsh "$(brew --prefix)/share/agentmode/setup-privileges.sh"
```

The formula builds from source, so it needs Swift 6.4 (Xcode 27 or the Command Line Tools) on an Apple
silicon Mac with macOS 27 or later. See the [agentmode README](https://github.com/ULookLookMe/agent-mode#readme)
for what the second command does and how to uninstall.
