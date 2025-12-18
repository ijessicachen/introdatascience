# Normal Social Force Model

## From domain docs

### people\_desired\_velocity

### people\_

## From micro docs

### compute\_contacts
Uses KDTree method to find the contacts between individuals
- not sure what exactly this method is supposed to do. Find from what?

Parameters
- dom, xyrv understood
- dmax: threshold value used to consider a contact as active
    - might need to alter this to fix what's going wrong with your simulation
    - I think making it smaller successfully removed the issues for contacts between people
    - still one guy getting stuck in an aisle, maybe `people_wall_distance` is the issue?


**Relevant methods**
- `compute_contacts`
- `compute_forces`
    - need to understand contacts from `compute_contacts`
