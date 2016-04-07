#!/usr/bin/env python

import sys

limit = int(sys.argv[1])

num = 1
for i in range(limit):
    print('@' * num)
    num = num * 2
