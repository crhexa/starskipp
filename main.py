"""

"""

import arcade
from game import menu

WIDTH = 1360
HEIGHT = 768

def main():
    window = arcade.Window(WIDTH, HEIGHT, "StarSkipp")
    
    menu_view = menu.MainMenuView()
    window.show_view(menu_view)
    arcade.run()
    

if __name__ == "__main__":
    main()