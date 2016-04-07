#!/usr/bin/env python


def remove_chars(s, r):
    return [c for c in s if c not in r]

print(''.join(remove_chars('hello there friend', 'ler')))
