import math

x = 2
a = x
m = 2
n = 2
def test(x,m):
	while m<=n:
		a = a + x**m/math.factorial(m)
		m+=1
	print(a)


