"""
A region is group of stars in relatively close proximity.

"""

class Region():
    def __init__(self):
        self.systems = []

    
    def add_system(self, name, x, y):
        system = System(name, x, y)
        system.region = self
        self.systems.append(system)




"""
A system consists of a star along with any orbiting objects.

"""
class System():
    def __init__(self, name: str, x: float, y: float):
        self.name = name
        self.x = x
        self.y = y

        self.star = None
        self.region = None
        self.bodies = []
    

    def set_star(self, name, type):
        self.star = Star(name, type)







"""
A star is the central body of which all stellar objects orbit

"""
class Star():
    def __init__(self, name: str, type: str):
        self.name = name
        self.type = type

    
    
"""
Abstract class representing any object orbiting a star

"""
class StarObject():
    def __init__(self, x: float, y: float):
        self.x = x
        self.y = y


