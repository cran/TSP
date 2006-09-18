# Greedy tour also called nearest neighbor algorithm

tsp_greedy <- function(x, control = NULL) {

    # check parameters
    if(!inherits(x, "TSP")) x <- TSP(x)
    
    n <- n_of_cities(x)

    # we use a matrix for now
    x <- as.matrix(x)

    start <- control$start
    if(is.null(start)) start <- sample(1:n, 1)
    if(start < 0 || start > n) stop(paste("illegal value for", sQuote("start")))
    
    # place first city
    placed <- logical(n)
    placed[start] <- TRUE
    current <- start
    order <- integer(n)
    order[1] <- start

    while(any(placed == FALSE)) {
        # find nearest city
        rest <- which(!placed)
        # nearest <- rest[which.min(x[current,rest])]
        # which.min has problems with Inf
        # so we can break ties randomly now too
        x_sub <- x[current,rest]
        nearest <- rest[which(x_sub == min(x_sub))]
        if(length(nearest) > 1) nearest <- sample(nearest, 1)
        
        # place city
        order[n + 1 - length(rest)] <- nearest
        placed[nearest] <- TRUE
        current <- nearest
    }

   order
}
