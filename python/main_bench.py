import json
import pytest
from operator import itemgetter

from cmatch import match as cmatch, match_filter as cmatch_filter
from pymatch import match as pymatch, match_filter as pymatch_filter

with open('templates.json')as f:
    templates = json.load(f)
    templates = tuple(map(itemgetter('template'), templates))


@pytest.mark.parametrize('matchf', [pymatch, pymatch_filter, cmatch, cmatch_filter],
                         ids=['python_match', 'python_filter','c', 'c_filter'])
@pytest.mark.parametrize(
    'email, pattern',
    [('test@subdomain.domain.spottradingllc.com', '*.spottradingllc.com'),
     ('as@domain.nyumc.org', '*.nyumc.org')],
    ids=['com_zone', 'org_zone']
)
def test_match_benchmark(benchmark, matchf, email, pattern):

    r = set()

    def f(match):
        nonlocal r
        for pattern in templates:
            if match(email, pattern):
                r.add(pattern)
    benchmark(f, matchf)
    assert r == {pattern}


if __name__ == '__main__':
    # python -m cProfile -o out.prof main_test.py

    pytest.main([__file__ , '--benchmark-only',
                 # '--benchmark-min-time=5',
                 # '--benchmark-min-rounds=20',
                 '--benchmark-timer=time.process_time'])