

test_that("ObjectControl works fine", {
  testthat::expect_error()
    expect_error(objectControl())
    object<-NULL
    expect_error(objectControl(object))
    object<-"test_string_different_to_CollapsedVCF"
    expect_error(objectControl(object))
})
