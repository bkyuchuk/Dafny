// enumeration
datatype Color = White | Yellow | Blue | Red

// inductive datatype, parameterized
datatype Tree<T> = Leaf(data: T) | Node(left: Tree<T>, right: Tree<T>)

// "tree.Node?" is a discriminator, "tree.left" is a destructor
function LeftDepth<T>(tree: Tree<T>): nat {
  if tree.Node? then 1 + LeftDepth(tree.left) else 0
}

// (==) allows equality check
predicate HasLeftTree<T(==)>(t: Tree<T>, u: Tree<T>) {
  if t.Node? then t.left == u else false
}

function Mirror<T>(tree: Tree<T>): Tree<T> {
  if tree.Leaf? then tree else Node(Mirror(tree.right), Mirror(tree.left))
}