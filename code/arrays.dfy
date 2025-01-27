method MultiDimensionalArrays() {
  var m := new bool[3, 10];
  m[0, 9] := true;
  m[1, 8] := false;
  assert m.Length0 == 3 && m.Length1 == 10;
}

method Sequences() {
  var greetings := ["hey", "hola", "tjena"];

  assert [1, 5, 12] + [22, 35] == [1, 5, 12, 22, 35];

  var p := [1, 5, 12, 22, 35];
  assert p[2..4] == [12, 22];
  assert p[..2] == [1, 5];
  assert p[2..] == [12, 22, 35];

  assert greetings[..1] == ["hey"];
  assert greetings[1..2] == ["hola"];
}

// Important!
method UpdateElements(a: array<int>)
  requires a.Length == 10
  modifies a
  ensures old(a[4]) < a[4]
  ensures a[6] <= old(a[6])
  ensures a[8] == old(a[8])
{
  a[4], a[8] := a[4] + 3, a[8] + 1;
  a[7], a[8] := 516, a[8] - 1;
}

// Important!
method NewArray() returns (a: array<int>)
  ensures fresh(a) && a.Length == 20
{
  a := new int[20];
  var b := new int[30];
  a[6] := 216;
  b[7] := 343;
}

method Caller() {
  var a := NewArray();
  a[8] := 512;
}

// Important!
predicate IsZeroArray(a: array<int>, lo: int, hi: int)
  requires 0 <= lo <= hi <= a.Length
  reads a
  decreases hi - lo
{
  lo == hi || (a[lo] == 0 && IsZeroArray(a, lo + 1, hi))
}