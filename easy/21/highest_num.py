#!/usr/bin/env python


def num_to_digs(num):
    nums = []
    while num != 0:
        nums.append(num % 10)
        num //= 10
    return list(reversed(nums))


def highest_num(num):
    return int(''.join(list(map(str, reversed(sorted(num_to_digs(num)))))))

print(highest_num(123498347509823475))
