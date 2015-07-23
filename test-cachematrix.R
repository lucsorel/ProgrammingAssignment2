# retrieves the current directory (!! ONLY works when this file is sourced !!)
currentDir <- dirname(sys.frame(1)$ofile)

# loads the cachematrix.R functions
source(paste(currentDir, 'cachematrix.R', sep = '/'))

# attempting to invert a null datamatrix should throw a stop (commented out to test the rest)
## nullDataMatrix <- makeCacheMatrix(x = NULL)
## cacheSolve(nullDataMatrix)

# tests the helpers on an invertable matrix
invertableMatrix <- rbind(c(4, 3), c(3, 2))
invertableCachedMatrix <- makeCacheMatrix(x = invertableMatrix)

# expects the 'inversing matrix...' message to be printed
cacheSolve(invertableCachedMatrix)

# expects the 'inversion retrieved from cache' message to be printed
inversion <- cacheSolve(invertableCachedMatrix)

# checks the inversion output (returns a 2x2 matrix of TRUEs)
invertableMatrix %*% inversion == rbind(c(1, 0), c(0, 1))