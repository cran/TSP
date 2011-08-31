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



## nearest neighbor algorithm

tsp_nn <- function(x, control = NULL) {
    ## parameter x comes checked from solve_TSP/solve_ATSP

    n <- n_of_cities(x)

    ## we use a matrix for now (coveres TSP and ATSP)
    x <- as.matrix(x)

    start <- control$start
    if(is.null(start)) start <- sample(1:n, 1)
    if(start < 0 || start > n) stop(paste("illegal value for", 
            sQuote("start")))

    ## place first city
    placed <- logical(n)
    placed[start] <- TRUE
    current <- start
    order <- integer(n)
    order[1] <- start

    while(any(placed == FALSE)) {
        ## find nearest city
        rest <- which(!placed)
        ## nearest <- rest[which.min(x[current,rest])]
        ## which.min has problems with Inf
        ## so we can break ties randomly now too
        x_sub <- x[current, rest]
        nearest <- rest[which(x_sub == min(x_sub))]
        if(length(nearest) > 1) nearest <- sample(nearest, 1)

        ## place city
        order[n + 1 - length(rest)] <- nearest
        placed[nearest] <- TRUE
        current <- nearest
    }

    order
}

## repetitive NN

tsp_repetitive_nn <- function(x, control){

  n <- n_of_cities(x)
  tours <- lapply(1:n, function(i) tsp_nn(x, control = list(start = i)))
  lengths <- sapply(tours, FUN = function(i) tour_length(x, i))
  
  tours[[which.min(lengths)]]
}
