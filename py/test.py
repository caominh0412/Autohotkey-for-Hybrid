
items = []
try:
    with open('mango.txt') as f:
        for line in f:
            items += line
    print(items)
except:
    print('Error open file')
    raise SystemExit()