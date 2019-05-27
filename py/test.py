class Node:
	def __init__(self, val, left = None, right = None):
		self.val = val
		self.left = left
		self.right = right

	def serialize(root):
		#print('Node : {} , {} , {} - {}'.format(root.val,root.left,root.right,type(root)))
		if root == '':
			return #
		elif type(root) == int:
			#print(2)
			return root
		else:
			serialize = str(root.val) + ' - ' + str(Node.serialize(root.left)) + ' - ' + str(Node.serialize(root.right))
			return serialize


Node(1,1,1).serialize()
type(1)