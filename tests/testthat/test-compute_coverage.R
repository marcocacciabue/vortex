data <- read.table("Resultados/run1/coverage/SRR13776172_full_coverage.bed",
                   col.names = c("reference", "startpos", "endpos", "coverage"))
data_processed<-compute_coverage(data, 50, TRUE)
test_that("return two colums", {
  expect_equal(ncol(compute_coverage), 2)
})
