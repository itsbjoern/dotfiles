import os


def shell(cmd):
    return os.popen(cmd).read().strip()
