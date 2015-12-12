#!/usr/bin/env python

"""
Input: list of elements and a block size k or some other variable of your choice

Output: return the list of elements with every block of k elements reversed, starting from the beginning of the list.

For instance, given the list 12, 24, 32, 44, 55, 66 and the block size 2, the result is 24, 12, 44, 32, 66, 55.

first arg block size, rest of args are the list
"""

import sys

k = int(sys.argv[1])
l = list(map(int, sys.argv[2:]))


def block_switch(k, l):
    return [i for l in [list(reversed(l[i:i+k])) for i in range(0, len(l), k)]
            for i in l]

print(block_switch(k, l))
