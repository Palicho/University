#!/bin/python

import os 
import random
import sys

def generate():
    letters = 'ABCDEF'
    for i in range(50):
        if i < 20:
            n = random.randrange(1, 11)
            m = random.randrange(1, 11)
        elif i < 40:
            n = random.randrange(10, 301)
            m = random.randrange(10, 301)
        else:
            n = random.randrange(300, 2001)
            m = random.randrange(300, 2001)

        with open('testy/test{}.in'.format(i), 'w') as f:
            f.write('{} {}\n'.format(n, m))
            for j in range(n):
                for k in range(m):
                    f.write(letters[random.randrange(0, 6)])
                f.write('\n')

        output = os.popen("cat testy/test{}.in | ./main".format(i)).read()
        
        with open('testy/test{}.out'.format(i), 'w') as f:
            f.write(str(output))

def validate(cmd):
    for i in range(50):
        output = os.popen("cat testy/test{}.in | {}".format(i, cmd)).read()

        with open('testy/test{}.out'.format(i), 'r') as f:
            data = int(f.read())
            if int(output) == data:
                print("Test {}: OK".format(i))
            else:
                print("Wrong answer for test {}! Expected: {}, returned: {}".format(i, data, output))


n = len(sys.argv)

if (n == 2):
    mode = sys.argv[1]
    if (mode == 'gen'):
        generate()
elif (n == 3):
    mode = sys.argv[1]
    app = sys.argv[2]
    if (mode == 'test'):
        validate('{}'.format(app))
