#!/usr/bin/env python


def str_sep(s):
    s = list(s)
    other = ""
    i = 0
    j = len(s)
    last = ""
    while i < j:
        if s[i] == last:
            other += s.pop(i)
            j -= 1
        else:
            last = s[i]
            i += 1
    return " ".join(["".join(s), other])

for s in ["balloons", "ddaaiillyypprrooggrraammeerr", "aabbccddeded", "flabby aapples"]:
    print(str_sep(s))
