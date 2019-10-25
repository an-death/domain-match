#!python3
import sys
import json
from operator import itemgetter

from cmatch import match as cmatch, match_filter as cmatch_filter
from pymatch import match as pymatch, match_filter as pymatch_filter

with open('templates.json')as f:
    templates = json.load(f)
    templates = tuple(map(itemgetter('template'), templates))

if __name__ == '__main__':
    type, domain = sys.argv[1:3]
    if type == 'c':
        match = cmatch
    elif type == 'cfilter':
        match = cmatch_filter
    if type == 'pyfilter':
        match = pymatch_filter
    else:
        match = pymatch

    for tpl in templates:
        if match(domain, tpl):
            print(tpl)
