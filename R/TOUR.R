TOUR <- function(x){
    if(inherits(x, "TOUR")) return(x)
    
    as.TOUR(x)
}

## coercion
as.TOUR <- function(object) UseMethod("as.TOUR")
as.TOUR.numeric <-  function(object){
    l <- labels(object)
    object <- as.integer(object)
    names(object) <- l
    as.TOUR(object)
}
as.TOUR.integer <- function(object){

    ## check tour
    if(any(object < 1) || any(object > length(object)) || any(is.na(object))) 
        stop("tour contains illegal elements.")

    if(any(duplicated(object))) stop("tour indices are not unique.")

    class(object) <- "TOUR"
    object
}



## helper for tour

print.TOUR <- function(x, ...){

   cat("object of class", sQuote(class(x)[1]), "\n")
   cat("result of method", sQuote(attr(x, "method")), "for", 
       length(x), "cities\n")
   if(!is.null(attr(x, "tour_length")))
   cat("tour length:", attr(x, "tour_length"), "\n")
   else 
   cat("tour length: unknown\n")
}
