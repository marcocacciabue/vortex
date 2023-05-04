library(Biostrings)
FilePath <- system.file("extdata",
                        "renamed_all.fasta",
                        package = "vortex",
                        mustWork = TRUE)
DNASequence <- Biostrings::readDNAStringSet(FilePath)

test_that("Returns a DNAStringSet with the correct length", {
  expect_equal(length(NCountFilter(DNASequence)), 555)
})

test_that("If the DNAStringset has no lenght returns the correct message", {
  expect_equal(NCountFilter(DNASequence,1), "No sequence passed the filter")
})
