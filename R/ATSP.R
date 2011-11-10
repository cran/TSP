#######################################################################
# TSP - Traveling Salesperson Problem 
# Copyrigth (C) 2011 Michael Hahsler and Kurt Hornik
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.



## create a (asymmetric) ATSP problem
ATSP <- function(x, labels = NULL) {
    if(inherits(x, "ATSP")) return(x)

    atsp <- as.ATSP(x)
    
    if(!is.null(labels)) dimnames(atsp) <- list(labels, labels)
    atsp
}

as.ATSP <- function(object) UseMethod("as.ATSP")
as.ATSP.matrix <- function(object){
    .isSquare <- function(x) (dim(x)[1] == dim(x)[2])

    if(!.isSquare(object)) stop("ATSP requires a square matrix")

    ## check for NAs
    if(any(is.nan(object))) stop(paste(sQuote("NAs"), "not supported"))
    
    ## make sure we have labels
    if(is.null(dimnames(object))) 
        dimnames(object) <- list(1:dim(object)[1], 1: dim(object)[1])
    if(is.null(colnames(object)))  colnames(object) <- rownames(object)
    if(is.null(rownames(object)))  rownames(object) <- colnames(object)

    class(object) <- c("ATSP", class(object))
    object
}

as.ATSP.dist <- function(object){
    method <- attr(object, "method")
    object <- as.ATSP(as.matrix(object)) 
    attr(object, "method") <- method
    object
}


## print
print.ATSP <- function(x, ...) {
    method <- attr(x, "method")
    if(is.null(method)) method <- "unknown"
    
    cat("object of class", sQuote(class(x)[1]), " (asymmetric TSP) \n")
    cat(n_of_cities(x), "cities", 
        paste("(distance ", sQuote(method),")", sep=""), "\n")
}


## number of cities
n_of_cities.ATSP <- function(x) nrow(x)

## labels
labels.ATSP <- function(object, ...) dimnames(object)[[1]]

## image
image.ATSP <- function(x, order, col = gray.colors(64), ...) {
    p <- n_of_cities(x)
    if(missing(order)) order <- 1:p
    
    image.default(1:p, 1:p, x[order, order], col = col, ...)
}

## coerce to matrix
as.matrix.ATSP <- function(x, ...){
    unclass(x)
}
