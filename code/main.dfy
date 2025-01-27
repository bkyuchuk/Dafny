include "checksums.dfy"
include "coffee-maker.dfy"

module Main {
  import Checksums
  import CoffeeLibrary

  method Main() {
    var checksumGen := new Checksums.ChecksumGenerator();
    var greeting := "Hello, world!";
    var bye := "Goodbye!";
    checksumGen.Append(greeting);
    checksumGen.Append(bye);
    print "Checksum of '", greeting, "' and '", bye, "' is: ", checksumGen.Checksum(), "\n";

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