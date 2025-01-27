import sys
from typing import Callable, Any, TypeVar, NamedTuple
from math import floor
from itertools import count

import module_ as module_
import _dafny as _dafny
import System_ as System_

# Module: CoffeeLibrary


class Grinder:
    def  __init__(self):
        self.hasBeans: bool = False
        pass

    def __dafnystr__(self) -> str:
        return "CoffeeLibrary.Grinder"
    def ctor__(self):
        (self).hasBeans = False

    def AddBeans(self):
        (self).hasBeans = True

    def Grind(self):
        (self).hasBeans = False


class WaterTank:
    def  __init__(self):
        self.level: int = int(0)
        pass

    def __dafnystr__(self) -> str:
        return "CoffeeLibrary.WaterTank"
    def ctor__(self):
        (self).level = 0

    def Fill(self):
        (self).level = 5

    def Use(self):
        (self).level = (self.level) - (1)


class Cup:
    def  __init__(self):
        pass

    def __dafnystr__(self) -> str:
        return "CoffeeLibrary.Cup"
    def ctor__(self):
        _dafny.print((_dafny.SeqWithoutIsStrInference(map(_dafny.CodePoint, "Enjoy your coffee!"))).VerbatimString(False))
        _dafny.print((_dafny.SeqWithoutIsStrInference(map(_dafny.CodePoint, "\n"))).VerbatimString(False))


class CoffeeMaker:
    def  __init__(self):
        self.grinder: Grinder = None
        self.waterTank: WaterTank = None
        pass

    def __dafnystr__(self) -> str:
        return "CoffeeLibrary.CoffeeMaker"
    def ctor__(self):
        nw0_ = Grinder()
        nw0_.ctor__()
        (self).grinder = nw0_
        nw1_ = WaterTank()
        nw1_.ctor__()
        (self).waterTank = nw1_

    def Ready(self):
        return ((2) <= (self.waterTank.level)) and (self.grinder.hasBeans)

    def Restock(self):
        (self.grinder).AddBeans()
        (self.waterTank).Fill()

    def Dispense(self, double):
        cup: Cup = None
        (self.grinder).Grind()
        if double:
            (self.waterTank).Use()
            (self.waterTank).Use()
        elif True:
            (self.waterTank).Use()
        nw0_ = Cup()
        nw0_.ctor__()
        cup = nw0_
        return cup

    def RemoveGrinder(self):
        previous: Grinder = None
        previous = self.grinder
        nw0_ = Grinder()
        nw0_.ctor__()
        (self).grinder = nw0_
        return previous

    def Change(self, custom):
        (self).grinder = custom

