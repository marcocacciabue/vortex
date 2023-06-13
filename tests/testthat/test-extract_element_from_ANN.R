library(voRtex)
file <- system.file("extdata", "annotated.vcf", package = "voRtex", mustWork = TRUE)
vcf<- VariantAnnotation::readVcf(file)
Annotation<-extract_element_from_ANN(vcf_data=vcf, index=2)
Annotation_Impact<-extract_element_from_ANN(vcf_data=vcf,index=3)

expect_annotation<-c("upstream_gene_variant", "upstream_gene_variant", "missense_variant" )
expect_annotation_impact<-c("MODIFIER", "MODIFIER", "MODERATE")

test_that("Checks the elements from Annotation", {
  expect_equal(Annotation[1:3],expect_annotation)
  expect_equal(Annotation_Impact[1:3],expect_annotation_impact)
})

