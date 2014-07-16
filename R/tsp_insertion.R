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



## Insertion algorithms 
## (Rosenkrantz et al. 1977)

tsp_insertion <- function(x, type = "nearest", control = NULL){
    
    ## since sample has an annoying convenience feature for
    ## lenght(x) == 1
    choose1 <- function(x) if(length(x) > 1) sample(x, 1) else x
    
    min_nonNA <- function(x) { x[is.na(x)] <- Inf; min(x) }
    
    ## this is slower than which.min and which.max but works also
    ## correctly for only values Inf in x and breaks ties randomly 
    choose1_min <- function(x) { x[is.na(x)] <- Inf; choose1(which(x == min(x))) }
    choose1_max <- function(x) { x[is.na(x)] <- -Inf; choose1(which(x == max(x))) }

    types <- c("nearest", "farthest", "cheapest", "arbitrary")
    type_num <- pmatch(type, types)
    if(is.na(type_num)) stop(paste("Unknown insertion type: ", sQuote(type)))
    
    ## x comes checked form solve_TSP/solve_ATSP
    n <- n_of_cities(x)

    ## we use a matrix for now (covers TSP and ATSP)
    asym <- inherits(x, "ATSP")
    x <- as.matrix(x)

    ## prepare criterion for nearest/farthest
    if(type_num == 1) crit <- choose1_min 
    if(type_num == 2) crit <- choose1_max

    ## place first city
    start <- control$start
    if(is.null(start)) start <- sample(1:n, 1)
    if(start < 0 || start > n) 
    stop(paste("illegal value for", sQuote("start")))

    placed <- logical(n)
    placed[start] <- TRUE
    order <- c(start)

    ## place other cities
    while(any(placed == FALSE)) {
        
        ## find city to be inserted
        ks <- which(!placed)
        js <- which(placed)

        ## nearest / farthest
        if(type_num < 3) {
            m <- x[ks,js, drop = FALSE]
            
            ## for the asymmetric case we have to take distances
            ## from and to the city into account
            if(asym){
                m <- cbind(m, t(x)[ks,js, drop = FALSE]) 
            }
            
            ds <- sapply(1:length(ks), FUN = 
                function(i)  min_nonNA(m[i, , drop = FALSE]))

            winner_index <- crit(ds)
            k <- ks[winner_index] 
        }
       
        ## cheapest
        else if(type_num == 3) {
            winner_index <- choose1_min(sapply(ks, FUN =
                    function(k) min_nonNA(.Call("insertion_cost", x, order, k, 
				    PACKAGE="TSP")) ))
            k <- ks[winner_index]

            ## we look for the optimal insertion place for k again later
            ## this is not necessary, but it is more convenient
            ## to reuse the code for the other insertion algorithms for now. 
        }
        
        ## random
        else if(type_num == 4) k <- choose1(ks)
        
        ## just in case
        else stop("unknown insertion type")

        ## do insertion
        placed[k] <- TRUE
        
        if(length(order) == 1) order <- append(order, k)
        else {
            pos <- choose1_min(.Call("insertion_cost", x, order, k, 
			    PACKAGE="TSP"))
            order <- append(order, k, after = pos)
        }
    }

    order
}


