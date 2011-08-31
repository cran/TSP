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
