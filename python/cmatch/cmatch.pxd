
cdef extern from "fnmatch.h":
    bint fnmatch(const char *pattern, const char *string, int flags)
