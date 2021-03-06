if(getOption("test_mplus")){
    test_that("Mplus can handle ANALYSIS = 'starts = .....;'", {
        iris_sample <- iris[c(1:4, 51:54, 101:104), ] # to make example run more quickly
        # With an argument passed on to mplusModeler, returns a warning
        res <- estimate_profiles(iris_sample[, c("Sepal.Length", "Sepal.Width",
                                                 "Petal.Length")],
                                 3,
                                 package = "mplus",
                                 ANALYSIS = "starts = 15,3;",
                                 keepfiles = TRUE)
        file_contents <- readLines("model_1_class_3.inp")
        expect_true(any(grepl("starts = 15,3;", file_contents)))

        expect_equal(res$model_1_class_3$model$summaries$BLRT_KM1AnalysisStarts, 15)
        expect_equal(res$model_1_class_3$model$summaries$BLRT_KM1AnalysisFinal, 3)

    })

    test_that("Illegal arguments are blocked in call to estimate_profiles_mplus2()", {
        expect_error(estimate_profiles(iris[,1:4],
                                 3,
                                 package = "mplus",
                                 ANALYSIS = "starts = 15,3;",
                                 keepfiles = TRUE,
                                 hug = "bla"))

        expect_error(estimate_profiles(iris[,1:4],
                                 3,
                                 package = "mplus",
                                 ANALYSIS = "starts = 15,3;",
                                 keepfiles = TRUE,
                                 usevariables = "bla"))
    })



}
