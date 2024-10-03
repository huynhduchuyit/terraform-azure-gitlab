resource "tls_private_key" "gl_rsa_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "gl_rsa_private_key" {
  content         = tls_private_key.gl_rsa_key.private_key_pem
  filename        = "${path.module}/ssh.pem"
  file_permission = 600
}
