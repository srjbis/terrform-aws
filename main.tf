provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_access_key}"
  region = "${var.region}"
}

resource "aws_instance" "a1-web" {
  ami = "${var.ami_id}"
  #count = 1
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id_1a}"
  associate_public_ip_address = true
  ebs_optimized = false
  monitoring = false
  tenancy = "default"
  
  get_password_data = false
  
  #root_block_device = [1]
  root_block_device {
    delete_on_termination = true
    iops = 100
    #volume_id = "vol-061be31388740e3ba"
	# volume size unit is in GB free upto 30 GB
    volume_size = 30
    volume_type = "gp2"
  }
  
  availability_zone = "${var.availability_zone_1a}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  
  user_data = "${file("web.bash")}"
  
  tags = {
    Name = "a1-web"
  }
}

resource "aws_instance" "b1-web" {
  ami = "${var.ami_id}"
  #count = 1
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id_1b}"
  associate_public_ip_address = true
  ebs_optimized = false
  monitoring = false
  tenancy = "default"
  
  get_password_data = false
  
  #root_block_device = [1]
  root_block_device {
    delete_on_termination = true
    iops = 100
    #volume_id = "vol-061be31388740e3ba"
	# volume size unit is in GB free upto 30 GB
    volume_size = 30
    volume_type = "gp2"
  }
  
  availability_zone = "${var.availability_zone_1b}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  
  user_data = "${file("web.bash")}"
  
  tags = {
    Name = "b1-web"
  }
}

resource "aws_instance" "c1-web" {
  ami = "${var.ami_id}"
  #count = 1
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id_1c}"
  associate_public_ip_address = true
  ebs_optimized = false
  monitoring = false
  tenancy = "default"
  
  get_password_data = false
  
  #root_block_device = [1]
  root_block_device {
    delete_on_termination = true
    iops = 100
    #volume_id = "vol-061be31388740e3ba"
	# volume size unit is in GB free upto 30 GB
    volume_size = 30
    volume_type = "gp2"
  }
  
  availability_zone = "${var.availability_zone_1c}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  
  user_data = "${file("web.bash")}"
  
  tags = {
    Name = "c1-web"
  }
}

resource "aws_instance" "a1-db" {
  ami = "${var.ami_id}"
  #count = 1
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id_1a}"
  associate_public_ip_address = true
  ebs_optimized = false
  monitoring = false
  tenancy = "default"
  
  get_password_data = false
  
  #root_block_device = [1]
  root_block_device {
    delete_on_termination = true
    iops = 100
    #volume_id = "vol-061be31388740e3ba"
	# volume size unit is in GB free upto 30 GB
    volume_size = 30
    volume_type = "gp2"
  }
  
  availability_zone = "${var.availability_zone_1a}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  
  user_data = "${file("db.bash")}"
  
  tags = {
    Name = "a1-db"
  }
}

resource "aws_instance" "b1-db" {
  ami = "${var.ami_id}"
  #count = 1
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id_1b}"
  associate_public_ip_address = true
  ebs_optimized = false
  monitoring = false
  tenancy = "default"
  
  get_password_data = false
  
  #root_block_device = [1]
  root_block_device {
    delete_on_termination = true
    iops = 100
    #volume_id = "vol-061be31388740e3ba"
	# volume size unit is in GB free upto 30 GB
    volume_size = 30
    volume_type = "gp2"
  }
  
  availability_zone = "${var.availability_zone_1b}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  
  user_data = "${file("db.bash")}"
  
  tags = {
    Name = "b1-db"
  }
}

resource "aws_instance" "c1-db" {
  ami = "${var.ami_id}"
  #count = 1
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id_1c}"
  associate_public_ip_address = true
  ebs_optimized = false
  monitoring = false
  tenancy = "default"
  
  get_password_data = false
  
  #root_block_device = [1]
  root_block_device {
    delete_on_termination = true
    iops = 100
    #volume_id = "vol-061be31388740e3ba"
	# volume size unit is in GB free upto 30 GB
    volume_size = 30
    volume_type = "gp2"
  }
  
  availability_zone = "${var.availability_zone_1c}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  
  user_data = "${file("db.bash")}"
  
  tags = {
    Name = "c1-db"
  }
}

resource "aws_elb" "web-elb" {
  name = "web-elb"
  instances = ["${aws_instance.a1-web.id}", "${aws_instance.b1-web.id}", "${aws_instance.c1-web.id}"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  security_groups    = ["${var.vpc_security_group_ids}"]

  listener {
    instance_port = 8080
    instance_protocol = "tcp"
    lb_port = 8080
    lb_protocol = "tcp"
  }

  health_check {
    target = "TCP:8080"
    healthy_threshold = 2
    unhealthy_threshold = 2
    interval = 30
    timeout = 5
  }

  tags = {
    Name = "web-elb"
  }
}

resource "aws_lb" "db-nlb" {
  name = "db-nlb"
  internal = false
  load_balancer_type = "network"
  subnets = ["${var.subnet_id_1a}", "${var.subnet_id_1b}", "${var.subnet_id_1c}"]
  enable_deletion_protection = true

  tags = {
    Name = "db-nlb"
  }
}
