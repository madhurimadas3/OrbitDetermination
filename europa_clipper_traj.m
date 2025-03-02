function [rsc,vsc,finalDate] = europa_clipper_traj(initialDate)
% Model similar to NASA's Europa Clipper trajectory to Jupiter
% Requires Flyby to Mars, Flyby to Earth, Flyby and capture to Jupiter
% Start date: 02/06/2048
%% Initialize
   muSun = 1.327e11;       % Gravitational parameter for Sun
   muEarth=398600;         % Gravitational parameter for Earth
   muMars=42828;           % Gravitational parameter for Mars
   rEarth=6378;            % Radius of Earth
   rMars=3396;             % Radius of Mars
   maxDays = 1600;         % Number of days to follow the spaceraft
   launchDay = 5;          % # of days to launch from Start Date
   fbday1 = 113;           % Day of flyby of Mars
   fbday2 = 776;           % Day of flyby of Earth
   rsc=zeros(maxDays,3);  % Position vector array for spacecraft
   vsc=zeros(maxDays,3);  % Velocity vector array for spacecraft
   finalDate=initialDate+days(maxDays); % date when sc stops appearing in simulation
   tinit=datetime(initialDate);         % initial time as datetime variable type
%% Stay on Earth until day of launch
   for dayCount=1:launchDay
   t=tinit+days(dayCount-1); % index dayCount=1 corresponds to initial time.
   [y,m,d]=ymd(t);           % year month day format of current time
   [~, r, v, ~] =planet_elements_and_sv_coplanar ...
   (muSun, 3, y, m, d, 0, 0, 0);
   % Update the position and velocity vectors
   rsc(dayCount,:)=[r(1),r(2),0];
   vsc(dayCount,:)=[v(1), v(2),0];
   end
%% Launch Maneuver
   t=tinit+days(launchDay);
   [y,m,d]=ymd(t);
   [coe, R, V, jd] =planet_elements_and_sv_coplanar ...
   (muSun, 3, y, m, d, 0, 0, 0);
   Vsc = V + 6.22*V/norm(V);
 
   % Calculate the orbital elements for spacecraft
   [h,a,e,w,E0]=scElements(R,Vsc);
   % Propagate the new orbit for spacecraft
   [rsc,vsc]=propagate(h,a,e,w,E0,launchDay+1,fbday1,rsc,vsc);
%% Flyby at Mars
   % Load flyby data from app
   % [R1,Vsc1,Vp1]=saveData('marsFB1','R1','Vsc1','Vp1',4)
   load marsFB1.mat
   % Calculate the velocity after the flyby
   [Vsc1,DeltaMin]=flyby(Vp1,Vsc1, 3.63e3,muMars,rMars,0);
   % Calculate the orbital elements for the spacecraft after the flyby
   [h,a,e,w,E0]=scElements(R1,Vsc1);
   % Propagate orbit to end
   [rsc,vsc]=propagate(h,a,e,w,E0,fbday1+1,maxDays,rsc,vsc);
%% Flyby at Earth
   % Load flyby data from app
   % [R2,Vsc2,Vp2]=saveData('earthFB2','R2','Vsc2','Vp2', 3)
   load earthFB2.mat
   % Calculate the velocity after the flyby
   [Vsc2,DeltaMin2]=flyby(Vp2,Vsc2,1.063e4,muEarth,rEarth,0);
   % Calculate the orbital elements for the spacecraft after the flyby
   [h,a,e,w,E0]=scElements(R2,Vsc2);
   % Propagate orbit to end
   [rsc,vsc]=propagate(h,a,e,w,E0,fbday2+1,maxDays,rsc,vsc);
