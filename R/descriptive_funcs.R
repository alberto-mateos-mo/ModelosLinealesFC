#' Calculate descriptive statistics
#'
#' @param x A dataframe
#' @return A tibble
#' @export

basic_stats <- function(x){

  message("Calculating stats for continuous variables...")

  df <- dplyr::select(x, where(is.numeric))

  stats_list <- lapply(df,
                       function(x){
                         list(obs = length(x),
                              valid = sum(!is.na(x)),
                              nas = sum(is.na(x)),
                              media = mean(x, na.rm = TRUE),
                              desv_est = sd(x, na.rm = TRUE),
                              skewness = moments::skewness(x, na.rm = TRUE),
                              kurtosis = moments::kurtosis(x, na.rm = TRUE))
                       })

  stats_list <- Filter(Negate(is.null), stats_list)

  stats_df <- dplyr::tibble(variable = names(stats_list), dplyr::bind_rows(stats_list))

  return(stats_df)

}

#' Create frequency plots
#'
#' @param x A dataframe
#' @return Invisbly returns a list with ggplot objects
#' @export

frequency_plots <- function(x){

  message("Plotting frequency plots for discrete variables...")

  df <- dplyr::select(x, !where(is.numeric))

  plots_list <- lapply(df,
                       function(x){
                         ggplot2::ggplot(df, ggplot2::aes(x))+
                           ggplot2::geom_bar()+
                           ggplot2::labs(x = "")
                       })

  plots_list <- Filter(Negate(is.null), plots_list)

  plot(cowplot::plot_grid(plotlist = plots_list, labels = names(plots_list), label_size = 10))

  invisible(plots_list)

}

#' Calculate correlations
#'
#' @param x A dataframe
#' @param dependent optional, a common variable to calculate correlations
#' @export

correlations <- function(x, dependent = NULL){

  if(!is.null(dependent)){
    message(paste("Calculating correlations to", dependent, "as common dependent variable..."))
    dep <- unlist(dplyr::select(x, dplyr::matches(dependent)))
    df <- dplyr::select(x, where(is.numeric)) %>% dplyr::select(-dplyr::matches(dependent))
    cors <- lapply(df, function(x){
      cor(dep, x, use = "complete.obs")
    })

    g <- ggplot2::ggplot(data.frame(x = names(cors), y = unlist(cors)))+
      ggplot2::geom_col(ggplot2::aes(x = x, y = y))+
      ggplot2::labs(x = "", y = paste("Correlation with", dependent))+
      ggplot2::theme_light()

    plot(g)

    invisible(cors)

  }
  if(is.null(dependent)){
    message("Calculating pairwise correlations...")
    cors <- cor(dplyr::select(x, where(is.numeric)), use = "complete.obs")
    corrplot::corrplot(cors, method = "number", type = "upper", diag = FALSE)

    invisible(cors)

  }

}

