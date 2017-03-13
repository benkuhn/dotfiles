#!/usr/bin/env python3

import os.path

SCRIPT_DIR = os.path.abspath(os.path.dirname(__file__))
DOT_DIR = os.path.join(SCRIPT_DIR, 'dot')
HOME_DIR = os.path.expanduser('~')

def main():
    if not os.path.isdir(DOT_DIR):
        print(DOT_DIR, 'is not a directory')
        exit(1)
    for dotfilename in os.listdir(DOT_DIR):
        if dotfilename.startswith('.'):
            print('Not moving', dotfilename)
            continue
        dest = os.path.join(HOME_DIR, '.' + dotfilename)
        source = os.path.join(DOT_DIR, dotfilename)
        print('ln -s', source, dest)
        if os.path.islink(dest):
            os.remove(dest)
        elif os.path.exists(dest):
            print('  ERROR:', dest, 'exists and is not symlink')
            continue
        os.symlink(source, dest)

if __name__ == '__main__':
    main()
