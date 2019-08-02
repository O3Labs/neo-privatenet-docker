from boa.interop.Neo.Runtime import Log
from boa.builtins import concat

def Main(operation, args):
    if operation == 'hello':
        return hello(args[0])
    return False

def hello(input):
    Log(concat('Hello World! ', input))
    return True
