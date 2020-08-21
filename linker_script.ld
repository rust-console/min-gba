ENTRY(__start)

MEMORY {
  ewram (w!x) : ORIGIN = 0x2000000, LENGTH = 256K
  iwram (w!x) : ORIGIN = 0x3000000, LENGTH = 32K
  rom (rx)    : ORIGIN = 0x8000000, LENGTH = 32M
}

SECTIONS {
  .text : {
    KEEP(target/rsrt0.o(.text));
    *(.text .text.*);
    . = ALIGN(4);
  } >rom = 0xff

  .rodata : {
    KEEP(target/rsrt0.o(.rodata));
    *(.rodata .rodata.*);
    . = ALIGN(4);
  } >rom = 0xff

  __data_rom_start = .;
  .data : {
    __data_iwram_start = ABSOLUTE(.);
    KEEP(target/rsrt0.o(.data));
    *(.data .data.*);
    . = ALIGN(4);
    __data_iwram_end = ABSOLUTE(.);
  } >iwram AT>rom = 0xff

  .bss : {
    __bss_iwram_start = ABSOLUTE(.);
    KEEP(target/rsrt0.o(.bss));
    *(.bss .bss.*);
    . = ALIGN(4);
    __bss_iwram_end = ABSOLUTE(.);
  } >iwram

  /* discard anything not already mentioned */
  /DISCARD/ : { *(*) }
}
