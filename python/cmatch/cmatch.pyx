# cython: language_level=3
from cpython cimport bool
from cmatch cimport fnmatch as cfnmatch

IGNORE_CASE = 6

NOT_FOUND = -1


cdef bool _is_pattern(str string):
    return string.find('*') != NOT_FOUND or string.find('?') != NOT_FOUND


cdef str _get_zone(str domain):
    return domain.split('.')[-1]


cpdef bool match(str domain, str pattern, int flag=IGNORE_CASE):
    return not cfnmatch(pattern.encode(), domain.encode(), flag)


cpdef bool match_filter(name, pattern):
    pattern_zone = _get_zone(pattern)
    if _is_pattern(pattern_zone):
        return match(name, pattern)
    if pattern_zone != _get_zone(name):
        return False
    return match(name, pattern)
