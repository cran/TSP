# Nearest/farthest insertion algorithm 
# (Johnson and Papadimitrou in Lawler et al. 1985)

tsp_insertion <- function(x, nearest = TRUE, control = NULL){
  
    # check parameters
    if(!inherits(x, "TSP")) x <- TSP(x)
    
    n <- n_of_cities(x)
    
    # we use a matrix for now
    x <- as.matrix(x)
    
    start <- control$start
    if(is.null(start)) start <- sample(1:n, 1)
    if(start < 0 || start > n) stop(paste("illegal value for", sQuote("start")))
    
    placed <- logical(n)
    placed[start] <- TRUE
    order <- c(start)

    while(any(placed == FALSE)) {
        # find city j (in tour) and city k (not jet used) which are closest
        js <- which(placed)
        ks <- which(!placed)

        # which.min does no random tie breaking!
        if(nearest == TRUE) mx <- which.min(x[js,ks, drop = FALSE])
        else mx <- which.max(x[js,ks, drop = FALSE])
        k <- ks[(mx-1) %/% length(js) + 1]
        #j <- js[(mx-1) %% length(js) + 1]

        # now we do nearest insertion
        placed[k] <- TRUE
        if(length(order) == 1) order <- c(order, k)
        else {
            bestVal <- Inf
            insert <- 0
            for(i in 1:(length(order)-1)) {
                val <- x[order[i], k] + x[k, order[i+1]] - x[order[i], order[i+1]]
                if(val < bestVal) {
                    bestVal <- val
                    insert <- i
                }
            }

            # now between the last an first city
            val <- x[order[length(order)], k] + x[k,order[1]] 
            - x[order[length(order)],order[1]]
            if(val < bestVal) {
                bestVal <- val
                insert <- 0     # we just append k
            }

            if(insert == 0) order <- c(order, k)
            else order <- c(order[1:insert], k, order[(insert+1):length(order)]) 
        }
    }

    order
}


