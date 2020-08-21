
@ linker entry point
.global __start

.arm
__start: b init
@ this is replaced with correct header info by `gbafix`
.space 188

init:
  @ We boot in Supervisor mode, change to System mode.
  mov r0, #0x1f
  msr CPSR_c, r0

  @ Set stack pointer.
  ldr sp, =0x3007F00

  @ call Rust `main`
  ldr r2, =main
  bx r2

  @ `main` should never return.
  1: b 1b
