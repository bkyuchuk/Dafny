function Average(a: int, b: int): int
  requires 0 <= a && 0 <= b {
  (a + b) / 2
}

method Triple(x: int) returns (r: int)
  requires 0 <= x
  ensures 0 <= r && Average(r, 3 * x) == 3 * x {
  var y := 2 * x;
  r := x + y;
}

predicate IsEven(x: int) {
  x % 2 == 0
}

//Important!
// method IllegalAssignment() returns (y: int) {
//     ghost var x := 10;
//     y := 2 * x;
// }

// Important!
ghost method DoubleQuadruple(x: int) returns (a: int, b: int)
  ensures a == 2 * x && b == 4 * x {
  a := 2 * x;
  b := 2 * a;
}
