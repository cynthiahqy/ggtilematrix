## --- graph triples ---

triples <- list()

triples$blx_tbl <- tibble::tribble(~from, ~to, ~weighted,
                         "BLX", "BEL", 0.5,
                         "BLX", "LUX", 0.5,
                         "E.GER", "DEU", 1,
                         "W.GER", "DEU", 1,
                         "AUS", "AUS", 1)

usethis::use_data(triples, overwrite = TRUE)

## --- matrices ---

matrices <- list()

matrices$blx_mtx <- triples$blx_tbl |>
  ggtilematrix::matrix_from_tripes(from,to,weighted)

n_rows <- 4
n_cols <- 5
n_cells <- n_rows * n_cols
unnamed_cells <- trunc(runif(n_cells)*100, 2)
unnamed_cells[runif(n_cells) > 0.5] <- NA

matrices$unnamed <- matrix(data = unnamed_cells, nrow = n_rows, ncol = n_cols)

usethis::use_data(matrices, overwrite = TRUE)


