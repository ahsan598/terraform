
# CUSTOM VPC CONFIGURATION

resource "aws_vpc" "multi_tier_vpc" {
  cidr_block              = var.vpc_cidr
  enable_dns_hostnames    = true
  enable_dns_support      = true

  tags = {
    Name = "${var.project_name}-vpc"
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_availability_zones" "available" {
}


# INTERNET GATEWAY (IGW)

resource "aws_internet_gateway" "multi_tier_igw" {
  vpc_id = aws_vpc.multi_tier_vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}


# PUBLIC SUBNETS (WEB TIER) AND ASSOCIATED ROUTE TABLES

resource "aws_subnet" "multi_tier_public_subnet" {
  count                   = length(var.public_cidr)
  vpc_id                  = aws_vpc.multi_tier_vpc.id
  cidr_block              = var.public_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name = "${var.project_name}-public-subnet-${count.index}"
  }
}

# PUBLIC RROUTE TABLE & ASSOCIATE IT TO PUBLIC SUBNETS THROUGH IGW

resource "aws_route_table" "multi_tier_public_rt" {
  vpc_id = aws_vpc.multi_tier_vpc.id

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# Public Route via Internet Gateway
resource "aws_route" "public_igw_access" {
  gateway_id             = aws_internet_gateway.multi_tier_igw.id
  route_table_id         = aws_route_table.multi_tier_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "multi_tier_public_assoc" {
  count          = length(var.public_cidr)
  subnet_id      = aws_subnet.multi_tier_public_subnet[count.index].id
  route_table_id = aws_route_table.multi_tier_public_rt.id
}



# ELASTIC IP FOR NAT GATEWAY

resource "aws_eip" "multi_tier_nat_eip" {
  domain = "vpc"
}

# NAT GATEWAY FOR PRIVATE SUBNETS
resource "aws_nat_gateway" "multi_tier_nat" {
  allocation_id = aws_eip.multi_tier_nat_eip.id
  subnet_id     = aws_subnet.multi_tier_public_subnet[0].id

  tags = {
    Name = "${var.project_name}-nat"
  }
}


# PRIVATE SUBNETS ( APP & DATABASE TIER) AND ASSOCIATED ROUTE TABLES

resource "aws_subnet" "multi_tier_private_subnet" {
  count             = length(var.private_cidr)
  vpc_id            = aws_vpc.multi_tier_vpc.id
  cidr_block        = var.private_cidr[count.index]
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.project_name}-private-subnet-${count.index}"
  }
}


# PRIVATE RROUTE TABLE & ASSOCIATE IT TO PRIVATE SUBNETS THROUGH NAT

resource "aws_route_table" "multi_tier_private_rt" {
  vpc_id = aws_vpc.multi_tier_vpc.id

  tags = {
    Name = "${var.project_name}-private-rt"
  }
}

# Private Route via NAT Gateway
resource "aws_route" "private_nat_access" {
  nat_gateway_id         = aws_nat_gateway.multi_tier_nat.id
  route_table_id         = aws_route_table.multi_tier_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
}

# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "multi_tier_private_assoc" {
  count          = length(var.private_cidr)
  subnet_id      = aws_subnet.multi_tier_private_subnet[count.index].id
  route_table_id = aws_route_table.multi_tier_private_rt.id
}

# Security Group for Web Server
resource "aws_security_group" "multi_tier_websg" {
  name        = "${var.project_name}-websg"
  description = "Security group for web servers"
  vpc_id      = aws_vpc.multi_tier_vpc.id

  tags = {
    Name = "${var.project_name}-websg"
  }
}

# Web Server Ingress Rule: Allow HTTP from specified CIDRs
resource "aws_security_group_rule" "web_ingress_http" {
  security_group_id = aws_security_group.multi_tier_websg.id
  type              = "ingress"
  from_port        = 80
  to_port          = 80
  protocol         = "tcp"
  cidr_blocks      = var.allowed_cidrs
}

# Web Server Egress Rule: Allow all outbound traffic
resource "aws_security_group_rule" "web_egress" {
  security_group_id = aws_security_group.multi_tier_websg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
}


# Security Group for Application Server
resource "aws_security_group" "multi_tier_appsg" {
  name        = "${var.project_name}-appsg"
  description = "Security group for application servers"
  vpc_id      = aws_vpc.multi_tier_vpc.id

  tags = {
    Name = "${var.project_name}-appsg"
  }
}

# App Server Ingress Rule: Allow traffic from Web Servers on port 8080
resource "aws_security_group_rule" "app_ingress" {
  security_group_id        = aws_security_group.multi_tier_appsg.id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.multi_tier_websg.id
}

# App Server Egress Rule: Allow all outbound traffic
resource "aws_security_group_rule" "app_egress" {
  security_group_id = aws_security_group.multi_tier_appsg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
}