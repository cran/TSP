## create a TSP problem
TSP <- function(x, labels = NULL) {
    if(inherits(x, "TSP")) return(x)
    x <- as.TSP(x)
    if(!is.null(labels)) attr(x, "Labels") <- labels
    x
}

## coercion
as.TSP <- function(object) UseMethod("as.TSP")
as.TSP.dist <- function(object){
    ## make sure we have a upper triangle matrix w/o diagonal
    object <- as.dist(object, diag = FALSE, upper = FALSE)
    
    ## make sure we have labels
    if(is.null(attr(object, "Lables"))) 
    attr(object, "Lables") <- c(1:n_of_cities(object))

    if(any(is.nan(object))) stop(paste(sQuote("NAs"), "not supported"))
    class(object) <- c("TSP", class(object))
    object
}

as.TSP.matrix <- function(object){
    if(!isSymmetric(object)) stop("TSP requires a symmetric matrix")

    method <- attr(object, "method")
    object <- as.dist(object, diag = FALSE, upper = FALSE)
    attr(object, "method") <- method
    
    ## make sure we have labels
    if(is.null(attr(object, "Lables"))) 
    attr(object, "Lables") <- c(1:n_of_cities(object))

    if(any(is.nan(object))) stop(paste(sQuote("NAs"), "not supported"))
    class(object) <- c("TSP", class(object))
    object
}


## print
print.TSP <- function(x, ...) {
    method <- attr(x, "method")
    if(is.null(method)) method <- "unknown"
    
    cat("object of class", sQuote(class(x)[1]), "\n")
    cat(n_of_cities(x), "cities", 
        paste("(distance ", sQuote(method),")", sep=""), "\n")
}


## number of cities
n_of_cities.TSP <- function(x) attr(x, "Size")

## generic for n_of_cities
n_of_cities <- function(x) UseMethod("n_of_cities")
n_of_cities.default <- n_of_cities.TSP

## labels
labels.TSP <- function(object, ...) attr(object, "Labels")

## image
image.TSP <- function(x, order, col = gray.colors(64), ...) {
    p <- n_of_cities(x)
    if(missing(order)) order <- 1:p
    
    image.default(1:p, 1:p, as.matrix(x)[order, order], col = col, ...)
}
