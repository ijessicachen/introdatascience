Parameters from json file!
Taken from [micro\_social.py](https://github.com/sylvain-faure/cromosim/blob/master/examples/micro/social/micro_social.py). Modified to comment on the specific values used for our simulations

KEY NOTES
- although the sensors and their respective graphs are plotted, they are not used in our analysis.
- the seeds 4, 11, and 30 with these parameters (and a=0.7 from `domain_dd.py`) are guaranteed to work and their results are in their respective results folders (`dd_results4`, `norm_results11`, etc.)


```
    |--------------------
    For each group of persons, required for the initialization process:
    |    nb:
    |        Number of people in the group
    |    domain:
    |        Name of the domain where people are located
    |    radius_distribution:
    |        Radius distribution used to create people
    |        ["uniform",min,max] or ["normal",mean,sigma]
    |    velocity_distribution:
    |        Velocity distribution used to create people
    |        ["uniform",min,max] or ["normal",mean,sigma]
    |    box:
    |        Boxe to randomly position people at initialization
    |        [ [x0,y0],[x1,y1],...]
    |    destination:
    |        Initial destination for the group
    |--------------------
    For each sensor:
    |    domain:
    |        Name of the domain where the sensor is located
    |    line:
    |        Segment through which incoming and outgoing flows are measured
    |        [x0,y0,x1,y1]
    |--------------------
    prefix: string
        Folder name to store the results.
    with_graphes: bool
        true if all the graphes are shown and saved in png files,
        false otherwise
    seed: integer
        Random seed which can be used to reproduce a random selection
        if >0
    Tf: float
        Final time
    dt: float
        Time step, often 0.005
    drawper: integer
        The results will be displayed every "drawper" iterations. I have used 
        100, which paired with the 0.005 time step provides a graph every 0.5s.
    mass: float
        Mass of one person (typically 80 kg)
    tau: float
        (typically 0.5 s)
    F: float
        Coefficient for the repulsion force between individuals
        (typically 2000 N, we used 300 N as explained in the report)
    kappa: float
        Stiffness constant to handle overlapping (typically
        120000 kg s^-2)
    delta: float
        To maintain a certain distance from neighbors (typically 0.08 m)
    Fwall: float
        Coefficient for the repulsion force between individual and
        walls (typically 2000 N, like for F. We used 300 N as explained in
        the report)
    lambda: float
        Directional dependence (between 0 and 1 = fully isotropic case)
    eta: float
        Friction coefficient (typically 240000 kg m^-1 s^-1)
    projection_method: string
        Name of the projection method : cvxopt(default),
        mosek(a licence is needed) or uzawa. We used cvxopt.
    dmax: float
        Maximum distance used to detect neighbors, we used 0.17
    dmin_people: float
        Minimum distance allowed between individuals, we used 0.0
    dmin_walls: float
        Minimum distance allowed between an individual and a wall,
        we used 0.0
    plot_people: boolean
        If true, people are drawn
    plot_contacts: boolean
        If true, active contacts between people are drawn
    plot_desired_velocities: boolean
        If true, people desired velocities are drawn
    plot_velocities: boolean
        If true, people velocities are drawn
    plot_sensors: boolean
        If true, plot sensor lines on people graph and sensor data graph
    plot_paths: boolean
        If true, people paths are drawn
```
