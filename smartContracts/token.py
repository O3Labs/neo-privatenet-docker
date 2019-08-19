from boa.interop.Neo.Runtime import CheckWitness
from boa.interop.Neo.Storage import GetContext, Get, Put
from boa.interop.Neo.Action import RegisterAction

# AVFobKv2y7i66gbGPAGDT67zv1RMQQj9GB
TOKEN_OWNER = b'\x93\xe1\xe5\xbe\xd9\x15\x96\x84\xac\x8c.\xe4\r w\xfb\xcf\xac\xf7\n'
TOTAL_SUPPLY = 10000000 * 100000000
TOKEN_NAME = 'My First Token'
TOKEN_SYMBOL = 'MFT'
TOKEN_DECIMALS = 8

TOTAL_SUPPLY_KEY = 'TOTAL_SUPPLY'
INIT_KEY = 'DEPLOYED'

ctx = GetContext()
OnTransfer = RegisterAction('transfer', 'addr_from', 'addr_to', 'amount')

def Main(operation, args):

    if operation == 'totalSupply':
        return Get(ctx, TOTAL_SUPPLY_KEY)

    if operation == 'name':
        return TOKEN_NAME

    if operation == 'symbol':
        return TOKEN_SYMBOL

    if operation == 'decimals':
        return TOKEN_DECIMALS

    if operation == 'balanceOf':
        if len(args) == 1:
            return Get(ctx, args[0])

    if operation == 'transfer':
        if len(args) == 3:
            return transfer(args[0], args[1], args[2])

    if operation == 'init':
        return init()

    return False

def transfer(addr_from, addr_to, amount):

    if amount <= 0:
        return False

    if len(addr_to) != 20:
        print("not a valid to address")
        return False

    if not CheckWitness(addr_from):
        print("from address is not the tx sender")
        return False

    if addr_from == addr_to:
        print("transfer to self!")
        return True

    from_val = Get(ctx, addr_from)

    if from_val < amount:
        print("insufficient funds")
        return False

    if from_val == amount:
        Delete(ctx, addr_from)
    else:
        difference = from_val - amount
        Put(ctx, addr_from, difference)

    to_value = Get(ctx, addr_to)

    to_total = to_value + amount

    Put(ctx, addr_to, to_total)

    OnTransfer(addr_from, addr_to, amount)

    return True

def init():
    if not CheckWitness(TOKEN_OWNER):
        print("Must be token owner to init")
        return False

    if Get(ctx, INIT_KEY):
        print("Token already init")
        return False

    Put(ctx, INIT_KEY, 1)
    Put(ctx, TOTAL_SUPPLY_KEY, TOTAL_SUPPLY)
    Put(ctx, TOKEN_OWNER, TOTAL_SUPPLY)
    OnTransfer(None, TOKEN_OWNER, TOTAL_SUPPLY)
    return True
