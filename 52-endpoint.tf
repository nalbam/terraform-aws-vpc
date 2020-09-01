# S3 Endpoint
resource "aws_vpc_endpoint" "s3_endpoint" {
  count = var.create_vpc ? 1 : 0

  vpc_id       = local.vpc_id
  service_name = format("com.amazonaws.%s.%s", var.region, "s3")

  tags = merge(
    {
      Name = format("%s-%s", var.name, "s3")
    },
    var.tags,
  )
}

# Add vpc endpoint to route table of private subnet
resource "aws_vpc_endpoint_route_table_association" "s3_endpoint_routetable" {
  count = var.create_vpc ? local.nat_gateway_count : 0

  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint[0].id
  route_table_id  = aws_route_table.private[count.index].id
}

# DynamoDB Endpoint
resource "aws_vpc_endpoint" "dynamodb_endpoint" {
  count = var.create_vpc ? 1 : 0

  vpc_id       = local.vpc_id
  service_name = format("com.amazonaws.%s.%s", var.region, "dynamodb")

  tags = merge(
    {
      Name = format("%s-%s", var.name, "dynamodb")
    },
    var.tags,
  )
}

# Add vpc endpoint to route table of private subnet
resource "aws_vpc_endpoint_route_table_association" "dynamodb_endpoint_routetable" {
  count = var.create_vpc ? local.nat_gateway_count : 0

  vpc_endpoint_id = aws_vpc_endpoint.dynamodb_endpoint[0].id
  route_table_id  = aws_route_table.private[count.index].id
}
