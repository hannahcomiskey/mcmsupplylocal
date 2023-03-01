#' Get posterior samples of P from r and z variables of JAGS model
#' @name get_P_samps
#' @param main_path String. Path where you have set your model results to be saved to.
#' @param r R variable from the JAGS output
#' @param z Z variable from the JAGS output
#' @return Saved samples for public, commercial medical and other supply shares.

get_P_samps <- function(main_path, z, r) {
  P_public <- 1/(1+exp(-(z)))
  saveRDS(P_public, paste0(main_path,"P_public.RDS"))   ## Estimating all the Categories here (including total private)

  P_CM <- (1/(1+exp(-(r))))*(1-P_public)
  saveRDS(P_CM, paste0(main_path,"P_CM.RDS"))

  P_other <- (1-P_public) - P_CM
  saveRDS(P_other, paste0(main_path,"P_other.RDS"))

  return(list(P_public = P_public,
              P_CM = P_CM,
              P_other = P_other))
}
