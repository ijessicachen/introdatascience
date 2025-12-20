# Authors:
#     Sylvain Faure <sylvain.faure@universite-paris-saclay.fr>
#     Bertrand Maury <bertrand.maury@universite-paris-saclay.fr>
# License: GPL
# 

"""
Modified by:
    Jessica Chen <jessi.chen@mail.utoronto.ca>

Edit plot_people to plot labels for specific agents.  

KEY NOTES
- the the labels are only plot for specific agents
  at the initialization of the simulation to identify
  which agents will have their velocity tracked. The 
  selection of agents and velocity plots are handled
  in `MC254_social.py`
- the figures for these plots are always saved as
  `agents.png` under the results folder for that 
  simulation (`dd_results4`, `norm_results11`, etc)
"""

import numpy as np
import sys
import matplotlib.pyplot as plt

from matplotlib.patches import Arrow
from matplotlib.lines import Line2D
from matplotlib.collections import EllipseCollection, LineCollection

def plot_people(ifig, dom, people, contacts, colors, time=-1, axis=None,
                virtual_people=None, plot_people=True, plot_contacts=True,
                plot_velocities=False, plot_desired_velocities=False,
                plot_paths=False, plot_sensors=False,
                sensors=[], savefig=False, filename='fig.png', dpi=150,
                cmap='winter', plot_labels=False, ag=None):
    """
    This function draws spheres for the individuals, \
    lines for the active contacts and arrows for the \
    (desired or real) velocities. It will also label \
    people with their current array index if chosen \
    to do so.

    Parameters
    ----------
    ifig: int
        figure number
    dom: Domain
        contains everything for managing the domain
    people: dict
        contains everything concerning people: ``x, y, r, v, U,...``
    contacts: numpy array
        all the contacts: ``i, j, dij, eij_x, eij_y``
    colors: numpy array
        scalar field used to define people colors
    time: float
        time in seconds
    virtual_people: dict
        contains everything concerning virtual people: ``x, y, r,...``
    axis: numpy array
        matplotlib axis: ``[xmin, xmax, ymin, ymax]``
    plot_people: boolean
        draws spheres for people if true
    plot_paths: boolean
        draws people paths if true
    plot_sensors: boolean
        draws sensor lines if true
    sensors: numpy array
        sensor line coordinates (see also the sensor function below)
    savefig: boolean
        writes the figure as a png file if true
    filename: string
        png filename used to write the figure
    dpi: integer
        number of pixel per inch for the saved figure
    cmap: string
        matplotlib colormap name
    plot_labels: boolean
        plots a label on the person corresponding to ag if true
    ag: numpy array
        what labels to plot, must be same size as the people dict. \
        I use this to plot the person's intial array index.
    """
    fig = plt.figure(ifig)
    plt.clf()
    ax1 = fig.add_subplot(111)
    # Domain
    ax1.imshow(dom.image, interpolation='nearest',
               extent=[dom.xmin, dom.xmax, dom.ymin, dom.ymax], origin='lower')
    if (plot_people):
        try:
            # People
            offsets = people["xyrv"][:, :2]
            ec = EllipseCollection(widths=2*people["xyrv"][:, 2],
                                   heights=2*people["xyrv"][:, 2],
                                   angles=0, units='xy',
                                   cmap=plt.get_cmap(cmap),
                                   offsets=offsets, transOffset=ax1.transData)
            ec.set_array(colors)
            ax1.add_collection(ec)

            # Labels
            # will assume they're not virtual people
            if (plot_labels):
                x = people["xyrv"][:, 0]
                y = people["xyrv"][:, 1]
                for i in range(len(x)):
                    #print("AG:", ag)
                    #print("AG[i]:", ag[i])
                    ax1.text(
                      x[i], y[i],
                      str(ag[i]),          # or people["id"][ip]
                      fontsize=8,
                      ha='center',
                      va='center'
                    )


        except:
            pass
        try:
            # Virtual people
            offsets = virtual_people["xyrv"][:, :2]
            ecv = EllipseCollection(widths=2*virtual_people["xyrv"][:, 2],
                                    heights=2*virtual_people["xyrv"][:, 2],
                                    angles=0, units='xy',
                                    facecolors='black',
                                    alpha=0.5,
                                    offsets=offsets, transOffset=ax1.transData)
            ax1.add_collection(ecv)
        except:
            pass
    if (plot_contacts):
        try:
            if (virtual_people["xyrv"] is not None):
                xyrv = np.concatenate((people["xyrv"], virtual_people["xyrv"]))
            else:
                xyrv = people["xyrv"]
            # Contacts
            Nc = contacts.shape[0]
            if (Nc > 0):
                for ic in np.arange(Nc):
                    i = np.int64(contacts[ic, 0])
                    j = np.int64(contacts[ic, 1])
                    if (j != -1):
                        line = Line2D([xyrv[i, 0], xyrv[j, 0]],
                                      [xyrv[i, 1], xyrv[j, 1]],
                                      lw=1., alpha=0.6, color='k')
                    else:
                        line = Line2D([xyrv[i, 0],
                                       xyrv[i, 0] - (xyrv[i, 2] + contacts[ic, 2])*contacts[ic, 3]],
                                      [xyrv[i, 1],
                                       xyrv[i, 1] - (xyrv[i, 2] + contacts[ic, 2])*contacts[ic, 4]],
                                      lw=1., alpha=0.6, color='k')
                    ax1.add_line(line)
        except:
            pass
    if (plot_velocities):
        try:
            # Velocities
            Np = people["xyrv"].shape[0]
            for ip in np.arange(Np):
                arrow = Arrow(people["xyrv"][ip, 0],
                              people["xyrv"][ip, 1],
                              people["U"][ip, 0],
                              people["U"][ip, 1],
                              width=0.3, color="red")
                ax1.add_patch(arrow)
            if (virtual_people["xyrv"] is not None):
                Np = virtual_people["xyrv"].shape[0]
                for ip in np.arange(Np):
                    arrow = Arrow(virtual_people["xyrv"][ip, 0],
                                  virtual_people["xyrv"][ip, 1],
                                  virtual_people["U"][ip, 0],
                                  virtual_people["U"][ip, 1],
                                  width=0.3, color="red", alpha=0.6)
                    ax1.add_patch(arrow)
        except:
            pass
    if (plot_desired_velocities):
        try:
            # Velocities
            Np = people["xyrv"].shape[0]
            for ip in np.arange(Np):
                arrow = Arrow(people["xyrv"][ip, 0],
                              people["xyrv"][ip, 1],
                              people["Vd"][ip, 0],
                              people["Vd"][ip, 1],
                              width=0.3, color="blue")
                ax1.add_patch(arrow)
            if (virtual_people["xyrv"] is not None):
                Np = virtual_people["xyrv"].shape[0]
                for ip in np.arange(Np):
                    arrow = Arrow(virtual_people["xyrv"][ip, 0],
                                  virtual_people["xyrv"][ip, 1],
                                  virtual_people["Vd"][ip, 0],
                                  virtual_people["Vd"][ip, 1],
                                  width=0.3, color="blue", alpha=0.6)
                    ax1.add_patch(arrow)
        except:
            pass
    if (plot_paths):
        pathlines = []
        for ip, pid in enumerate(people["paths"]):
            pathlines.append(np.reshape(people["paths"][pid], (-1, 2)))
        pathlinecoll = LineCollection(pathlines, color="black",
                                      linewidths=0.5, linestyle="solid", alpha=0.5,
                                      cmap=plt.get_cmap(cmap))
        # pathlinecoll.set_array(colors)
        ax1.add_collection(pathlinecoll)
    if (plot_sensors):
        for ss in sensors:
            line = Line2D(ss["line"][::2], ss["line"][1::2],
                          lw=1., alpha=0.6, color='g')
            ax1.add_line(line)
    if (axis):
        ax1.set_xlim(axis[0], axis[1])
        ax1.set_ylim(axis[2], axis[3])
    ax1.set_xticks([])
    ax1.set_yticks([])
    ax1.axis('off')
    if (time >= 0):
        ax1.set_title('time = {:.2F}'.format(time)+' s')
    fig.canvas.draw()
    if (savefig):
        fig.savefig(filename, dpi=dpi, bbox_inches='tight', pad_inches=0)
