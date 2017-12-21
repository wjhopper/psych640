library(rprojroot)
options(stringsAsFactors = FALSE)

extdata_path <- find_root_file("inst", "extdata",
                               criterion = is_rstudio_project)
files <- list.files(extdata_path, pattern = ".*\\.csv", full.names = TRUE)

for (f in files) {
  x <- read.csv(file = f)
  var_name <- tools::file_path_sans_ext(basename(f))
  assign(var_name, x)
  eval(substitute(devtools::use_data(a, overwrite = TRUE),
                  list(a = as.name(var_name)))
       )
}

