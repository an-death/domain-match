from fnmatch import fnmatch


NOT_FOUND = -1

def _is_pattern(string):
    return string.find('*') != NOT_FOUND or string.find('?') != NOT_FOUND


def _get_zone(domain):
    return domain.split('.')[-1]


def match(name: str, pattern: str):
    return fnmatch(name, pattern)


def match_filter(name: str, pattern: str):
    pattern_zone = _get_zone(pattern)
    if _is_pattern(pattern_zone):
        return fnmatch(name, pattern)
    if pattern_zone != _get_zone(name):
        return False
    return fnmatch(name, pattern)

