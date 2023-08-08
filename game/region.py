"""
Static objects to serve as game levels

"""
import arcade


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

        return system




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
        self.objects = []
    

    def set_star(self, name, type):
        self.star = Star(name, type)


    def draw(self):
        self.star.draw(400, 400)
        for body in self.objects:
            body.draw()




"""
A star is the central body of which all stellar objects orbit

"""
class Star():
    def __init__(self, name: str, type: str):
        self.name = name
        self.type = type

    def draw(self, x, y):
        arcade.draw_circle_filled(x, y, 200, 
                                  arcade.color.YELLOW_ORANGE)

    
    
"""
Abstract class representing any object orbiting a star

"""
class StarObject():
    def __init__(self, x: float, y: float):
        self.x = x
        self.y = y

    def draw():
        # arcade.draw_circle_filled()
        pass


