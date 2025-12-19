# Normal Social Force Model

## From domain docs

**Relevant Methods**
- `people_desired_velocity`
- `add_destination`

### people\_desired\_velocity
Uses a fast-marching method
- I believe they are referring to [this method by J.A. Sethian](https://math.berkeley.edu/~sethian/2006/Explanations/fast_marching_explain.html) for solving BVPs?
- In the fast marching method the speed never changes sign, and this may actually lead to the issue I'm having with the people getting stuck. *May have to consider Level Set Methods!*

Do I need to modify? **maybe**
- I think it will be fine though bc although it is used in some `micro` methods, it is just for initialization and also I think I will only be modifying this desired term later on when computing the forces so elsewhere free flow speed/velocity can just be used?
- actually I changed my mind, might need to modify the methods that use this too. I'll list them below, they're all from `micro`
    - `create_people_in_box()`, used in: `people_initialization`
    - `check_people_in_box()`, used in: `remove_overlaps_in_box`
    - `remove_overlaps_in_box()`, used in: `people_initialization`

`velocity_scale`: float
- Multiplying coefficient used in front of the desired velocity vector (which is renormalized). For example on a staircase one may wish to reduce the speed of people.
- seemingly default 1 and does not change

`xyr[ind, 3]`
- this is just the xyrv array but they called it xyr and don't use velocity for some reason? The xyrv array is what's passed to it in any case
- xyr[ind, 3] represents the speed or the weight of the speed?

```python
def people_desired_velocity(self, xyr, people_dest, II=None, JJ=None):
    """This function determines people desired velocities from the desired \
    velocity array computed by Domain thanks to a fast-marching method.

    Parameters
    ----------
    xyr: numpy array
        people coordinates and radius: x,y,r
    people_dest: list of string
        destination for each individual
    II: numpy array (None by default)
        people index i
    JJ: numpy array (None by default)
        people index j

    Returns
    -------
    II: numpy array
        people index i
    JJ: numpy array
        people index j
    Vd: numpy array
        people desired velocity
    """

    # some kind of set up
    if ((II is None) or (JJ is None)):
        II = np.floor((xyr[:, 1]-self.ymin-0.5*self.pixel_size)/self.pixel_size).astype(int)
        JJ = np.floor((xyr[:, 0]-self.xmin-0.5*self.pixel_size)/self.pixel_size).astype(int)
Vd = np.zeros((xyr.shape[0], 2))

    for dest_name in np.unique(people_dest):
        ind = np.where(np.array(people_dest) == dest_name)[0]
        # default of 1
        scale = self.destinations[dest_name].velocity_scale

        # desired_velocity_X and desired_velocity_Y are
        #   determined from add_destination()
        Vd[ind, 0] = xyr[ind, 3]*scale*self.destinations[dest_name].desired_velocity_X[II[ind], JJ[ind]] Vd[ind, 1] = xyr[ind, 3]*scale*self.destinations[dest_name].desired_velocity_Y[II[ind], JJ[ind]]
return II, JJ, Vd
```

### add\_destination
Computes the desired velocities to a destination and adds the Destination object to the domain.
- what you see when doing `plot_desired_velocity` plots exactly these intial velocities

`desired_velocity_X` and `desired_velocity_Y`
- I believe this is entirely based on the geometry of the room, so the `desired_velocity_X` and `desired_velocity_Y` it produces seem like good candidates for `V0` (free flow speed at low density) of the density-dependent model

## From micro docs

**Relevant Methods**
- what needs to be altered bc they use `people_desired_velocity`
    - `create_people_in_box()`
    - `check_people_in_box()`
    - `remove_overlaps_in_box()`
- `compute_contacts`
- `compute_forces`
    - need to understand contacts from `compute_contacts`


### compute\_contacts
Uses KDTree method to find the contacts between individuals
- not sure what exactly this method is supposed to do. Find from what?

Parameters
- dom, xyrv understood
- dmax: threshold value used to consider a contact as active
    - might need to alter this to fix what's going wrong with your simulation
    - I think making it smaller successfully removed the issues for contacts between people
    - still one guy getting stuck in an aisle, maybe `people_wall_distance` is the issue?

```
contacts: numpy array
    all the contacts ``i,j,dij,eij_x,eij_y`` such that ``dij<dmax`` and
    ``i<j`` (no duplication)
```
- will need to understand this if you intend to use it for the density dependent model
- `i` - index of first individual, `j` - index of second individual
    - note the constraint that `i < j`, the exception being where `j == -1` and represents a wall
- `dij`


### compute\_forces
You weren't tweaking! Calculates social forces between people and people and between people and walls. Does not need to be altered for our modifications.

