
#' OctoSQL driver class.
#'
#' @keywords internal
#' @export
#' @import methods
#' @importClassesFrom DBI DBIDriver
setClass("OctoSQLDriver", contains = "DBIDriver")


#' OctoSQL DBI wrapper
#'
#' @export
OctoSQL <- function() {
  new("OctoSQLDriver")
}

#' OctoSQL connection class.
#'
#' Class which represents the OctoSQL connections.
#'
#' @export
#' @importClassesFrom DBI DBIConnection
#' @keywords internal
setClass("OctoSQLConnection",
  contains = "DBIConnection",
  slots = list(
    config = "character"
  )
)

#' Authentication credentials are not read in R, but a configuration file path
#' is passed to octosql.
#'
#' @param drv An object created by \code{OctoSQL()}
#' @param config path to config file
#' @param ... Other options
#' @rdname OctoSQL
#' @export
#' @examples
#' \dontrun{
#' }
#' @importFrom DBI dbConnect
setMethod("dbConnect", "OctoSQLDriver",
          function(drv, config, ...) {

  new("OctoSQLConnection", config=config)
})


setOldClass("pipe")

#' OctoSQL results class.
#' 
#' @keywords internal
#' @export
setClass("OctoSQLResult", 
         contains = "DBIResult",
         slots = list(handle = "pipe")
)


#' Send a query to OctoSQL.
#' 
#' @export
#' @examples 
#' # This is another good place to put examples
#' @importFrom DBI dbSendQuery
setMethod("dbSendQuery", "OctoSQLConnection", function(conn, statement, ...) {
  # some code
  ## path to the binary
  file <- "octosql-linux"
  path <- file.path(system.file(package = 'octosql'), file)
  
  handle <- pipe(sprintf("%s '%s' -c %s -o csv",path, statement, conn@config))
  new("OctoSQLResult", handle=handle, ...)
})
#> [1] "dbSendQuery"


#' @export
#' @importFrom DBI dbClearResult
setMethod("dbClearResult", "OctoSQLResult", function(res, ...) {
  # free resources
  # close(res@handle)
  TRUE
})


########################3

#' Retrieve records from OctoSQL query
#' @export
#' @importFrom DBI dbFetch
setMethod("dbFetch", "OctoSQLResult", function(res, n = -1, ...) {
  read.csv(res@handle)
})


#' @export
#' @importFrom DBI dbHasCompleted
setMethod("dbHasCompleted", "OctoSQLResult", function(res, ...) { 
  TRUE
})

