# min-gba

A minimal setup to build Rust into a GBA ROM.

## What's Needed

* `rustup default nightly` (or run all commands with `cargo +nightly`)
* `rustup component install rust-src`
* `arm-none-eabi` binutils (either via [The ARM Website][1], or your linux package manager).
* The following files:
  * `.cargo/config.toml`
  * `src/rsrt0.S`
  * `linker_script.ld`
  * `build.rs`

[1]: https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm

## Rust Analyzer

It'll go nuts, here's how you fix it:

`.vscode/settings.json`:
```json
{
  "rust-analyzer.checkOnSave.allTargets": false,
  "rust-analyzer.checkOnSave.extraArgs": [
    "--lib"
  ]
}
```
