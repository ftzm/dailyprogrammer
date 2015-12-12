#!/usr/bin/env python

"""
takes three int args: year, month, day, and return the day number (1-265)
"""

import sys

s = sys.argv[1]
months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30]


def receive_date():
        year, month, day = map(int, sys.argv[1:])
        return day, month, year


def count(year, month, day):
    days = sum(months[:month])
    if month % 4 == 0 and month % 100 != 0:
        days += 1
    elif month % 400 == 0:
        days += 1
    days += day
    return days


def main():
    day, month, year = receive_date()
    days = count(year, month, day)
    print(days)

main()
