output "available_az" {
  value = data.aws_availability_zones.available_az.names
}

output "aws_vpc" {
  value = aws_vpc.vpc
}

output "aws_private_subnets" {
  value = aws_subnet.private-subnet

}

output "public_subnets_ids" {
  value = aws_subnet.public-subnet[*].id
}

output "rds_public_subnets_ids" {
  value = [
    aws_subnet.public-subnet[0].id,
    aws_subnet.public-subnet[1].id,
    aws_subnet.public-subnet[2].id
  ]
}

output "available_azs" {
  value = data.aws_availability_zones.available_az
}

output "rds_available_az" {
  value = [
    data.aws_availability_zones.available_az.names[0],
    data.aws_availability_zones.available_az.names[1],
    data.aws_availability_zones.available_az.names[2]
  ]
}