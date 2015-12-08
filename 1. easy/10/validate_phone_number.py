#!/usr/bin/env python

"""
prompts for a telephone number, reports whether or not the format is valid.
"""

import re

telephone_number = input('Please enter a telephone number: ')
result = re.match('(\(\d{3}\)\s?|\d{3}[\-\.]?)?\d{3}[\-\.]?\d{4}',
                  telephone_number)

if result is not None:
    print('Valid number')
else:
    print('Invalid number')
