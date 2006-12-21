tour_length.TSP <- function(x, order) {
   
    n <- n_of_cities(x)
    if(missing(order)) order <- 1:n

    .Call("tour_length_dist", x, order)
}

tour_length.ATSP <- function(x, order) {
    
    n <- n_of_cities(x)
    if(missing(order)) order <- 1:n

    .Call("tour_length_matrix", x, order)
}

## generic
tour_length <- function(x, order) UseMethod("tour_length")
