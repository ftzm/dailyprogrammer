#!/usr/bin/env python

"""
given the day, month, and year given as ints ([1-31], [1-12], [1970])
give the day of the week for any given date.
"""

import sys
import datetime


def receive_date():
        day, month, year = sys.argv[1:]
        return day, month, year


def make_datetime(day, month, year):
        date = datetime.datetime.strptime(day+month+year, '%d%m%Y')
        return date


def main():
    try:
        day, month, year = receive_date()
    except ValueError:
        print('Please supply the day, month, and year as integers')
        return
    try:
        date = make_datetime(day, month, year)
    except ValueError:
        print('Invalid date format')
        return
    print(date.strftime("%A"))

main()
