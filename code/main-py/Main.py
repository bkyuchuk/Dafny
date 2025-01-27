import sys
from typing import Callable, Any, TypeVar, NamedTuple
from math import floor
from itertools import count

import module_ as module_
import _dafny as _dafny
import System_ as System_
import CoffeeLibrary as CoffeeLibrary

# Module: Main

class default__:
    def  __init__(self):
        pass

    @staticmethod
    def Main(noArgsParameter__):
        d_0_coffeeMachine_: CoffeeLibrary.CoffeeMaker
        nw0_ = CoffeeLibrary.CoffeeMaker()
        nw0_.ctor__()
        d_0_coffeeMachine_ = nw0_
        (d_0_coffeeMachine_).Restock()
        d_1_doubleEspresso_: CoffeeLibrary.Cup
        out0_: CoffeeLibrary.Cup
        out0_ = (d_0_coffeeMachine_).Dispense(True)
        d_1_doubleEspresso_ = out0_
        d_2_newGrinder_: CoffeeLibrary.Grinder
        nw1_ = CoffeeLibrary.Grinder()
        nw1_.ctor__()
        d_2_newGrinder_ = nw1_
        (d_0_coffeeMachine_).Change(d_2_newGrinder_)
        (d_0_coffeeMachine_).Restock()
        d_3_singleEspresso_: CoffeeLibrary.Cup
        out1_: CoffeeLibrary.Cup
        out1_ = (d_0_coffeeMachine_).Dispense(False)
        d_3_singleEspresso_ = out1_
        d_4_oldGrinder_: CoffeeLibrary.Grinder
        out2_: CoffeeLibrary.Grinder
        out2_ = (d_0_coffeeMachine_).RemoveGrinder()
        d_4_oldGrinder_ = out2_
        (d_0_coffeeMachine_).Restock()
        d_5_latte_: CoffeeLibrary.Cup
        out3_: CoffeeLibrary.Cup
        out3_ = (d_0_coffeeMachine_).Dispense(False)
        d_5_latte_ = out3_
        (d_4_oldGrinder_).AddBeans()

