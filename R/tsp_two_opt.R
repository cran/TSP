## heuristic to improve a tour using exchanges of 2 edges.

tsp_two_opt <- function(x, control = NULL){

    ## improve a given tour or create a random tour
    initial <- function() {
        if(!is.null(control$tour)) as.integer(control$tour) 
        else sample(1:n_of_cities(x))
    }

    ## best of several tries
    rep <- if(!is.null(control$rep)) control$rep 
            else 1
    
    xx <- as.matrix(x)

    if(rep > 1) {
        tour <- replicate(rep, .Call("two_opt", xx, initial()), 
            simplify = FALSE)
        lengths <- sapply(tour, FUN = function(t) tour_length(x, t))
        tour <- tour[[which.min(lengths)]]
    }else tour <- .Call("two_opt", xx, initial())

    tour
}

