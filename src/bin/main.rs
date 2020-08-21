#![no_std]
#![no_main]

#[panic_handler]
fn panic(_info: &core::panic::PanicInfo) -> ! {
  unsafe {
    let x = 0_i32;
    loop {
      (&x as *const i32).read_volatile();
    }
  }
}

#[no_mangle]
pub fn main() {
  unsafe {
    (0x0400_0000 as *mut u16).write_volatile(3 | (1 << 10));
    (0x0600_0000 as *mut u16).add(240).add(1).write_volatile(0b11111);
    panic!()
  }
}
