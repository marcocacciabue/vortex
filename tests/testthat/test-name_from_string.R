filepath<-"./exdata/SRR12664421_masked.fasta"

test_that("Retorna el string esperado", {
  expect_equal(name_from_string(filepath),"SRR12664421")
})

test_that("Retorna error al ingrear un numerico",{
  expect_error(name_from_string(123) )
})
