# Public Subnets

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr_blocks[0]
  map_public_ip_on_launch = true
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "${var.env}-${var.stack}-${var.subnet_pb}-1"
  }

}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr_blocks[1]
  map_public_ip_on_launch = true
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "${var.env}-${var.stack}-${var.subnet_pb}-2"
  }

}

# Private Subnets

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr_blocks[0]
  map_public_ip_on_launch = false
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "${var.env}-${var.stack}-${var.subnet_prt}-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr_blocks[1]
  map_public_ip_on_launch = false
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "${var.env}-${var.stack}-${var.subnet_prt}-2"
  }
}

#Public Route Table Association

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public.id
}

# Private Route Table Association

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private.id
}