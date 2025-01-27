include "coffee-maker.dfy"

// Important!
module Main {
  import CoffeeLibrary

  method Main() {
    var coffeeMachine := new CoffeeLibrary.CoffeeMaker();
    //var cappuccino := coffeeMachine.Dispense(false);
    coffeeMachine.Restock();
    var doubleEspresso := coffeeMachine.Dispense(true);

    var newGrinder := new CoffeeLibrary.Grinder();
    coffeeMachine.Change(newGrinder);
    coffeeMachine.Restock();
    var singleEspresso := coffeeMachine.Dispense(false);

    var oldGrinder := coffeeMachine.RemoveGrinder();
    coffeeMachine.Restock();
    var latte := coffeeMachine.Dispense(false);
    oldGrinder.AddBeans();
  }
}