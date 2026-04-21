resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  count         = var.instance_count
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  tags = {
    Name        = "${var.project_name}-${var.environment}-ec2"
    Environment = var.environment
  }
}
resource "aws_security_group" "ssh_access" {
  name = "${var.project_name}-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}