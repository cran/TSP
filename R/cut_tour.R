cut_tour.TOUR <- function(x, cut, exclude_cut = TRUE) {
   
    if(is.character(cut)) cut <- which(labels(x) == cut)
    else cut <- which(x == cut) ## city id

    exclude_cut <- if(exclude_cut) 1 else 0
    
    path <- c(x,x)[(cut + exclude_cut):(length(x) + cut - 1)]
    path
}

##generic
cut_tour <- function(x, cut, exclude_cut = TRUE)
    UseMethod("cut_tour")

    
