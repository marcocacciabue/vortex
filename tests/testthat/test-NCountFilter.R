library(Biostrings)
FilePath <- system.file("extdata",
                        "renamed_all.fasta",
                        package = "vortex",
                        mustWork = TRUE)
DNASequence <- Biostrings::readDNAStringSet(FilePath)

test_that("Returns a DNAStringSet with the correct length", {
  expect_equal(length(NCountFilter(DNASequence)), 555)
})
