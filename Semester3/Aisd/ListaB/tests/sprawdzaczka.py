#!/bin/python

import os 
import random
import sys

TESTS = 50

def new_pos(p):
    if p[0] > 0 and p[1] > 0:
        return (random.randrange(0, p[0]), random.randrange(0, p[1]))
    if p[0] > 0:
        return (random.randrange(0, p[0]), 0)
    if p[1] > 0:
        return (0, random.randrange(0, p[1]))

def create_test(level):
    test = ''
    if level < 20:
        barrier = 10
    elif level < 40:
        barrier = 30
    else:
        barrier = 50

    print(level)
    
    n = random.randrange(1, barrier - 1)
    m = random.randrange(1, barrier - 1)
    t = random.randrange(1, 1 + (n*m)*100)

    dic = {}
    lst = []
    
    it = 0
    pos = (m, n)
    for i in range(t):

        pos_new = new_pos(pos)
        coords = (pos[0], pos[1], pos_new[0], pos_new[1])
        if coords not in dic:
            dic[coords] = True
            lst.append(coords)
            it += 1

        if pos_new == (0, 0):
            pos = (m, n)
        else:
            pos = pos_new

    test += '{} {} {}\n'.format(m, n, it)

    for i in lst:
        test += '{} {} {} {}\n'.format(i[2], i[3], i[0], i[1])

    return test

def generate(cmd, system):
    for i in range(TESTS):

        if system == 'linux':
            printcmd = 'cat'
        elif system == 'windows':
            printcmd = 'type'

        with open('testy/test{}.in'.format(i), 'w') as f:
            f.write('{}'.format(create_test(i)))

        output = os.popen("{} testy/test{}.in | {}".format(printcmd, i, cmd)).read()
        
        with open('testy/test{}.out'.format(i), 'w') as f:
            f.write(str(output))

def validate(cmd, system):
    for i in range(TESTS):
        
        if system == 'linux':
            printcmd = 'cat'
        elif system == 'windows':
            printcmd = 'type'

        output = os.popen("{} testy/test{}.in | {}".format(printcmd, i, cmd)).read()

        with open('testy/test{}.out'.format(i), 'r') as f:
            data = f.read()
            if str(output) == str(data):
                print("Test {}: OK".format(i))
            else:
                print("Wrong answer for test {}! Expected: {}, returned: {}".format(i, data, output))

n = len(sys.argv)

if (n == 3):
    mode = sys.argv[1]
    cmd = sys.argv[2]
    if mode == 'test':
        validate(cmd, 'linux')
    elif mode == 'wintest':
        validate(cmd, 'windows')
    elif mode == 'gen':
        generate(cmd, 'linux')
    elif mode == 'wingen':
        generate(cmd, 'windows')