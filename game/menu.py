"""

"""

import arcade
import arcade.gui

BUTTON_WIDTH = 200
BUTTON_PADDING = 20

class TemplateView(arcade.View):
    def __init__(self):
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
    def __init__(self):
        super().__init__()

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
        print("Starting...")

    def click_quit(self, event):
        arcade.close_window()
        arcade.exit()

    