# directly from here: https://pythonprogramming.altervista.org/png-to-gif/
from PIL import Image
import glob

# Create the frames
frames = []
imgs = glob.glob("MC254*.png")
for i in imgs:
    new_frame = Image.open(i)
    frames.append(new_frame)
frames.pop()

# Save into a GIF file that loops forever
frames[0].save('norm_result4.gif', format='GIF',
               append_images=frames[1:],
               save_all=True,
               duration=500, loop=0)
