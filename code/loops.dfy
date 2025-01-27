ghost function Power(n: nat): nat {
  if n == 0 then 1 else 2 * Power(n - 1)
}

method ComputePower(n: nat) returns (p: nat)
  ensures p == Power(n)
{
  p := 1;
  var i := 0;
  while i != n
    invariant 0 <= i <= n
    invariant p == Power(i)
  {
    p := 2 * p;
    i := i + 1;
  }
}

method SquareRoot(N: nat) returns (r: nat)
  ensures r * r <= N < (r + 1) * (r + 1)
{
  r := 0;
  while (r + 1) * (r + 1) <= N
    invariant r * r <= N
  {
    r := r + 1;
  }
}
