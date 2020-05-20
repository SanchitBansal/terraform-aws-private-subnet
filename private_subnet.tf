
# Resource to create  private subnet

resource "aws_subnet" "private" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${element(var.private_subnets, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  count             = "${length(var.private_subnets)}"

  tags {
    Name         = "${format("%s-%s-private-%s", var.environment, var.name, element(split("-", element(var.availability_zones, count.index)),2))}"
    role         = "${var.name}"
    az           = "${element(var.availability_zones, count.index)}"
    environment  = "${var.environment}"
    organization = "${var.organization}"
    businessunit = "${var.businessunit}"
  }
}

#Resource to create route tables

resource "aws_route_table" "private" {
  vpc_id = "${var.vpc_id}"
  count  = "${length(var.private_subnets)}"

  tags {
    Name         = "${format("%s-%s-rt-private-%s", var.environment, var.name, element(split("-", element(var.availability_zones, count.index)),2))}"
    role         = "${var.name}"
    az           = "${element(var.availability_zones, count.index)}"
    environment  = "${var.environment}"
    organization = "${var.organization}"
    businessunit = "${var.businessunit}"
  }
}

# Resource to assosiate route tables to subnets

resource "aws_route_table_association" "private" {
  subnet_id      = "${aws_subnet.private.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.*.id[count.index]}"
  count          = "${length(var.private_subnets)}"

}

# Resource to create a routing table entry (a route) for natgateway

resource "aws_route" "nat_gateway" {
  route_table_id         = "${aws_route_table.private.*.id[count.index]}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(var.nat_gateway_ids, count.index)}"
  count                  = "${var.nat_gateway_required == "true" ? length(var.private_subnets) : 0}"

}

# Resource to create NACL

resource "aws_network_acl" "private" {
  vpc_id     = "${var.vpc_id}"
  subnet_ids = ["${aws_subnet.private.*.id}"]
  egress     = "${var.private_network_acl_egress}"
  ingress    = "${var.private_network_acl_ingress}"

  tags {
    Name         = "${format("%s-acl-%s", var.environment, var.name)}"
    environment  = "${var.environment}"
    role         = "${var.name}"
    organization = "${var.organization}"
    businessunit = "${var.businessunit}"
  }
}
