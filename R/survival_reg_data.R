# These functions define engines for the `survival_reg` model from parsnip.
# They are executed when this package is loaded via `.onLoad()` and modify the
# parsnip package's model environment.

# These functions are tested indirectly when the models are used. Since this
# function is executed on package startup, you can't execute them to test since
# they are already in the parsnip model database. We'll exclude them from
# coverage stats for this reason.

# nocov

make_survival_reg_survival <- function() {

  parsnip::set_model_engine("survival_reg", mode = "censored regression", eng = "survival")
  parsnip::set_dependency("survival_reg", eng = "survival", pkg = "survival")
  parsnip::set_dependency("survival_reg", eng = "survival", pkg = "censored")

  parsnip::set_model_arg(
    model = "survival_reg",
    eng = "survival",
    parsnip = "dist",
    original = "dist",
    func = list(pkg = "dials", fun = "dist"),
    has_submodel = FALSE
  )

  parsnip::set_fit(
    model = "survival_reg",
    eng = "survival",
    mode = "censored regression",
    value = list(
      interface = "formula",
      protect = c("formula", "data", "weights"),
      func = c(pkg = "survival", fun = "survreg"),
      defaults = list(model = TRUE)
    )
  )

  parsnip::set_encoding(
    model = "survival_reg",
    eng = "survival",
    mode = "censored regression",
    options = list(
      predictor_indicators = "none",
      compute_intercept = FALSE,
      remove_intercept = FALSE,
      allow_sparse_x = FALSE
    )
  )

  parsnip::set_pred(
    model = "survival_reg",
    eng = "survival",
    mode = "censored regression",
    type = "time",
    value = list(
      pre = NULL,
      post = NULL,
      func = c(fun = "predict"),
      args =
        list(
          object = expr(object$fit),
          newdata = expr(new_data),
          type = "response"
        )
    )
  )

  parsnip::set_pred(
    model = "survival_reg",
    eng = "survival",
    mode = "censored regression",
    type = "quantile",
    value = list(
      pre = NULL,
      post = survreg_quant,
      func = c(fun = "predict"),
      args =
        list(
          object = expr(object$fit),
          newdata = expr(new_data),
          type = "quantile",
          p = expr(quantile)
        )
    )
  )

  parsnip::set_pred(
    model = "survival_reg",
    eng = "survival",
    mode = "censored regression",
    type = "hazard",
    value = list(
      pre = NULL,
      post = NULL,
      func = c(pkg = "censored", fun = "survreg_hazard_probs"),
      args =
        list(
          object = expr(object$fit),
          new_data = expr(new_data)
        )
    )
  )

  parsnip::set_pred(
    model = "survival_reg",
    eng = "survival",
    mode = "censored regression",
    type = "survival",
    value = list(
      pre = NULL,
      post = NULL,
      func = c(pkg = "censored", fun = "survreg_survival_probs"),
      args =
        list(
          object = expr(object$fit),
          new_data = expr(new_data)
        )
    )
  )

}

make_survival_reg_flexsurv <- function() {

  parsnip::set_model_engine("survival_reg", mode = "censored regression", eng = "flexsurv")
  parsnip::set_dependency("survival_reg", eng = "flexsurv", pkg = "flexsurv")
  parsnip::set_dependency("survival_reg", eng = "flexsurv", pkg = "survival")
  parsnip::set_dependency("survival_reg", eng = "flexsurv", pkg = "censored")

  parsnip::set_model_arg(
    model = "survival_reg",
    eng = "flexsurv",
    parsnip = "dist",
    original = "dist",
    func = list(pkg = "dials", fun = "dist"),
    has_submodel = FALSE
  )

  parsnip::set_fit(
    model = "survival_reg",
    eng = "flexsurv",
    mode = "censored regression",
    value = list(
      interface = "formula",
      protect = c("formula", "data", "weights"),
      func = c(pkg = "flexsurv", fun = "flexsurvreg"),
      defaults = list()
    )
  )

  parsnip::set_encoding(
    model = "survival_reg",
    eng = "flexsurv",
    mode = "censored regression",
    options = list(
      predictor_indicators = "none",
      compute_intercept = FALSE,
      remove_intercept = FALSE,
      allow_sparse_x = FALSE
    )
  )

  parsnip::set_pred(
    model = "survival_reg",
    eng = "flexsurv",
    mode = "censored regression",
    type = "time",
    value = list(
      pre = NULL,
      post = flexsurv_mean,
      func = c(fun = "summary"),
      args =
        list(
          object = expr(object$fit),
          newdata = expr(new_data),
          type = "mean"
        )
    )
  )

  parsnip::set_pred(
    model = "survival_reg",
    eng = "flexsurv",
    mode = "censored regression",
    type = "quantile",
    value = list(
      pre = NULL,
      post = flexsurv_quant,
      func = c(fun = "summary"),
      args =
        list(
          object = expr(object$fit),
          newdata = expr(new_data),
          type = "quantile",
          quantiles = expr(quantile)
        )
    )
  )

  parsnip::set_pred(
    model = "survival_reg",
    eng = "flexsurv",
    mode = "censored regression",
    type = "hazard",
    value = list(
      pre = NULL,
      post = NULL,
      func = c(pkg = "censored", fun = "flexsurv_probs"),
      args =
        list(
          object = expr(object$fit),
          new_data = expr(new_data),
          type = "hazard"
        )
    )
  )

  parsnip::set_pred(
    model = "survival_reg",
    eng = "flexsurv",
    mode = "censored regression",
    type = "survival",
    value = list(
      pre = NULL,
      post = NULL,
      func = c(pkg = "censored", fun = "flexsurv_probs"),
      args =
        list(
          object = expr(object$fit),
          new_data = expr(new_data),
          type = "survival"
        )
    )
  )
}

# nocov end
