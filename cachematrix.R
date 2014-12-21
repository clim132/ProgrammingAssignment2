## Programming assignment #2

## Example of usage of functions
##
## > m <- matrix(rnorm(16,mean=7),nrow=4,ncol=4)
## > cm <- makeCacheMatrix(m)
## > m
##          [,1]     [,2]     [,3]     [,4]
## [1,] 7.603385 5.764510 7.642727 8.171168
## [2,] 6.158836 6.009444 5.772310 7.907678
## [3,] 8.141745 5.524937 6.035631 6.144852
## [4,] 6.736327 6.441739 7.932833 6.806410
## > cm
## $set
## function (y)
## {
##     x <<- y
##     s <<- NULL
## }
## <environment: 0x108b754e0>
## ...
##
## ### - First call does not have cached inverse yet
## > cacheSolve(cm)
##             [,1]       [,2]       [,3]       [,4]
## [1,]  0.06149831 -0.1557924  0.3737431 -0.2302467
## [2,] -0.83681150  0.4121318  0.1371128  0.4020011
## [3,]  0.32850475 -0.3913832 -0.2396506  0.2766926
## [4,]  0.34824166  0.2202925 -0.2203500 -0.3281502
##
## ### - Second call gets cached inverse
## > cacheSolve(cm)
## getting cached data
##             [,1]       [,2]       [,3]       [,4]
## [1,]  0.06149831 -0.1557924  0.3737431 -0.2302467
## [2,] -0.83681150  0.4121318  0.1371128  0.4020011
## [3,]  0.32850475 -0.3913832 -0.2396506  0.2766926
## [4,]  0.34824166  0.2202925 -0.2203500 -0.3281502


## Returns list of functions to cache a matrix and its inverse and
## retrieve either matrix or inverse from the cache

makeCacheMatrix <- function(x = matrix()) {
	s <- NULL
	
	## 'set' function to set the value of the matrix
	set <- function(y) {
		x <<- y
		s <<- NULL
	}
	
	## 'get' function to get value of matrix
	get <- function() { x }
	
	## 'setsolve' to cache the value of the matrix inverse
	setsolve <- function(solve) s <<- solve
	
	## 'getsolve' to get the cached value of the matrix inverse
	getsolve <- function() { s }
	
	## Return list of functions
	list(set = set, get = get, setsolve = setsolve, getsolve = getsolve)
}


## Example of how to use the list of functions to cache the inverse of matrix

cacheSolve <- function(x, ...) {
	## Return a matrix that is the inverse of 'x'
	s <- x$getsolve()
	
	## Check if there is a cached value
	if (!is.null(s)) {
		message("getting cached data")
		return (s)
	}
	
	## No cached value, get original matrix
	data <- x$get()
	s <- solve(data, ...)
	x$setsolve(s)
	s
}

