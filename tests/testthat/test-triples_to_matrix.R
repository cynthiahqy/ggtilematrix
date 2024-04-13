test_that("round trip conversion between triples and matrix returns identical objects", {

  matrix <- triples$blx_tbl |>
    triples_to_matrix(from,to,weighted)
  return_triples <- matrix |>
    triples_from_matrix("from", "to", "weighted")

  expect_equal(triples$blx_tbl, return_triples)
})
