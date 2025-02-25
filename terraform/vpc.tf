resource "aws_vpc" "main" {
  count = local.env != "default" ? 1 : 0

  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "gros-main-vpc"
  }
}

resource "aws_subnet" "public" {

  count = local.env != "default" ? 3 : 0

  vpc_id                  = aws_vpc.main[0].id
  cidr_block              = cidrsubnet(aws_vpc.main[0].cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name                     = "gros-public-subnet-${count.index}"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "private" {
  count = local.env != "default" ? 3 : 0

  vpc_id            = aws_vpc.main[0].id
  cidr_block        = cidrsubnet(aws_vpc.main[0].cidr_block, 8, count.index + 3)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name                              = "gros-private-subnet-${count.index}"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_internet_gateway" "main" {
  count = local.env != "default" ? 1 : 0

  vpc_id = aws_vpc.main[0].id

  tags = {
    Name = "gros-main-igw"
  }
}

resource "aws_route_table" "public" {
  count = local.env != "default" ? 1 : 0

  vpc_id = aws_vpc.main[0].id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main[0].id
  }

  tags = {
    Name = "gros-public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  count = local.env != "default" ? 3 : 0

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public[0].id
}

resource "aws_eip" "nat" {
  count = local.env != "default" ? 3 : 0

}

resource "aws_nat_gateway" "main" {
  count = local.env != "default" ? 3 : 0


  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = element(aws_subnet.public.*.id, count.index)

  tags = {
    Name = "gros-main-nat-gateway-${count.index}"
  }
}

resource "aws_route_table" "private" {
  count = local.env != "default" ? 3 : 0


  vpc_id = aws_vpc.main[0].id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.main.*.id, count.index)
  }

  tags = {
    Name = "gros-private-route-table-${count.index}"
  }
}

resource "aws_route_table_association" "private" {
  count          = local.env != "default" ? 3 : 0
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

data "aws_availability_zones" "available" {}
