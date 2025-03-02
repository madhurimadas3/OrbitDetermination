function [rsc,vsc,finalDate,deltaV_DSM,deltaV_flyby,deltaV_total] = dsmtest(initialDate)
%function [rsc,vsc,finalDate] = spacecraft(initialDate)
%This is a placeholder function. The spacecraft stays on Earth.
%% Initialize
mu=1.327e11; %Gravitational parameter for Sun
maxDays=3000; % Number of days to follow the spaceraft
dsmDay = 400; 
fbday1 =  796;
rsc=zeros(maxDays,3); % Position vector array for spacecraft
vsc=zeros(maxDays,3); % Velocity vector array for spacecraft
finalDate=initialDate+days(maxDays); %date when sc stops appearing in simulation
launchDay=1; % # of days to launch Not used in this function
tinit=datetime(initialDate); %date format

%% Launch Maneuver
    t=tinit+days(launchDay);
    [y,m,d]=ymd(t);
    [~, R, V, ~] =planet_elements_and_sv_coplanar ...
    (1.327e11, 3, y, m, d, 0, 0, 0); %Earth on launch day

    % A rough possible value for the heliocentric velocity change is used
    % below. Can be improved through trial and error
    
    Vsc = V + 5.3*V/norm(V); 
   
    % Calculate the orbital elements for spacecraft
    [h,a,e,w,E0]=scElements(R,Vsc);

    % new orbit for spacecraft. Propagate until the day DSM is executed
    % (dsmDay defined above).
    [rsc,vsc]=propagate(h,a,e,w,E0,launchDay+1,dsmDay,rsc,vsc);
    
    % DSM Manuever
    % On dsmDay we will do a retrograde burn say
     Vsc = vsc(dsmDay,:); %velocity on dsmDay
     R = rsc(dsmDay,:); %Position vector on dsmDay
     
     Vsc_before_DSM = Vsc; %Velocity before DSM

     Vsc=Vsc - 1*Vsc/norm(Vsc); % Decrease velocity. Experiment with magnitude of Delta V here.
     Vsc_after_DSM = Vsc; % Velocity after DSM

     % Delta-v for DSM
     deltaV_DSM=norm(Vsc_before_DSM - Vsc_after_DSM);
     fprintf('Delta-V for DSM: %.4f km/s\n',deltaV_DSM);

% Determine orbital elements of resulting trajectory
[h,a,e,w,E0]=scElements(R,Vsc);
%propagate until interception of Earth fbday1 (defined above but can change)
[rsc,vsc]=propagate(h,a,e,w,E0,dsmDay+1,fbday1,rsc,vsc);

% FlyBy Manuever
Vsc_before_flyby = vsc(fbday1,:); % Velocity before flyby
R_flyby = rsc(fbday1,:); % Position at flyby

% Load flyby data from app
load 1stFlyByEarth2.mat

% Calculate the velocity after the flyby
[Vsc1,DeltaMin]=flyby(Vp1,V1,11000,3.986e5,6.378e3,1);
DeltaMin; %Can output Deltamin to keep the aiming radius above this value

% Delta-V for Flyby
deltaV_flyby = norm(Vsc1 - Vsc_before_flyby);
fprintf('Delta-V for Flyby: %.4f km/s\n', deltaV_flyby);

%Calculate the orbital elements for the spacecraft after the flyby
[h,a,e,w,E0]=scElements(R1,Vsc1);
%propagate orbit to end
[rsc,vsc]=propagate(h,a,e,w,E0,fbday1+1,maxDays,rsc,vsc);

% Total Delta-V
deltaV_total = deltaV_DSM + deltaV_flyby;
fprintf('Total Delta-V: %.4f km/s\n',deltaV_total);

 