

test_that("ObjectControl works fine", {
    expect_error(objectControl())
    object<-NULL
    expect_error(objectControl(object))
    object<-"test_string_different_to_CollapsedVCF"
    expect_error(objectControl(object))
})
