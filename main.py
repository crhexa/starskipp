import pyglet

# Create window
display = pyglet.canvas.get_display()
screen = display.get_default_screen()
window = pyglet.window.Window(screen=screen)

# Load resources
pyglet.resource.path = ['res']


# Load fonts
pyglet.font.add_directory('res/fonts')
pyglet.font.load('Heebo')

main_menu_bg = pyglet.resource.image('ph_main_menu.jpg')
label = pyglet.text.Label('Hello, World!',
                          font_name = 'Heebo', font_size = 48,
                          x = window.width//2, y = 3*(window.height//4),
                          anchor_x = 'center', anchor_y = 'center')

quit_button_sprite = pyglet.resource.image('ph_quit_button.png')
quit_button = pyglet.gui.PushButton(x = window.width//2, 
                                    y = window.height//4,
                                    pressed = quit_button_sprite, depressed = quit_button_sprite)

quit_button_label = pyglet.text.Label('QUIT',
                                      font_name = 'Heebo', font_size = 48,
                                      x = window.width//2, y = window.height//4,
                                      anchor_x = 'center', anchor_y = 'center')


@quit_button.event
def on_mouse_release():
    quit()
    
@window.event 
def on_draw():
    window.clear()
    main_menu_bg.blit(0, 0)
    label.draw()

    quit_button_label.draw()

pyglet.app.run()