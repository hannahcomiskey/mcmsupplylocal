#' Run the jags model for estimating the proportion of modern contraceptive methods supplied by the public & private Sectors using a Bayesian hierarchical penalized spline model
#' @name run_subnational_jags_model
#' @param jagsdata The inputs for the JAGS model
#' @param jagsparams The parameters of the JAGS model you wish to review
#' @param local TRUE/FALSE. Default is FALSE. local=FALSE retrieves the data for all subnational provinces across all countries. local=TRUE retrieves data for only one country.
#' @param spatial TRUE/FALSE. Default is FALSE. spatial=FALSE retrieves the data for all subnational provinces across all countries without GPS information. spatial=TRUE retrieves for data for countries with GPS information as well as FP source data.
#' @param mycountry The country name of interest in a local run. You must have local=TRUE for this functionality. A list of possible countries available found in data/mycountries.rda.
#' @return returns the jags model object
#' importFrom("stats", "cor", "filter", "lag")
#' @import R2jags runjags tidyverse tidybayes
#' @export

run_subnational_jags_model <- function(jagsdata, jagsparams, local=FALSE, spatial=FALSE,  mycountry) {
  if(local_run==TRUE) {
    mod <- jags.parallel(data=jagsdata,
                         parameters.to.save=jagsparams,
                         model.file = "model/local_model_run.txt",
                         n.iter = 80000,
                         n.burnin = 10000,
                         n.thin = 35)
    saveRDS(mod, paste0("results/mod_",mycountry,"_results.RDS"))
  } else {
    mod <- jags.parallel(data=jagsdata,
                         parameters.to.save=jagsparams,
                         model.file = "model/global_model_run.txt",
                         n.iter = 150000,
                         n.burnin = 10000,
                         n.thin = 70)
    saveRDS(mod, "results/mod_global_results.RDS")
  }
  return(mod)
}
