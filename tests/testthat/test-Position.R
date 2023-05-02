file <- system.file("extdata", "variant_file.vcf", package = "vortex", mustWork = TRUE)
vcf_data <- VariantAnnotation::readVcf(file)
Position_test <- Position(vcf_data)

test_that("Position() gives expected values", {
  expect_equal(Position_test[1:3], c(10, 45, 94))
})

test_that("Position() gives error detected by objectControl", {
  expect_error(Position(file))
})
