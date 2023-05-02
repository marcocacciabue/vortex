FilePath <- system.file("extdata",
                        "SRR12664421_full_coverage.bed",
                        package = "vortex",
                        mustWork = TRUE)

OGDataFrame <- read.table(FilePath,
                          col.names = c("reference","startpos","endpos","nreads"))

test_that("The new dataframe has the 5 columns", {
  expect_equal(colnames(NreadFilter(OGDataFrame)[[1]]), c("reference","startpos","endpos","nreads","Width"))
})

test_that("Returns the correct percentage", {
  expect_equal(NreadFilter(OGDataFrame)[[2]], 96.24665)
})

