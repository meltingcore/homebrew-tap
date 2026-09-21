# Melting Core Homebrew tap

Install [Malina](https://github.com/meltingcore/malina), the native Raspberry Pi backup and restore
app, together with its command-line tool:

```sh
brew install --cask meltingcore/tap/malina
```

Upgrade it with:

```sh
brew upgrade --cask malina
```

The cask is generated from Malina's latest stable GitHub release. Maintainers can run the
`Sync Malina cask` workflow after publishing a release; a scheduled run is retained as a fallback.
