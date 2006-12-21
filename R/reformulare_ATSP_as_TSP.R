## create a TSP form an ATSP by doubling the cities

reformulate_ATSP_as_TSP <- function(x, infeasible = Inf, cheap = -Inf) {
    m <- as.matrix(x)
    
    ## scale matrix and add cheap links
    diag(m) <- cheap

    tsp <- rbind(
        cbind(matrix(infeasible, ncol = ncol(m), nrow = nrow(m)), t(m)),
        cbind(m, matrix(infeasible, ncol = nrow(m), nrow = ncol(m)))
    )

    ## create labels (* for virtual cities)
    lab <- c(labels(x), paste(labels(x), "*", sep = ""))
    dimnames(tsp) <- list(lab, lab)
    
    ## return as TSP
    TSP(tsp)
}

