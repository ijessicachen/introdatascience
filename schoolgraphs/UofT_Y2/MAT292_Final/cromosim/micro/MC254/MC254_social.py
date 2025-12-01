# Authors:
#     Sylvain Faure <sylvain.faure@universite-paris-saclay.fr>
#     Bertrand Maury <bertrand.maury@universite-paris-saclay.fr>
#
#      cromosim/examples/micro/social/micro_social.py
#      python micro_social.py --json input.json
#
# License: GPL
#
# Modified by: 
#      Jessica Chen <jessi.chen@mail.utoronto.ca>
# 
# Remember to first install cromosim:
#      pip install cromosim
# Launch Command:
#      python MC254_social.py --json input_MC254.json

import sys
import os
import json
from optparse import OptionParser
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Circle, Ellipse, Rectangle, Polygon
from matplotlib.lines import Line2D

from cromosim.domain import Domain
from cromosim.domain import Destination
from cromosim.micro import people_initialization, plot_people, plot_sensors
from cromosim.micro import find_duplicate_people, compute_contacts
from cromosim.micro import compute_forces, move_people, people_update_destination

from MC254_domain import dom

plt.ion()

"""
    python micro_social.py --json input.json
"""
parser = OptionParser(usage="usage: %prog [options] filename", version="%prog 1.0")
parser.add_option('--json', dest="jsonfilename", default="input.json",
                  type="string",
                  action="store", help="Input json filename")
opt, remainder = parser.parse_args()
print("===> JSON filename = ", opt.jsonfilename)
with open(opt.jsonfilename) as json_file:
    try:
        input = json.load(json_file)
    except json.JSONDecodeError as msg:
        print(msg)
        print("Failed to load json file ", opt.jsonfilename)
        print("Check its content \
            (https://fr.wikipedia.org/wiki/JavaScript_Object_Notation)")
        sys.exit()

"""
    Get parameters from json file : """

prefix = input["prefix"]
if not os.path.exists(prefix):
    os.makedirs(prefix)
seed = input["seed"]
with_graphes = input["with_graphes"]
# build domains directly in python
#json_domains = input["domains"]
# print("===> JSON data used to build the domains : ",json_domains)
json_people_init = input["people_init"]
print("===> JSON data used to create the groups : ",json_people_init)
json_sensors = input["sensors"]
# print("===> JSON data used to create sensors : ",json_sensors)
Tf = input["Tf"]
dt = input["dt"]
drawper = input["drawper"]
mass = input["mass"]
tau = input["tau"]
F = input["F"]
kappa = input["kappa"]
delta = input["delta"]
Fwall = input["Fwall"]
lambda_ = input["lambda"]
eta = input["eta"]
projection_method = input["projection_method"]
dmax = input["dmax"]
dmin_people = input["dmin_people"]
dmin_walls = input["dmin_walls"]
plot_p = input["plot_people"]
plot_c = input["plot_contacts"]
plot_v = input["plot_velocities"]
plot_vd = input["plot_desired_velocities"]
plot_pa = input["plot_paths"]
plot_s = input["plot_sensors"]
plot_pa = input["plot_paths"]
print("===> Final time, Tf = ", Tf)
print("===> Time step, dt = ", dt)
print("===> To draw the results each drawper iterations, \
      drawper = ", drawper)
print("===> Maximal distance to find neighbors, dmax = ",
      dmax, ", example : 2*dt")
print("===> ONLY used during initialization ! Minimal distance between \
      persons, dmin_people = ", dmin_people)
print("===> ONLY used during initialization ! Minimal distance between a \
      person and a wall, dmin_walls = ", dmin_walls)

"""
    Build the Domain objects
    - bring in from another Python file (really questionable rn)
"""
domains = {}
domains['MC254'] = dom
print("===> All domains = ", domains)

"""
    To create the sensors to measure the pedestrian flows
"""

all_sensors = {}
for domain_name in domains:
    all_sensors[domain_name] = []
for s in json_sensors:
    s["id"] = []
    s["times"] = []
    s["xy"] = []
    s["dir"] = []
    all_sensors[s["domain"]].append(s)
    # print("===> All sensors = ",all_sensors)

"""
    Initialization
"""

# Current time
t = 0.0
counter = 0

# Initialize people
all_people = {}
for i, peopledom in enumerate(json_people_init):
    dom = domains[peopledom["domain"]]
    groups = peopledom["groups"]
    print("===> Group number ", i, ", domain = ", peopledom["domain"])
    people = people_initialization(
        dom, groups, dt,
        dmin_people=dmin_people, dmin_walls=dmin_walls, seed=seed,
        itermax=10, projection_method=projection_method, verbose=True)
    I, J, Vd = dom.people_desired_velocity(
        people["xyrv"],
        people["destinations"])
    people["Vd"] = Vd
    for ip, pid in enumerate(people["id"]):
        people["paths"][pid] = people["xyrv"][ip, :2]
    contacts = None
    if (with_graphes):
        colors = people["xyrv"][:, 2]
        plot_people(100*i+20, dom, people, contacts, colors, time=t,
                    plot_people=plot_p, plot_contacts=plot_c,
                    plot_velocities=plot_v, plot_desired_velocities=plot_vd,
                    plot_sensors=plot_s, sensors=all_sensors[dom.name],
                    savefig=True, filename=prefix+dom.name+'_fig_' +
                    str(counter).zfill(6)+'.png')
    all_people[peopledom["domain"]] = people

# print the box bc I need to see how it works
# print("===> All people = ",all_people)

"""
    Main loop
"""

cc = 0
draw = True

while (t < Tf):

    print("\n===> Time = "+str(t))

    # Compute people desired velocity
    for idom, name in enumerate(domains):
        print("===> Compute desired velocity for domain ", name)
        dom = domains[name]
        people = all_people[name]
        I, J, Vd = dom.people_desired_velocity(
            people["xyrv"],
            people["destinations"])
        people["Vd"] = Vd
        people["I"] = I
        people["J"] = J

    # Look at if there are people in the transit boxes
    print("===> Find people who have to be duplicated")
    virtual_people = find_duplicate_people(all_people, domains)
    # print("     virtual_people : ",virtual_people)

    # Social forces
    for idom, name in enumerate(domains):
        print("===> Compute social forces for domain ", name)
        dom = domains[name]
        people = all_people[name]

        try:
            xyrv = np.concatenate(
                (people["xyrv"], virtual_people[name]["xyrv"]))
            Vd = np.concatenate(
                (people["Vd"], virtual_people[name]["Vd"]))
            Uold = np.concatenate(
                (people["Uold"], virtual_people[name]["Uold"]))
        except:
            xyrv = people["xyrv"]
            Vd = people["Vd"]
            Uold = people["Uold"]

        if (xyrv.shape[0] > 0):

            if (np.unique(xyrv, axis=0).shape[0] != xyrv.shape[0]):
                print("===> ERROR : There are two identical lines in the")
                print("             array xyrv used to determine the \
                    contacts between")
                print("             individuals and this is not normal.")
                sys.exit()

            contacts = compute_contacts(dom, xyrv, dmax)
            print("     Number of contacts: ", contacts.shape[0])
            Forces = compute_forces(F, Fwall, xyrv, contacts, Uold, Vd,
                                    lambda_, delta, kappa, eta)
            nn = people["xyrv"].shape[0]
            all_people[name]["U"] = dt*(Vd[:nn, :]-Uold[:nn, :])/tau +\
                Uold[:nn, :] + dt*Forces[:nn, :]/mass
            # only for the plot of virtual people :
            virtual_people[name]["U"] = dt*(Vd[nn:, :]-Uold[nn:, :])/tau +\
                Uold[nn:, :] + dt*Forces[nn:, :]/mass

            all_people[name], all_sensors[name] = move_people(
                t, dt,
                all_people[name],
                all_sensors[name])

        if (draw and with_graphes):
            # coloring people according to their radius
            colors = all_people[name]["xyrv"][:, 2]
            # coloring people according to their destinations
            # colors = np.zeros(all_people[name]["xyrv"].shape[0])
            # for i,dest_name in enumerate(all_people[name]["destinations"]):
            #     ind = np.where(all_people[name]["destinations"]==dest_name)[0]
            #     colors[ind]=i
            plot_people(100*idom+20, dom, all_people[name], contacts,
                        colors, virtual_people=virtual_people[name], time=t,
                        plot_people=plot_p, plot_contacts=plot_c,
                        plot_paths=plot_pa, plot_velocities=plot_v,
                        plot_desired_velocities=plot_vd, plot_sensors=plot_s,
                        sensors=all_sensors[dom.name], savefig=True,
                        filename=prefix+dom.name+'_fig_'
                        + str(counter).zfill(6)+'.png')
            plt.pause(0.05)

    # Update people destinations
    all_people = people_update_destination(all_people, domains, dom.pixel_size)

    # Update previous velocities
    for idom, name in enumerate(domains):
        all_people[name]["Uold"] = all_people[name]["U"]

    # Print the number of persons for each domain
    for idom, name in enumerate(domains):
        print("===> Domain ", name, " nb of persons = ",
              all_people[name]["xyrv"].shape[0])

    t += dt
    cc += 1
    counter += 1
    if (cc >= drawper):
        draw = True
        cc = 0
    else:
        draw = False


for idom, domain_name in enumerate(all_sensors):
    print("===> Plot sensors of domain ", domain_name)
    plot_sensors(100*idom+40, all_sensors[domain_name], t, savefig=True,
                 filename=prefix+'sensor_'+str(i)+'_'+str(counter)+'.png')
    plt.pause(0.05)

plt.ioff()
plt.show()
sys.exit()
