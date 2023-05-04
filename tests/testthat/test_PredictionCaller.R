# library("ranger")
library("vortex")


file_path<-system.file("extdata","KY404934.1.fasta",package="vortex")

sequence<-ape::read.FASTA(file_path,type = "DNA")

NormalizedData<-Kcounter(SequenceData=sequence,model=FMDV_model)

calling_null<-ranger::predictions(FMDV_model)


PredictedData <- PredictionCaller(NormalizedData=NormalizedData,model=FMDV_model)


test_that("A dataframe is produced with the corresponding results ", {
  expect_true(is.data.frame(PredictedData))
  expect_true(length(colnames(PredictedData))==8)
  expect_true("Label" %in% colnames(PredictedData))

})

test_that("The number of results in dataframe is equal to number of test sequences", {
  expect_true(length(sequence)==length(PredictedData$Label))

})



