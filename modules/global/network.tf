output standard_private_subnet_tags {
    value = tomap({
    "mikesarfaty.com/standard_private_subnet" = "true"
  })
}

output standard_public_subnet_tags {
  value = tomap({
    "mikesarfaty.com/standard_public_subnet" = "true"
  })
}