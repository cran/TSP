library(TSP)
library(testthat)

context("solve_TSP")
## INF
m <- rbind(
  c(0, 1, 0, 1),
  c(1, 0, 1, Inf),
  c(0, 1, 0, 1),
  c(1, Inf, 1, 0)
)
d <- as.dist(m)
tsp <- TSP(d)

## test error on NA
tsp_na <- tsp
tsp_na[4] <- NA
expect_error(o <- solve_TSP(tsp_na))

## test Inf
methods <- c("nearest_insertion", "cheapest_insertion", "farthest_insertion", 
  "arbitrary_insertion", "nn", "repetitive_nn", "two_opt")

tours <- lapply(methods, FUN = function(m) solve_TSP(tsp, method = m))
names(tours) <- methods
#tours

tl <- sapply(tours, attr, "tour_length")
expect_true(all(tl == 4 | tl == Inf))

context("solve_TSP (Concorde)")
## Concorde (only if installed)
if(Sys.which("concore") != "") {
  o <- solve_TSP(tsp, method="concorde")
  expect_equivalent(tour_length(tsp, o), 4)
}

## Linken (only if installed)
if(Sys.which("linkern") != "") {
  o <- solve_TSP(tsp, method="linkern")
  expect_equivalent(tour_length(tsp, o), 4)
}
