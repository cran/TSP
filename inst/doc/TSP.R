### R code from vignette source 'TSP.Rnw'

###################################################
### code chunk number 1: TSP.Rnw:81-84
###################################################
options(width = 75, useFancyQuotes=FALSE, prompt="R> ")
### for sampling
set.seed(1234)


###################################################
### code chunk number 2: TSP.Rnw:645-648
###################################################
library("TSP")
data("USCA50")
USCA50


###################################################
### code chunk number 3: TSP.Rnw:661-662
###################################################
set.seed(1234)


###################################################
### code chunk number 4: dotchart_USCA50
###################################################
methods <- c("nearest_insertion", "farthest_insertion", "cheapest_insertion",
    "arbitrary_insertion", "nn", "repetitive_nn", "two_opt")

tours <- sapply(methods, FUN = function(m) solve_TSP(USCA50, method = m),
                simplify = FALSE)
## tours$concorde  <- solve_TSP(tsp, method = "concorde")

tours[[1]]

dotchart(sort(c(sapply(tours, tour_length), optimal = 14497)),
xlab = "tour length", xlim = c(0, 20000))


###################################################
### code chunk number 5: TSP.Rnw:703-704
###################################################
set.seed(1234)


###################################################
### code chunk number 6: TSP.Rnw:707-711
###################################################
library("TSP")
data("USCA312")
tsp <- insert_dummy(USCA312, label = "cut")
tsp


###################################################
### code chunk number 7: TSP.Rnw:717-719
###################################################
tour <- solve_TSP(tsp, method="farthest_insertion")
tour


###################################################
### code chunk number 8: TSP.Rnw:728-731
###################################################
path <- cut_tour(tour, "cut")
head(labels(path))
tail(labels(path))


###################################################
### code chunk number 9: map1
###################################################
if(require(maps)) {
  library("maps")

  data("USCA312_GPS")

  plot_path <- function(path) {
    plot((USCA312_GPS[, c("long", "lat")]), cex = .3, col = "red")
    map("world", col = "gray", add = TRUE)
    lines(USCA312_GPS[, c("long", "lat")][path,], col = "black")
    points(USCA312_GPS[c(head(path, 1), tail(path, 1)),  c("long", "lat")], pch = 19, col = "black")
  }

  plot_path(path)

} else {
    plot(NA, xlim= c(0,1), ylim = c(0,1))
    text(.5, .5, "Suggested packages not available")
}


###################################################
### code chunk number 10: TSP.Rnw:792-793
###################################################
set.seed(1234)


###################################################
### code chunk number 11: TSP.Rnw:796-807
###################################################
atsp <- as.ATSP(USCA312)
ny <- which(labels(USCA312) == "New York, NY")
atsp[, ny] <- 0
initial_tour <- solve_TSP(atsp, method="nn")
initial_tour
tour <- solve_TSP(atsp, method ="two_opt", control = list(tour = initial_tour))
tour
path <- cut_tour(tour, ny, exclude_cut = FALSE)

head(labels(path))
tail(labels(path))


###################################################
### code chunk number 12: map2
###################################################
plot_path(path)


###################################################
### code chunk number 13: TSP.Rnw:831-833
###################################################
tsp <- reformulate_ATSP_as_TSP(atsp)
tsp


###################################################
### code chunk number 14: TSP.Rnw:845-847 (eval = FALSE)
###################################################
## tour <- solve_TSP(tsp, method = "concorde")
## tour <- as.TOUR(tour[tour <= n_of_cities(atsp)])


###################################################
### code chunk number 15: TSP.Rnw:869-870
###################################################
set.seed(1234)


###################################################
### code chunk number 16: TSP.Rnw:873-883
###################################################
m <- as.matrix(USCA312)
ny <- which(labels(USCA312) == "New York, NY")
la <- which(labels(USCA312) == "Los Angeles, CA")

atsp <- ATSP(m[-c(ny,la), -c(ny,la)])
atsp <- insert_dummy(atsp, label = "LA/NY")

la_ny <- which(labels(atsp) == "LA/NY")
atsp[la_ny, ] <- c(m[-c(ny,la), ny], 0)
atsp[, la_ny] <- c(m[la, -c(ny,la)], 0)


###################################################
### code chunk number 17: TSP.Rnw:888-897
###################################################
tour <- solve_TSP(atsp, method ="nearest_insertion")
tour

path_labels <- c("New York, NY",
    labels(cut_tour(tour, la_ny)), "Los Angeles, CA")
path_ids <- match(path_labels, labels(USCA312))

head(path_labels)
tail(path_labels)


###################################################
### code chunk number 18: map3
###################################################
plot_path(path_ids)


###################################################
### code chunk number 19: TSP.Rnw:941-942
###################################################
set.seed(4444)


###################################################
### code chunk number 20: TSP.Rnw:944-948
###################################################
data("iris")
tsp <- TSP(dist(iris[-5]), labels = iris[, "Species"])
tsp_dummy <- insert_dummy(tsp, n = 3, label = "boundary")
tour <- solve_TSP(tsp_dummy)


###################################################
### code chunk number 21: clustering
###################################################
## plot the distance matrix
image(tsp_dummy, tour, xlab = "objects", ylab ="objects")

## draw lines where the dummy cities are located
abline(h = which(labels(tour)=="boundary"), col = "red")
abline(v = which(labels(tour)=="boundary"), col = "red")


###################################################
### code chunk number 22: TSP.Rnw:986-990
###################################################
out <- rle(labels(tour))
data.frame(Species = out$values,
           Lenghts = out$lengths,
           Pos = cumsum(out$lengths))


###################################################
### code chunk number 23: clustering2
###################################################
prc <- prcomp(iris[1:4])
plot(prc$x, pch = as.numeric(iris[,5]), col =  as.numeric(iris[,5]))

paths <- cut_tour(tour, cut = "boundary")
for(p in paths) lines(prc$x[p, ])


