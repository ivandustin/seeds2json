# seeds2json

Convert [seeds](https://github.com/ivandustin/seeds) from Markdown to JSON format.

## Requirements

- [Haskell](https://www.haskell.org/ghcup/)
- Git

## Install

```bash
git clone https://github.com/ivandustin/seeds2json.git
cd seeds2json
cabal install --overwrite-policy=always
```

## Usage

```bash
mkdir seeds-json
cd seeds-json
git clone https://github.com/ivandustin/seeds.git
seeds2json seeds/README.md
```

The result will be written in `seeds.json` in the current working directory.
