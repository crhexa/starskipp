"""
Starting view upon application start


"""

import arcade
import arcade.gui
from game import state
from game import region

BUTTON_WIDTH = 200
BUTTON_PADDING = 20


"""
Manages views and game state

"""
class GameController():

    def __init__(self, game_config):
        # set game params from config
        pass


        # start game
        self.window = arcade.get_window()
        menu_view = MainMenuView(self)
        self.window.show_view(menu_view)
        arcade.run()

    def menu_to_play(self, game_state: state.GameState):
        play_view = PlayView(self, game_state=game_state)
        self.window.show_view(play_view)
        



class TemplateView(arcade.View):
    def __init__(self, controller: GameController):
        super().__init__()

        self.manager = arcade.gui.UIManager()
        self.manager.enable()

        # Add buttons and UI objects

    def on_show_view(self):
        pass

    def on_draw(self):
        pass


    # Add button functions

    

class MainMenuView(arcade.View):
    def __init__(self, controller: GameController):
        super().__init__()
        self.controller = controller

        # Prerequisite UI objects
        self.manager = arcade.gui.UIManager()
        self.manager.enable()

        self.v_box = arcade.gui.UIBoxLayout()

        # Fetch current window context
        self.width = self.window.width
        self.height = self.window.height
        
        self.background = arcade.load_texture("resources/gui/ph_main_menu.jpg")

        # Create UI buttons
        start_button = arcade.gui.UIFlatButton(text="New Game", width=BUTTON_WIDTH)
        self.v_box.add(start_button.with_space_around(bottom=BUTTON_PADDING))
        start_button.on_click = self.click_start

        options_button = arcade.gui.UIFlatButton(text="Options", width=BUTTON_WIDTH)
        self.v_box.add(options_button.with_space_around(bottom=BUTTON_PADDING))
        # options_button.on_click = self.click_options

        quit_button = arcade.gui.UIFlatButton(text="Quit Game", width=BUTTON_WIDTH)
        self.v_box.add(quit_button.with_space_around(bottom=BUTTON_PADDING))
        quit_button.on_click = self.click_quit

        self.manager.add(
            arcade.gui.UIAnchorWidget(
                anchor_x="center_x",
                anchor_y="center_y",
                child=self.v_box))
             



    def on_show_view(self):
        arcade.set_background_color(arcade.csscolor.BLACK)

    def on_draw(self):
        self.clear()
        arcade.draw_texture_rectangle(center_x = self.width//2, center_y = self.height//2,
                                      width = 2560, height = 1700,
                                      texture=self.background)
        
        arcade.draw_text("StarSkipp", anchor_x="center", align="center", font_size=48, width=400,
                         start_x=self.width//2, start_y=(3*self.height)//4)
        
        self.manager.draw()
    
    def click_start(self, event):
        game_state = state.GameState()
        self.controller.menu_to_play(game_state=game_state)

    def click_quit(self, event):
        arcade.close_window()
        arcade.exit()


class PlayView(arcade.View):
    def __init__(self, controller: GameController, game_state: state.GameState):
        super().__init__()
        self.controller = controller
        self.game_state = game_state

        self.manager = arcade.gui.UIManager()
        self.manager.enable()

        # Add buttons and UI objects



        


        
        

    def on_show_view(self):
        arcade.set_background_color(arcade.color.BLACK)

    def on_draw(self):
        self.clear()
        self.game_state.draw_system()

    # Add button functions