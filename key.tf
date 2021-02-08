resource "aws_key_pair" "davorkey" {
  key_name = "davorkey"
  public_key = file(var.PATH_PUBLIC_KEY)
}