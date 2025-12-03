# Authors:
#     Sylvain Faure <sylvain.faure@universite-paris-saclay.fr>
#     Bertrand Maury <bertrand.maury@universite-paris-saclay.fr>
#
#     cromosim/examples/domain/domain_room.py
#
#     python domain_room.py
#
# License: GPL
# 
# Modified by Jessica Chen

"""
Create a domain based off of the MC254 floor plan. The dimensions of the
hallway are determined by photos taken of the hallway.
"""
import matplotlib.pyplot as plt
from matplotlib.lines import Line2D
from matplotlib.patches import Rectangle

from cromosim.domain import Domain
from cromosim.domain import Destination

# To create a Domain object from a background image
scale = 2/102 # not sure if necessary but might come in handy later?
dom = Domain(name='MC254hall', background='MC254hall.png', pixel_size=scale)

# OBJECTS ---------------------------------------

# To define the color for the walls
wall_color = [0, 0, 0]

# lines/rects for walls
#     Line2D(xdata, ydata, linewidth)
#     Rectangle( (anchor_x,anchor_y), width, height, angle=0, rotation_point=0 )
# bottom wall
#line = Line2D([153*scale, (153+674)*scale], [248*scale, (248)*scale], linewidth=2)
rect = Rectangle(((253)*scale, (248-6)*scale), 674*scale, 7*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)
# left wall
rect = Rectangle(( (244)*scale, 0 ), 8*scale, (22+248-6)*scale) # extend down as the hall
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color) 
rect = Rectangle(((244)*scale, (248-6)*scale), 8*scale, 22*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)
rect = Rectangle(((244)*scale, (248-6+24+45)*scale), 8*scale, 286*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)
rect = Rectangle(((244)*scale, (248-6+24+45+288+45)*scale), 8*scale, 21*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)
# top wall
rect = Rectangle(((153-7+100)*scale, (248-6+24+45+288+45+15)*scale), 742*scale, 8*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)
rect = Rectangle(((153-7+742-29+100)*scale, (248-6+24+45+288+45+15-8)*scale), 29*scale, 8*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)
# right wall
rect = Rectangle(((153-7+742-9+100)*scale, (248-6+24+45+288+45+15-8-335)*scale), 9*scale, 335*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)
rect = Rectangle(((153+673+100)*scale, (248-6)*scale), 8*scale, 82*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)

# Seats
# - added 5 to block off the tiny gaps near the wall just in case
#   those cause problems
# longer (top row) seats
#     Rectangle( (anchor_x,anchor_y), width, height, angle=0, rotation_point=0 )
for i in range(0, 12):
    rect = Rectangle(((296+(17+28)*i+100)*scale, (463)*scale), 17*scale, (193+5)*scale)
    dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)
rect = Rectangle(((296+(17+28)*12+100)*scale, (463)*scale), 17*scale, 158*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)
# shorter (bottom row) seats
for i in range(0, 11):
    rect = Rectangle(((296+(17+28)*i+100)*scale, (251-5)*scale), 17*scale, (157+5)*scale)
    dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)
rect = Rectangle(((296+(17+28)*11+100)*scale, (251+87)*scale), (17)*scale, (70)*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)

# Block off back door
#     Line2D(xdata, ydata, linewidth)
line = Line2D([(153+673+9+100)*scale, (153+673+9+46+100)*scale], [(268+54)*scale, (268+54)*scale], linewidth=2)
dom.add_shape(line, outline_color=wall_color, fill_color=wall_color)

# Other obstacles
#     Rectangle( (anchor_x,anchor_y), width, height, angle=0, rotation_point=0 )
# - chalkboard
rect = Rectangle(((152+100)*scale, (318)*scale), (5)*scale, (240)*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)
# - podium, desk, and accessible desk up front
rect = Rectangle(((207+100)*scale, (545)*scale), (39)*scale, (43)*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)
rect = Rectangle(((207+100)*scale, (383)*scale), (39)*scale, (108)*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)
rect = Rectangle(((225+100)*scale, (323)*scale), (21)*scale, (27)*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)


# To define the color for the issue of the room
door_color = [255, 0, 0]

# Hallway doors --> destination for group moving out
#     Line2D(xdata, ydata, linewidth)
line = Line2D([(153-7+100-7)*scale-((0.27/693)*341 + 0.75 + (671.9/1591.5)*0.422)+(6*scale)-(75/346)-(4277/5536), (153-7+100-7)*scale-((0.27/693)*341 + 0.75 + (671.9/1591.5)*0.422)+(6*scale)-(75/346)], [(248-6+24+45+288+45+15)*scale-(220/280551)*2546.9+3*scale, (248-6+24+45+288+45+15)*scale-(220/280551)*2546.9+3*scale], linewidth=2)
dom.add_shape(line, outline_color=door_color, fill_color=door_color)
# not sure if 2 destinations works like this
line = Line2D([(153-7+100-7)*scale-((0.27/693)*341 + 0.75 + (671.9/1591.5)*0.422)+(6*scale)-(75/346)-2*(4277/5536)-(35/692), (153-7+100-7)*scale-((0.27/693)*341 + 0.75 + (671.9/1591.5)*0.422)+(6*scale)-(75/346)-(4277/5536)-(35/692)], [(248-6+24+45+288+45+15)*scale-(220/280551)*2546.9+3*scale, (248-6+24+45+288+45+15)*scale-(220/280551)*2546.9+3*scale], linewidth=2)
dom.add_shape(line, outline_color=door_color, fill_color=door_color)

# build the hall ~~~~~
#     Rectangle( (anchor_x,anchor_y), width, height, angle=0, rotation_point=0 )

# nook thing top wall
rect = Rectangle(((153-7+100)*scale-((0.27/693)*341 + 0.75 + (671.9/1591.5)*0.422), (248-6+24+45+288+45+15)*scale), ((0.27/693)*341 + 0.75 + (671.9/1591.5)*0.422), 8*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)
# nook thing side wall
rect = Rectangle(((153-7+100-7)*scale-((0.27/693)*341 + 0.75 + (671.9/1591.5)*0.422), (248-6+24+45+288+45+15)*scale-(220/280551)*2546.9), 6*scale, (220/280551)*2546.9+8*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)

# wall with the hallway doors
# right columns
rect = Rectangle(((153-7+100-7)*scale-((0.27/693)*341 + 0.75 + (671.9/1591.5)*0.422)+(6*scale)-(75/346), (248-6+24+45+288+45+15)*scale-(220/280551)*2546.9), 75/346, 6*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)
# middle column
rect = Rectangle(( (153-7+100-7)*scale-((0.27/693)*341 + 0.75 + (671.9/1591.5)*0.422)+(6*scale)-(75/346)-(4277/5536)-(35/692), (248-6+24+45+288+45+15)*scale-(220/280551)*2546.9), 35/692, 6*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)
# left corner thing
rect = Rectangle(( 239*scale-((0.27/693)*341 + 0.75 + (671.9/1591.5)*0.422)+(6*scale)-(75/346)-2*(4277/5536)-(35/692)-(105/1384), (248-6+24+45+288+45+15)*scale-(220/280551)*2546.9), 105/1384, 6*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)
rect = Rectangle(( 239*scale-((0.27/693)*341 + 0.75 + (671.9/1591.5)*0.422)+(6*scale)-(75/346)-2*(4277/5536)-(35/692)-(105/1384)-6*scale, (248-6+24+45+288+45+15)*scale-(220/280551)*2546.9-15/173 ), 6*scale, 15/173+6*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)

# last bit until end of hall
rect = Rectangle(( (244)*scale-1143/350, (248-6+24+45+288+45+15)*scale-(220/280551)*2546.9-15/173 ), 14*scale, 6*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)
# extend to bottom of image
rect = Rectangle(( (244)*scale-1143/350-6*scale, 0 ), 6*scale, 559*scale)
dom.add_shape(rect, outline_color=wall_color, fill_color=wall_color)

# ~~~~


# PUT IT ALL TOGETHER ---------------------------------------

# To build the domain :
dom.build_domain()

# To plot the domain : backgroud + added shapes
dom.plot(id=1, title="Domain")

# To create a Destination object towards the door
dest = Destination(name='door', colors=[door_color],
                   excluded_colors=[wall_color])
dom.add_destination(dest)

# To plot the wall distance and its gradient
dom.plot_wall_dist(id=2, step=20,
                   title="Distance to walls and its gradient",
                   savefig=False, filename="mc254_wall_distance.png")

# To plot the distance to the red door and the correspondant
# desired velocity
dom.plot_desired_velocity('door', id=3, step=20,
                          title="Distance to the destination and desired velocity",
                          savefig=False, filename="mc254_desired_velocity.png")

print("===> Domain: ", dom)

plt.show()
