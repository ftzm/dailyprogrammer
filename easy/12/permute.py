#!/usr/bin/env python

"""
take a string as an argument, return all possible permutations
"""

import sys

s = sys.argv[1]


def permute(s):
    if len(s) < 2:
        yield s
    else:
        for i in range(len(s)):
            x = s[i]
            for y in permute(s[:i]+s[i+1:]):
                yield x + y

print(len(list(permute(s))))
