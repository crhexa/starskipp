import pyglet

# Create window
display = pyglet.canvas.get_display()
screen = display.get_default_screen()
window = pyglet.window.Window(screen = screen, caption = "StarSkipp")


# Load resources
pyglet.resource.path = ['res']


# Create draw batch
main_batch = pyglet.graphics.Batch()


# Load fonts
pyglet.font.add_directory('res/fonts')
pyglet.font.load('Heebo')


# GUI event handlers
def push_button_handler():
    quit_button_label.text = "QUITTING..."

def release_button_handler():
    quit_button_label.text = "QUIT"


# Placeholder GUI loading
frame = pyglet.gui.Frame(window, order = 4)
main_menu_bg = pyglet.resource.image('ph_main_menu.jpg')
label = pyglet.text.Label('Hello, World!',
                          font_name = 'Heebo', font_size = 48,
                          x = window.width//2, y = 3*(window.height//4), z = -1,
                          anchor_x = 'center', anchor_y = 'center',
                          batch = main_batch)

quit_button_sprite = pyglet.resource.image('ph_quit_button.png')
quit_button = pyglet.gui.PushButton(x = (window.width//2) - (quit_button_sprite.width//2), 
                                    y = (window.height//4) - (quit_button_sprite.height//2),
                                    pressed = quit_button_sprite, depressed = quit_button_sprite,
                                    batch = main_batch)

quit_button_label = pyglet.text.Label('QUIT',
                                      font_name = 'Heebo', font_size = 48,
                                      x = window.width//2, y = window.height//4, z = -1,
                                      anchor_x = 'center', anchor_y = 'center',
                                      batch = main_batch)

quit_button.set_handler('on_press', push_button_handler)
quit_button.set_handler('on_release', release_button_handler)
frame.add_widget(quit_button)

@quit_button.event('on_release')
def quit_game():
    event_loop.exit()
    window.close()

@window.event 
def on_draw():
    window.clear()
    main_menu_bg.blit(0, 0)
    main_batch.draw()

event_loop = pyglet.app.EventLoop()
pyglet.app.run()