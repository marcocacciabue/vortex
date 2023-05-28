library(Biostrings)
FilePath <- system.file("extdata",
                        "renamed_all.fasta",
                        package = "voRtex",
                        mustWork = TRUE)
DNASequence <- Biostrings::readDNAStringSet(FilePath)

test_that("Returns a DNAStringSet with the correct length", {
  expect_equal(length(NCountFilter(DNASequence)), 555)
})
