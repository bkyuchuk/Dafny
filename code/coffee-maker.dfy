module CoffeeLibrary {
  class Grinder {
    var hasBeans: bool
    ghost var Repr: set<object> // Representation state of obj

    constructor()
      ensures Valid() && fresh(Repr) { // Guarantee fresh object upon creation
      hasBeans := false;
      Repr := {this};
    }

    ghost predicate Valid() // Object invariant
      reads this, Repr
      ensures Valid() ==> this in Repr {
      this in Repr && (hasBeans == false || true)
    }

    method AddBeans()
      requires Valid()
      modifies Repr
      ensures Valid() && fresh(Repr - old(Repr)) && hasBeans {
      hasBeans := true;
    }

    method Grind()
      requires Valid() && hasBeans
      modifies Repr
      ensures Valid() && fresh(Repr - old(Repr)) && hasBeans == false {
      hasBeans := false;
    }
  }

  class WaterTank {
    var level: nat
    ghost var Repr: set<object>

    constructor()
      ensures Valid() && fresh(Repr) {
      level := 0;
      Repr := {this};
    }

    ghost predicate Valid()
      reads this, Repr
      ensures Valid() ==> this in Repr {
      this in Repr
    }

    method Fill()
      requires Valid()
      modifies Repr
      ensures Valid() && fresh(Repr - old(Repr)) && level == 5 {
      level := 5;
    }

    method Use()
      requires Valid() && level > 0
      modifies Repr
      ensures Valid() && fresh(Repr - old(Repr)) && level == old(level) - 1 {
      level := level - 1;
    }
  }

  class Cup {
    constructor() {
      print "Enjoy your coffee!", "\n";
    }
  }

  class CoffeeMaker {
    var grinder: Grinder
    var waterTank: WaterTank

    ghost var Repr: set<object>

    // constituent objects
    constructor()
      ensures Valid() && fresh(Repr) {
      grinder := new Grinder();
      waterTank := new WaterTank();
      new;
      Repr := {this, grinder, waterTank} + grinder.Repr + waterTank.Repr;
    }

    ghost predicate Valid()
      reads this, Repr
      ensures Valid() ==> this in Repr {
      this in Repr &&
      grinder in Repr && grinder.Repr <= Repr && this !in grinder.Repr && grinder.Valid() &&
      waterTank in Repr && waterTank.Repr <= Repr && this !in waterTank.Repr && waterTank.Valid() &&
      grinder.Repr !! waterTank.Repr
    }

    predicate Ready()
      requires Valid()
      reads Repr
      ensures Valid() {
      2 <= waterTank.level && grinder.hasBeans
    }

    method Restock()
      requires Valid()
      modifies Repr
      ensures Valid() && fresh(Repr - old(Repr)) && Ready() {
      grinder.AddBeans();
      waterTank.Fill();
      Repr := Repr + grinder.Repr + waterTank.Repr;
    }

    method Dispense(double: bool) returns (cup: Cup)
      requires Valid() && Ready()
      modifies Repr
      ensures Valid() && fresh(Repr - old(Repr)) {
      grinder.Grind();
      if double {
        waterTank.Use();
        waterTank.Use();
      } else {
        waterTank.Use();
      }
      cup := new Cup();
      Repr := Repr + grinder.Repr + waterTank.Repr;
    }

    method RemoveGrinder() returns (previous: Grinder)
      requires Valid()
      modifies Repr
      ensures Valid() && previous.Valid() && fresh(Repr - old(Repr)) && previous.Repr == old(grinder.Repr)
      ensures previous !in Repr && this !in previous.Repr && previous.Repr !! waterTank.Repr {
      previous := grinder;
      grinder := new Grinder();
      Repr := Repr - { previous } - previous.Repr;
      Repr := Repr + { grinder } + grinder.Repr;
    }

    method Change(custom: Grinder)
      requires Valid() && custom.Valid()
      requires this !in custom.Repr && custom.Repr !! waterTank.Repr
      modifies Repr
      ensures Valid() && fresh(Repr - old(Repr) - { custom } - custom.Repr) {
      Repr := Repr - { grinder } - grinder.Repr;
      grinder := custom;
      Repr := Repr + { custom } + custom.Repr;
    }
  }
}