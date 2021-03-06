context("EQ-5D-Y")

test_that("EQ-5D-Y Slovenia gives correct answer", {
  expect_equal(eq5dy(c(MO=1,SC=1,UA=1,PD=1,AD=1), "Slovenia"), 1)
  expect_equal(eq5dy(c(MO=1,SC=1,UA=1,PD=1,AD=2), "Slovenia"), 0.883)
  expect_equal(eq5dy(c(MO=1,SC=2,UA=3,PD=2,AD=1), "Slovenia"), 0.469, tolerance = .0011)
  expect_equal(eq5dy(c(MO=2,SC=1,UA=2,PD=1,AD=2), "Slovenia"), 0.694)
  expect_equal(eq5dy(c(MO=2,SC=2,UA=2,PD=2,AD=2), "Slovenia"), 0.485, tolerance = .0011)
  expect_equal(eq5dy(c(MO=2,SC=3,UA=2,PD=3,AD=2), "Slovenia"), 0.010)
  expect_equal(eq5dy(c(MO=3,SC=1,UA=1,PD=3,AD=3), "Slovenia"), -0.148)
  expect_equal(eq5dy(c(MO=3,SC=3,UA=3,PD=2,AD=2), "Slovenia"), -0.128, tolerance = .0011)
  expect_equal(eq5dy(c(MO=3,SC=3,UA=3,PD=3,AD=3), "Slovenia"), -0.691)
})

test_that("EQ-5D-Y Japan gives correct answer", {
  expect_equal(eq5dy(c(MO=1,SC=1,UA=1,PD=1,AD=1), "Japan"), 1)
  expect_equal(eq5dy(c(MO=1,SC=2,UA=1,PD=1,AD=1), "Japan"), 0.957)
  expect_equal(eq5dy(c(MO=2,SC=2,UA=2,PD=2,AD=2), "Japan"), 0.753)
  expect_equal(eq5dy(c(MO=3,SC=3,UA=3,PD=3,AD=3), "Japan"), 0.288, tolerance = .0011)
})
  
context("EQ-5D-Y Incorrect params")

test_that("EQ-5D-Y throws error for incorrect parameters", {
  expect_error(eq5dy(c(MO=1,SC=2,UA=5,PD=2,AD=1), "Slovenia"))
  expect_error(eq5dy(c(M0=1,SC=2,UA=5,PD=2,AD=1), "Slovenia"))
  expect_error(eq5dy(c(MO=1,SC=2,UA=3,PD=2,AD=1), "Liechtenstein"))
})