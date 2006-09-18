# helper for tour

print.TOUR <- function(x, ...){

   cat("object of class", sQuote(class(x)[1]), "\n")
   cat("result of method", sQuote(attr(x, "method")), "for", 
       length(x), "cities\n")
   cat("tour length:", attr(x, "tour_length"), "\n")
   #cat("order:\n")
   #print(as.vector(x))

}
