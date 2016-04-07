#!/usr/bin/env python


def find_primes(limit):
    nums = [i for i in range(2, limit+1)]
    primes = []
    while nums:
        prime = nums.pop(0)
        primes.append(prime)
        nums = [i for i in nums if i % prime != 0]
    return primes

print(find_primes(2000))
