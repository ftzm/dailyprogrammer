#!/usr/bin/env python

"""
pipe in text, prints text right or left justified.
requires one arg, 'l' for left justified, 'r' for right.
"""

import sys

direction = sys.argv[1]
if direction == 'l':
    direction = '<'
else:
    direction = '>'


file = sys.stdin.read()
w = max(len(l) for l in file.split('\n'))

for l in file.split('\n'):
    print('{:{}{}}'.format(l, direction, w))
