"""
Class to store per-save game data


"""

import arcade
from game import region

class GameState():

    # Generating new GameState
    def __init__(self, save_file = None):
        self.region = region.Region()
        start = self.region.add_system("Sol", 0, 0)

        start.set_star("Sol", "G-type")
        
        
    def draw_system(self):
        system = self.region.systems[0]
        system.draw()