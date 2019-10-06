from libc.math cimport sqrt
from cython.view cimport array as cvarray
cimport cython

@cython.wraparound(False)
@cython.boundscheck(False)
cpdef list sieve(unsigned int n):
    if n == 0 or n == 1:
        return []
    cdef:
        unsigned int i, j
        int[:] numbers = cvarray(shape=(n-1,),
                                 itemsize=sizeof(int),
                                 format="i")
        int lim = int(sqrt(n)) + 1
        list output = []

    for i in range(n - 1):
        numbers[i] = i + 2

    for i in range(2, lim):
        if numbers[i - 2] != 0:
            j = i * i
            while j < n + 1:
                numbers[j - 2] = 0
                j += i

    for i in range(0, n - 1):
        if numbers[i] != 0:
            output.append(numbers[i])

    return output

cpdef list sieve_novector(unsigned int n):
    cdef unsigned int i, j
    cdef list sieve = list(range(2, n + 1))

    cdef int lim = int(sqrt(n)) + 1
    for i in range(2, lim):
        if sieve[i - 2] != 0:
            j = i * i
            while j < n + 1:
                sieve[j - 2] = 0
                j += i

    return [x for x in sieve if x != 0]
