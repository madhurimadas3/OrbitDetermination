## Project Overview
This project is part of the AEM 4301 course and focuses on designing an efficient transfer trajectory to Jupiter. The objective is to explore various mission design strategies, including planetary flybys, to minimize the required Delta V. The project takes inspiration from NASA's Juno and Europa Clipper missions, as well as ESA's JUICE mission.

## Mission Objectives
- Establish a baseline using a **Hohmann transfer** to Jupiter.
- Design and analyze two alternative trajectories:
  - **Juno-like trajectory** with a **deep space maneuver (DSM).**
  - **Europa Clipper-like trajectory** with **planetary flybys but no DSM.**
- Evaluate and compare the efficiency of each trajectory in terms of **Delta V and mission duration.**

## Project Requirements
- The spacecraft starts from a **200 km low Earth orbit**.
- The mission must reach Jupiter in **less than 8 years**.
- Simulations must be implemented using **MATLAB**, including the following key functionalities:
  - `spacecraft.m`: Simulates the trajectory of the spacecraft from Earth to Jupiter.
  - `flyby.m`: Computes and plots hyperbolic flyby trajectories.
  - 'dsmtest.m': Implements the Juno-like trajectory with a deep space maneuver (DSM).
  - 'europa_clipper_traj.m': Implements the Europa Clipper-like trajectory with planetary flybys but no DSM.
  - Calculation and verification of **Delta V maneuvers and vector diagrams**.

## Report Deliverables
### 1.Hohmann Transfer Analysis
- Lead Angle: 97.16°
- Departure Hyperbola:
  - Hyperbolic excess velocity: 8.79 km/s
  - Semi-major axis: 10,729 km
  - Eccentricity: 1.7257
  - Turning angle: 125.4°
- Launch Details:
  - Hohmann transfer launch velocity: 8.62 km/s
  - Approximate launch date: January 20, 2030

### 2.Alternative Trajectories
####Juno-like trajectory (DSM + Earth Flyby)
- Initial Launch Date: January 20, 2030
- Deep Space Maneuver (DSM):
  - Performed 400 days after launch
  - Delta V required: 1.0000 km/s
- Earth Flyby:
  - Performed 796 days after launch
  - Delta V change due to flyby: 6.6064 km/s
- Jupiter Interception Date: November 1, 2033
- Total Delta V: 7.6064 km/s
####Europa Clipper-like trajectory (Mars + Earth Flyby)
- Initial Launch Date: February 6, 2048
- Mars Flyby:
  - Occurred 113 days after launch
  - Hyperbolic excess velocity: 13.88 km/s
- Earth Flyby:
  - Occurred 776 days after launch
  - Hyperbolic excess velocity: 15.18 km/s
  - Jupiter Orbit Interception Date: 1424 days after launch
  - Total Delta V: 6.22 km/s

##Results
All results, including calculated Delta V values, trajectory plots, and mission timelines, are derived from the Orbit Determination (Design) Final Report. The data and findings in this README are directly based on the report's MATLAB simulations and theoretical calculations.

### Hohmann Transfer
![Hohmann Transfer Trajectory]()

### Juno-like Trajectory (DSM + Earth Flyby)
![Juno Trajectory](images/juno_trajectory.png)

### Europa Clipper-like Trajectory (Mars + Earth Flyby)
![Europa Clipper Trajectory](images/europa_clipper_trajectory.png)


##Comparison of Trajectories
- The Hohmann transfer serves as a baseline for comparison.
- The Juno trajectory required a total Delta V of 7.6064 km/s.
- The Europa Clipper trajectory required a total Delta V of 6.22 km/s, making it the more fuel-efficient option.

## Group Members
- **Madhurima Das**
- **Rafaela Goncalves da Silva**
- **Maya Nalezny**
- **Jocelyn Prewett**
- **Ellen Froelich**

## References
- [Europa Clipper NASA](https://europa.nasa.gov/resources/533/europa-clippers-trajectory-to-jupiter/)
- [Juno NASA](https://www.nasa.gov/image-article/juno-spacecraft-cruise-trajectory/)
- [JUICE ESA](https://sci.esa.int/web/juice/-/58815-juices-journey-to-jupiter)


