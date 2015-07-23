## Matrix wrapper which allows to cache its inversion
# 
# @param x the matrix to wrap, can be accessed and overriden
#	with .get() .set(newMatrix)
# 
# .setInversion(inverted) and .getInversion() allows to put
#	the inversion into cache and to retrieve it
makeCacheMatrix <- function(x = matrix()) {
	# initializes the matrix inversion to null
	inversion <- NULL

	# overrides the wrapped matrix and nullifies its inversion
	set <- function(newMatrix) {
		x <<- newMatrix
		inversion <<- NULL
	}

	# returns the wrapped matrix
	get <- function() x
	
	# set the matrix inversion
	setInversion <- function(inverted) inversion <<- inverted
	
	# set the matrix inversion
	getInversion <- function() inversion

	# returns the cached matrix as a packaged functions list
	list(set = set,
		 get = get,
		 setInversion = setInversion,
		 getInversion = getInversion)
}


## Returns the inversion of the given cachematrix: computes it before caching if necessary
#
# @param the cachematrix from which the inversion is expected. The inner
#	matrix is expected to be invertible
cacheSolve <- function(x, ...) {
	# attempts to retrieve the inversion from the cache
	inverted <- x$getInversion()

	# computes and caches the inversion if necessary
	if (is.null(inverted)) {
		# check matrix integrity: not-null (TODO: must be square)
		dataMatrix <- x$get()
		if(is.null(dataMatrix)) {
			stop('cannot invert a null matrix')
		}

		message('inversing matrix...')
		inverted <- solve(dataMatrix, ...)
		x$setInversion(inverted)
	}
	else {
		message('inversion retrieved from cache')
	}

	# returns the expected inversion
	inverted
}
