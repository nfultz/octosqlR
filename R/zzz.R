#' @importFrom utils packageVersion download.file
.onLoad <- function(libname, pkgname) {

  
    version <- packageVersion(pkgname)[1,1:3] # drop internal releases eg 1.1.0-1 -> 1.1.0
  
    ## path to the binary
    file <- "octosql-linux"
    path <- file.path(system.file(package = pkgname), file)
    
    ## check if the jar is available and install if needed (on first load)
    if (!file.exists(path)) {

        url <- sprintf('https://github.com/cube2222/octosql/releases/download/v%s/octosql-linux', version)

        ## download the jar file from AWS
        try(download.file(url = url, destfile = path, mode = 'wb'),
            silent = TRUE)
        
        system(sprintf("chmod +x %s", path))

    }

}

.onAttach <- function(libname, pkgname) {
  ## path to the JDBC driver
  file <- "octosql-linux"
  path <- system.file(file, package = pkgname)
  
  ## check if the jar is available and install if needed (on first load)
  if (!file.exists(path)) {
    warning("Not found!?")
  }
}
