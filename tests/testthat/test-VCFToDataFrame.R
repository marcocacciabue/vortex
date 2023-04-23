file <- system.file("extdata", "variant_file.vcf", package = "vortex", mustWork = TRUE)
vcf_data <- VariantAnnotation::readVcf(file)
VCFToDataFrame_test <- VCFToDataFrame(vcf_data)
Expected_DataFrame <- data.frame(
  Position = c(10, 45, 94),
  DP = c(118, 1243, 6476),
  AF = c(0.09322, 0.010459, 0.033663)
)

test_that("Position() gives expected values", {
  expect_equal(VCFToDataFrame_test[1:3, ], Expected_DataFrame)
  expect_equal(is(VCFToDataFrame_test)[1], "data.frame")
})
