

file <- system.file("extdata", "SRR12664421_masked.fasta", package = "vortex", mustWork = TRUE)
DNA_stringset <- Biostrings::readDNAStringSet(file)
header <- name_from_string(file,verbose = FALSE)
updated_fasta<- update_fasta_header(
  DNA_stringset,
  header
)

test_that("update_fasta_header works fine", {
  expect_equal(names(updated_fasta),"SRR12664421")
})


test_that("update_fasta_header throws error", {
  expect_error(update_fasta_header())
})





