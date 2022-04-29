# seeds2json

## Requirements

- [Haskell](https://www.haskell.org/ghcup/)
- Git

## Install

```bash
git clone https://github.com/ivandustin/seeds2json-haskell.git
cd seeds2json-haskell
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
