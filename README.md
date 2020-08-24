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

## Final ROM

What you get with the project setup is an executable ELF file, but [mgba](https://mgba.io/) can run it directly, so that's fine.

For a finalized ROM there's some post-processing steps:

* `objcopy` must be used to extact just the binary guts from the ELF file.
  * The command you want is probably something like this (change `main` to your binary's own name):
  * `arm-none-eabi-objcopy -O binary target/thumbv4t-none-eabi/release/main target/main.gba`

* `gbafix` should be used to apply the correct header.
  * You can get a Rust version of `gbafix` via cargo: `cargo install gbafix`
  * You can also get the C version of gbafix from the DevKitPro folks.
  * Either way, `gbafix main.gba` will ensure that the gba file has the correct header info.
