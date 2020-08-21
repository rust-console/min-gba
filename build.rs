fn main() {
  let as_output = std::process::Command::new("arm-none-eabi-as")
    .args(&["-o", "target/rsrt0.o"])
    .arg("-mthumb-interwork")
    .arg("-mcpu=arm7tdmi")
    .arg("src/rsrt0.S")
    .output()
    .expect("failed to run arm-none-eabi-as");
  if !as_output.status.success() {
    panic!("{}", String::from_utf8_lossy(&as_output.stderr));
  }
}
