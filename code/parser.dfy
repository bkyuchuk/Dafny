datatype Operation = Multiplication | Addition

datatype List<Expression> = Nil | Cons(head: Expression, tail: List<Expression>)

datatype Expression = Constant(nat) |
                      Variable(identifier: string) |
                      Node(operation: Operation, args: List<Expression>)

function Evaluate(expression: Expression, env: map<string, nat>): nat
  requires IsDeclared(expression, env) {
  match expression
  case Constant(value) => value
  case Variable(identifier) => env[identifier]
  case Node(operation, args) => EvaluateMany(operation, args, env)
}

function EvaluateMany(operation: Operation, args: List<Expression>, env: map<string, nat>): nat
  requires AreDeclared(args, env)
  decreases args {
  match args
  case Nil => match operation { case Addition => 0 case Multiplication => 1}
  case Cons(current, remaining) =>
    var value, rest := Evaluate(current, env), EvaluateMany(operation, remaining, env);
    match operation {
      case Addition => value + rest
      case Multiplication => value * rest
    }
}

predicate IsDeclared(expression: Expression, env: map<string, nat>) {
  match expression
  case Variable(name) => name in env.Keys
  case Node(_, remaining) => AreDeclared(remaining, env)
  case Const => true
}

predicate AreDeclared(expressions: List<Expression>, env: map<string ,nat>) {
  match expressions
  case Nil => true
  case Cons(current, remaining) => IsDeclared(current, env) && AreDeclared(remaining, env)
}

method Main() {
  // 10 * (x + 7 * y)
  var expr := Node(Multiplication,
                   Cons(Constant(10),
                        Cons(Node(Addition,
                                  Cons(Variable("x"),
                                       Cons(Node(Multiplication,
                                                 Cons(Constant(7),
                                                      Cons(Variable("y"),
                                                           Nil))),
                                            Nil))),
                             Nil)));
    
    //var result := Evaluate(expr, map[]);
    var result := Evaluate(expr, map["x" := 3, "y" := 10]);
    assert result == 730;
}