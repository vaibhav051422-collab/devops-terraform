resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  count        = var.instance_count
  

  tags = {
     Name        = "${var.project_name}-${var.environment}-ec2"
     Environment = var.environment
  }
}