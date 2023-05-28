file <- system.file("extdata", "variant_file.vcf", package = "voRtex", mustWork = TRUE)
file2 <- system.file("extdata", "variant_file_2.vcf", package = "voRtex", mustWork = TRUE)
vcf_list <- list(
  file,
  file2
)
listavcf_salida <- list()
for (i in 1:length(vcf_list)) {
  listavcf_salida[[i]] <- VariantAnnotation::readVcf(vcf_list[[i]])
}
BigData_Test <- DataFrameBinder(listavcf_salida)
Expected_FirstRowsDataFrame <- data.frame(
  Position = c(10, 45, 94),
  DP = c(118, 1243, 6476),
  AF = c(0.09322, 0.010459, 0.033663)
)
Expected_LastRowsDataFrame <- data.frame(
  Position = c(8165, 8166, 8169),
  DP = c(1761, 1750, 1444),
  AF = c(0.019875, 0.019429, 0.023546)
)

test_that("BigData has 3 columns", {
  expect_equal(ncol(BigData_Test), 3)
  expect_equal(nrow(BigData_Test), 176)
  expect_equal(BigData_Test[1:3, ], Expected_FirstRowsDataFrame)
  expect_equal(BigData_Test[174:176, 1], Expected_LastRowsDataFrame[, 1])
})
