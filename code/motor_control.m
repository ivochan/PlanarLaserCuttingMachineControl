%DC motor control
%variabile della funzione di trasferimento
s = tf('s');

%funzione di trasferimento dell'anello di corrente Gi = 1/( s*La + Ra);
Gi = tf(1, [La Ra])
%funzione di trasferimento dell'anello di velocita' Gw = Km/( J*s + b);
Gw = series(tf(Km,1), tf(1, [J b]))
%traferimento dell'anello di posizione Gp = 1/s;
Gp = (tf(1, [1 0]))

%funzione di trasferimento del motore DC a ciclo aperto
motor = tf( Km, [ (J*La) ((J*Ra)+(La*b)) ((b*Ra)+Km^2)])

%zeri e guadagno statico della funzione
[z, gain] = zero(motor);% gain=0.0031
p = pole(motor);

%funzione non controllata
openG = Gp*Gw*Gi;
%dbode diagram
figure(2)
margin(openG)
%step response
feedback(openG,1)
figure(3)
step(openG)%non converge
title("Step Response: open-loop motor transfer function") 
grid on
openG_step = stepinfo(openG)

%CURRENT LOOP Control
%anello interno
%controllore PI
Kpi = 100;
Kii = 300;
Ci = Kpi + Kii/s;
%funzione a ciclo aperto
Li = series(Ci,Gi);
%funzione a ciclo chiuso
Wi = feedback(Li,1);
figure(4)
step(Wi)
title("Step Response: current loop") 
grid on

%SPEED LOOP Control
%anello intermedio
%controllore PI
Kpw = 10;
Kiw = 30;
Cw = Kpw + Kiw/s;
%funzione a ciclo aperto
Lw = series(Cw,Gw);
%funzione a ciclo chiuso
Ww = feedback(Lw,1);
figure(5)
step(Ww)
title("Step Response: velocity loop") 
grid on

%POSITION LOOP Control
%anello esterno
%controllore P
Kpp = 1;
%funzione a ciclo aperto
Lp = series(Kpp,Gp);
%funzione a ciclo chiuso
Wp = feedback(Lp,1);
figure(6)
step(Wp)
title("Step Response: position loop")
grid on

%funzione del motore DC controllata
closedG = Wp*Ww*Wi;
figure(7)
step(closedG)
title("Step Response: closed-loop motor transfer function") 
grid on
closedG_step = stepinfo(closedG)
