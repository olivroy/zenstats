#' Scrap statistics from a Zenodo deposit
#'
#' @param deposit_id numeric. Zenodo deposit id.
#' @param all_versions_only logical. If `TRUE`, return only the results for all versions.
#'
#' @return a tibble
#' @export
#'
#' @examples
#' scrap_stats(10013255)
#'
scrap_stats <- function(deposit_id, all_versions_only = FALSE){
  # Assertions
  checkmate::assert_number(x = deposit_id)
  checkmate::assert_logical(x = all_versions_only)

  # Deposit URL
  url <- paste0("https://zenodo.org/records/", deposit_id)

  # Read html
  zen_web <- rvest::read_html(url)

  # Scrap statistics table
  zen_stats <- zen_web |>
    rvest::html_element(xpath = '//*[@id="record-statistics"]') |>
    rvest::html_table()

  # Prepare table
  res <- tibble::tibble(
    deposit = rep(deposit_id, 2),
    version = c("All versions", "This version"),
    views = as.numeric(c(zen_stats[[1,2]], zen_stats[[1,3]])),
    downloads = as.numeric(c(zen_stats[[2,2]], zen_stats[[2,3]])),
    volume = rlang::parse_bytes(c(zen_stats[[3,2]], zen_stats[[3,3]])),
  )

  # Filter all versions only
  if(all_versions_only){
    res <- res[1,c(1,3:5)]
  }

  # Return
  return(res)
}
