
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

#' Athena connection class.
#'
#' Class which represents the Athena connections.
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

#' Authentication credentials are read from the DefaultAWSCredentialsProviderChain, which includes the .aws folder and
#' environment variables.
#'
#' @param drv An object created by \code{Athena()}
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
  handle <- pipe(sprintf("~/bin/octosql '%s' -c %s -o csv", statement, conn@config))
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
#> [1] "dbClearResult"


########################3

#' Retrieve records from Kazam query
#' @export
#' @importFrom DBI dbFetch
setMethod("dbFetch", "OctoSQLResult", function(res, n = -1, ...) {
  read.csv(res@handle)
})
#> [1] "dbFetch"

# (optionally)


#' @export
#' @importFrom DBI dbHasCompleted
setMethod("dbHasCompleted", "OctoSQLResult", function(res, ...) { 
  TRUE
})
#> [1] "dbHasCompleted"

