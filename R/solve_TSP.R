## TSP
solve_TSP.TSP <- function(x, method = NULL, control = NULL) {
    .solve_TSP(x, method, control)
}

## ATSP
solve_TSP.ATSP <- function(x, method = NULL, control = NULL) {
    .solve_TSP(x, method, control)
}

## generic
solve_TSP <- function(x, method = NULL, control = NULL)
    UseMethod("solve_TSP")
    

## workhorse
.solve_TSP <- function(x, method = NULL, control = NULL) {
       
    ## methods
    methods <- c(
        "nearest_insertion",    ## standard
        "farthest_insertion",     
        "cheapest_insertion",     
        "arbitrary_insertion",     
        "nn",
        "repetitive_nn",
        "2-opt",
        "concorde",
        "linkern"
    )

    if(is.null(method)) methodNr <- 1
    else methodNr <- pmatch(tolower(method), tolower(methods))
    if(is.na(methodNr)) stop (paste("Unknown method:",sQuote(method)))


    ## work horses
    if(methodNr == 1) {
        order <- tsp_insertion(x, type = "nearest", control = control)
    }else if(methodNr == 2) {
        order <- tsp_insertion(x, type = "farthest", control = control)
    }else if(methodNr == 3) {
        order <- tsp_insertion(x, type = "cheapest", control = control)
    }else if(methodNr == 4) {
        order <- tsp_insertion(x, type = "arbitrary", control = control)
    }else if(methodNr == 5) {
        order <- tsp_nn(x, control = control)
    }else if(methodNr == 6) {
        order <- tsp_repetitive_nn(x, control = control)
    }else if(methodNr == 7) {
        order <- tsp_two_opt(x, control = control)
    }else if(methodNr == 8) {
        order <- tsp_concorde(x, control = control)
    }else if(methodNr == 9) {
        order <- tsp_linkern(x, control = control)
    }

    
    if(!is.integer(order)) order <- as.integer(order)
    class(order) <- c("TOUR", class(order))
    attr(order, "method") <- methods[methodNr]
    attr(order, "tour_length") <- tour_length(x, order)
    names(order) <- labels(x)[order]
    
    return(order)
}
