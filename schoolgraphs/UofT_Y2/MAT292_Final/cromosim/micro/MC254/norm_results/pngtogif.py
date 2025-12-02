# directly from here: https://pythonprogramming.altervista.org/png-to-gif/
from PIL import Image
import glob

# Create the frames
frames = []
imgs = glob.glob("*.png")
for i in imgs:
    new_frame = Image.open(i)
    frames.append(new_frame)
frames.pop()

# Save into a GIF file that loops forever

# eventually caculate duration so each frame lasts 1 second
#   because right now that is the time of each frame

frames[0].save('png_to_gif.gif', format='GIF',
               append_images=frames[1:],
               save_all=True,
               duration=350, loop=0)