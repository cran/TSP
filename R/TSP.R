# create a TSP problem
TSP <- function(x) {
    if(inherits(x, "TSP")) return(x)
    
    # check x
    if(inherits(x, "dist")) {
        # make sure we have a upper triangle matrix w/o diagonal
        if(attr(x, "Diag") == TRUE || attr(x, "Upper") == TRUE)
        x <- as.dist(x, diag = FALSE, upper = FALSE)
    }else if(is.matrix(x) && isSymmetric(x)) {
        x <- as.dist(x, diag = FALSE, upper = FALSE)
    }else stop("TSP requires an object of class", 
        sQuote("dist"), "or a symmetric matrix")

    # check for NAs
    if(any(is.nan(x))) stop(paste(sQuote("NAs"), "not supported"))
    
    class(x) <- c("TSP", class(x))
    x
}

# print
print.TSP <- function(x, ...) {
    cat("object of class", sQuote(class(x)[1]), "\n")
    cat(n_of_cities(x), "cities", 
        paste("(distance ", sQuote(attr(x, "method")),")", sep=""), "\n")
}


# number of cities
n_of_cities.TSP <- function(x) attr(x, "Size")

# generic for n_of_cities
n_of_cities <- function(x) UseMethod("n_of_cities")
n_of_cities.default <- n_of_cities.TSP

# labels
labels.TSP <- function(object, ...) attr(object, "Labels")

# image
image.TSP <- function(x, order, col = gray.colors(64), ...) {
    p <- n_of_cities(x)
    if(missing(order)) order <- 1:p
    
    image.default(1:p, 1:p, as.matrix(x)[order, order], col = col, ...)
}

