"""
Main view for game interaction

"""

import arcade
import arcade.gui
import state
from menu import GameController


BUTTON_WIDTH = 200
BUTTON_PADDING = 20

class PlayView(arcade.View):
    def __init__(self, controller: GameController, game_state: state.GameState):
        super().__init__()

        self.manager = arcade.gui.UIManager()
        self.manager.enable()

        # Add buttons and UI objects
        

    def on_show_view(self):
        arcade.set_background_color(arcade.color.BLACK)

    def on_draw(self):
        self.clear()


    # Add button functions