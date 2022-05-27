% Planar Laser-Cutting Machine parameters
%% axis motor parameters
Ra = 1.025;                            % resistenza di armatura
La = 0.0001;                           % induttanza di armatura

Km = 0.043;                            % Kt = Ke 
Kt = 0.043;                            % coefficiente di coppia (torque)
Ke = 0.043;                            % coefficiente di F.C.E.M. (forza contro-elettromotrice)

speed_reducer = 1/100;                 % riduttore di giri

Jc = 5;                                % inerzia del carico
Jm = 0.000056;                         % inerzia del motore
J  = Jm + Jc*((speed_reducer)^2);      % inerzia del rotore (cioe' l'inerzia vista dal motore)

Bm = 0.00081;
Bc = 0;
b = Bm + (speed_reducer)^2*Bc;         % coefficiente di attrito 

taur = 0;                              % coppia di carico (coppia resistente, o disturbo, si considera assente)
%Ea                                    % forza elettromotrice F.E.M
%Ia = Va/Ra                            % corrente di spunto, in armatura,
                                       %e' troppo elevata per essere sopportata dal motore a lungo 
%Va = Ia*Ra + Ea

%% cutting wheel motor parameters 

wheel_radius = 0.1/pi;                  % raggio della ruota
%wheel_C = 2*pi*wheel_radius;           % circonferenza della ruota

max_speed = 1;                          % velocita' (w del rotore)
alpha = 0.2;                            % fattore di riduzione della velocita' durante il taglio
cutting_speed = alpha*max_speed;        % velocita' di taglio

%% Dc motor mathematical model

pe = -Ra/La;                            % polo elettrico
te = La/Ra;                             % costante elettrica
pm = -b/J;                              % polo meccanico
tm = J/b;                               % costante meccanica

Va=12;                                  % tensione armatura, ingresso, supply voltage [V]
Pin = 20;                               % input power [W] = [V x A], consumed electrical power
max_current = Pin/Va;                   % current [A]
    