# read a simple TSPLIB format file

read_TSPLIB <- function(file, precision = 0) {
    
    lines <- readLines(file)
   
    # get info
    metadata <- grep(":", lines)
    
    info <- list()
    lapply(strsplit(lines[metadata], "[[:space:]]*:[[:space:]]*"),
        FUN = function(x) {
            x[2] <- sub("[[:space:]]*$","",x[2]) # kill trailing spaces
            info[[toupper(x[1])]] <<- toupper(x[2])
        })
    
    # check
    if(substr(info$TYPE, 1, 3) != "TSP") 
    stop ("currently the only implemented TYPE is TSP")
    
    if(info$EDGE_WEIGHT_TYPE != "EXPLICIT") 
    stop ("EDGE_WEIGHT_TYPE needs to be EXPLICIT")
    
    # get data
    dim <- as.integer(info$DIMENSION)
    
    data_start <- grep("EDGE_WEIGHT_SECTION", lines, ignore.case = TRUE)
    if(length(data_start) == 0) stop("EDGE_WEIGHT_SECTION missing")
    
    data <- lines[(data_start+1):length(lines)]
    data <- sub("EOF", "", data, ignore.case = TRUE) # kill optional EOF
    data <- sub("^[[:space:]]*", "", data)# kill leading spaces
    data <- strsplit(paste(data, collapse = " "), "[[:space:]]+")[[1]]
    data <- as.integer(data)
    
    if(precision != 0) data <- data *10^precision

    
    # create TSP object
    # we have only symmetric data here!
    if(info$EDGE_WEIGHT_FORMAT == "FULL_MATRIX") {
        data <- matrix(data, ncol = dim)
    
    }else if(info$EDGE_WEIGHT_FORMAT == "UPPER_ROW" || 
        info$EDGE_WEIGHT_FORMAT == "LOWER_COL") {
        class(data) <- "dist"
        attr(data, "Size")  <- dim
        attr(data, "Diag")  <- FALSE
        attr(data, "Upper") <- FALSE
    
    }else if(info$EDGE_WEIGHT_FORMAT == "UPPER_DIAG_ROW" ||
        info$EDGE_WEIGHT_FORMAT == "LOWER_DIAG_COL") {
        # kill diag
        kill <- cumsum(c(1, rev(2:dim)))
        data <- data[-kill]
        
        class(data) <- "dist"
        attr(data, "Size")  <- dim
        attr(data, "Diag")  <- FALSE
        attr(data, "Upper") <- FALSE
       
    }else if(info$EDGE_WEIGHT_FORMAT == "UPPER_COL" ||
        info$EDGE_WEIGHT_FORMAT == "LOWER_ROW") {
        class(data) <- "dist"
        attr(data, "Size")  <- dim
        attr(data, "Diag")  <- FALSE
        attr(data, "Upper") <- TRUE
    
    }else if(info$EDGE_WEIGHT_FORMAT == "UPPER_DIAG_COL" ||
        info$EDGE_WEIGHT_FORMAT == "LOWER_DIAG_ROW") {
        # kill diag
        kill <- cumsum(1:dim)
        data <- data[-kill]
        
        class(data) <- "dist"
        attr(data, "Size")  <- dim
        attr(data, "Diag")  <- FALSE
        attr(data, "Upper") <- TRUE
    
    }else stop("EDGE_WEIGHT_FORMAT not implemented")
        
   TSP(data)
}

