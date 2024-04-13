if (FALSE){
  library(ggplot2)

  case_outgoing <- function(weights){
    dplyr::case_when(
      weights == 1 ~ "one-to-one",
      weights < 1 ~ "one-to-many",
      weights == 0 ~ "",
      is.na(weights) ~ "",
      .default = "invalid weight!"
    )
  }

  ggdata_xmap <- triples$blx_tbl |>
    tidyr::complete(from,to) |>
    dplyr::mutate(src_case = case_outgoing(weighted))

  ggdata_mtx <- matrices$unnamed |>
    ggtilematrix::matrix_to_triples("from", "to", "weighted", drop_na = FALSE)

  matrices$unnamed |>
    gg_tilematrix.matrix()

  ggdata |>
    ggplot(aes(x=to, y=from)) +
    geom_tile(aes(fill=src_case), col="grey") +
    scale_y_discrete(limits=rev) +
    scale_fill_brewer() +
    coord_fixed()  +
    labs(x = element_blank(), y = element_blank()) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    ggtitle("triples as matrix")
}

# TODO: create base theme for gg_tilematrix() based on theme_bw or theme_minimal
# - [ ] move axes labels to left & top
# - [ ] default background

# TODO: create S3 generic function for `gg_tilematrix()`
# OR restrict to data frame input?

#' Plot a matrix as a ggplot2 object
#'
#' @param .matrix A matrix to plot
#' @param .geom
#' @param .scale_coord
#' @param .theme
#' @param .layers
#'
#' @return
#' @export
#'
#' @examples
#' matrices$unnamed |>
#'   gg_tilematrix.matrix()
#'
#' @importFrom ggplot2 aes
gg_tilematrix.matrix <- function(.matrix,
                                 .geom = list(
                                   geom_tile(color="pink",
                                             fill = "blue"),
                                   geom_text()
                                 ),
                                 .scale_coord = list(
                                   scale_y_discrete(limits=base::rev),
                                   scale_x_discrete(position = "top"),
                                   coord_fixed()
                                 ),
                                 .theme = list(theme_bw()),
                                 .layers = list(
                                   labs(x = NULL, y = NULL)
                                 )){

  x_var <- formals(matrix_to_triples)$x_names_to
  y_var <- formals(matrix_to_triples)$y_names_to
  label_var <- formals(matrix_to_triples)$values_to

  .matrix |>
    matrix_to_triples(drop_na = FALSE) |>
    ggplot(aes(x=.data[[x_var]],
               y=.data[[y_var]],
               label=.data[[label_var]])) +
    .geom +
    .scale_coord +
    .theme +
    .layers
}
