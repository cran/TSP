

tour_length <- function(x, order) {
   
    # check parameters
    if(!inherits(x, "TSP")) x <- TSP(x)
    
    n <- n_of_cities(x)
    if(missing(order)) order <- 1:n

    # calculate the tour length
    # access a dist object for i < j <= n is
    # x[n*(i-1) - i*(i-1)/2 + j-i]
    s <- sapply(1:(n-1), FUN = function(k) {
            ij <- order[k:(k+1)]
            i <- min(ij)
            j <- max(ij)
            x[n*(i-1) - i*(i-1)/2 + j-i]
        })

    # now we close the tour
    ij <- order[c(1,n)]
    i <- min(ij)
    j <- max(ij)
    
    sum(s) + x[n*(i-1) - i*(i-1)/2 + j-i]
}
