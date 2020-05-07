# S3 Endpoint
resource "aws_vpc_endpoint" "s3_endpoint" {
  count = var.create_vpc ? 1 : 0

  vpc_id       = local.vpc_id
  service_name = "com.amazonaws.${var.region}.s3"

  tags = merge(
    {
      Name = format("%s", var.name)
    },
    var.tags,
  )
}

# Add vpc endpoint to route table of private subnet
resource "aws_vpc_endpoint_route_table_association" "s3_endpoint_routetable" {
  count = local.nat_gateway_count

  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint[0].id
  route_table_id  = aws_route_table.private[count.index].id
}

# DynamoDB Endpoint
resource "aws_vpc_endpoint" "dynamodb_endpoint" {
  count = var.create_vpc ? 1 : 0

  vpc_id       = local.vpc_id
  service_name = "com.amazonaws.${var.region}.dynamodb"

  tags = merge(
    {
      Name = format("%s", var.name)
    },
    var.tags,
  )
}

# Add vpc endpoint to route table of private subnet
resource "aws_vpc_endpoint_route_table_association" "dynamodb_endpoint_routetable" {
  count = local.nat_gateway_count

  vpc_endpoint_id = aws_vpc_endpoint.dynamodb_endpoint[0].id
  route_table_id  = aws_route_table.private[count.index].id
}
