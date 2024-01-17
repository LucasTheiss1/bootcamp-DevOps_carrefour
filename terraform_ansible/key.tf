resource "aws_key_pair" "keypair_bootcamp" {
  key_name   = "keypair_bootcamp_carrefour"
  public_key = "${file("~/.ssh/id_rsa.pub")}"

}
