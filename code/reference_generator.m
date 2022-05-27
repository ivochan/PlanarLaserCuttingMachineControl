%Macchina con controllo assi (x e y) per il taglio di un laminato
%due giunti prismatici, un motore in corrente continua ciascuno
%obiettivo di riduzione dello sfrido
close all;
clear;
global lambda speed cutting_speed r13 r24 dt

% Definisco il polinomio traiettoria e il suo polinomio
% derivata per le velocità
% spline quinto grado
lambda=@(o)(o.^3.*(6.*o.^2-15.*o+10)); 
%lambda_dot=@(o)(o.^2.*(30.*o.^2-60.*o+30));

%Circonferenze
%C1 e C3 sono quelle esterne, C2 e C4 quelle interne
%raggio di C1 e C3
r13 = 1.5;
%raggio di C2 e C4
r24 = 0.5;
%coordinate del centro di C1 e C2
Ox12 = 2.5;
Oy12 = 2.5;
%coordinate del centro di C3 e C4
Ox34 = 7.5;
Oy34 = 2.5;

%%Posa iniziale
%l'organo di taglio si trova al centro degli assi del piano
%cartesiano che coincide con il bordo in basso a sinistra del
%laminato, di forma rettangolare e dimensione (5 x 10) metri
x0 = 0;
y0 = 0;
%istante di tempo iniziale
t0 = 0;
%velocità di spostamento del motore [m/s]
speed=1;
%velocità di taglio del motore
alpha = 0.2; %fattore di riduzione
cutting_speed = alpha*speed; 
%incremento del tempo
dt = 0.1;
%laser, variabile utilizzata per distinguere se durante lo spostamento 
%viene effettuato il taglio oppure no

%% Traiettoria
%%Punto 1
%parto da (0,0) e arrivo a (2.5,0) senza tagliare
%linea orizzontale
x1 = 2.5;
y1 = y0;%invariata
%tempo successivo
t1 = t0 + (x1-x0)/speed;
%traiettoria
[x1_m, y1_m] = segment(x0, y0, t0, t1, x1, y1);
%punti di arrivo in termini di coordinate x e y
x_movement = x1_m;
y_movement = y1_m;
%laser = 0, non si effettua il taglio
laser = zeros(1,length(x1_m)); 

%% Point 2
% start: (x1;y1) = (2.5;0)
% cutting from (2.5,0) to (2.5, 1)
% vertical line
x2 = x1; %unchanged
y2 = 1;
% next time step
t2 = t1 + (y2-y1)/(cutting_speed);
% trajectory
[x2_m, y2_m] = segment(x1, y1, t1, t2, x2, y2);
% end point in terms of x and y coordinates
x_movement = [x_movement, x2_m];
y_movement = [y_movement, y2_m];
%laser = 1, the cut has been made
laser = [laser,ones(1,length(x2_m))];

%% Point 3
% from the current point, the first circle has been cut, 
% that is the external one.
%circumference C1
%(2.5,1) is the starting point and it’s also the ending point,
% when the whole circumference has been outlined.
x3 = x2;
y3 = y2;
% Ox12 and Oy12 are the center coordinates 
% circumference motion equation
C1 = 2*pi/r13;
% next time step
t3 = t2 + (C1)/cutting_speed;
%trajectory
[x3_m, y3_m] = circumference( t2, t3 , Ox12, Oy12, r13);
%ending point in terms of x and y coordinates
x_movement = [x_movement, x3_m];
y_movement = [y_movement, y3_m];
%laser = 1, the cut has been made
laser = [laser,ones(1,length(x3_m))];


%% Point 4
% After that circumference has been cut, the machinery
% moves from  la circumference from (2.5,1) to (2.5,2)
% without executing the cutting operation  
%vertical line
x4 = x3; % unchanged
y4 = 2;
% next time step
t4 = t3 + (y4-y3)/speed;
%trajectory
[x4_m, y4_m] = segment(x3, y3, t3, t4, x4, y4);
%ending point in terms of x and y coordinates
x_movement = [x_movement, x4_m];
y_movement = [y_movement, y4_m];
%laser = 1, the cut hasn’t been made
laser = [laser,zeros(1,length(x4_m))];

%% Punto 5
%dal punto appena raggiunto taglio il secondo cerchio, quello interno
%circumference C2
%(2.5,2) e' il punto di partenza, coincide con il punto di arrivo dopo
%aver percorso tutta la circumference
x5 = x4;
y5 = y4;
%coordinate del centro Ox12 e Oy12
%equazione della circumference C2
C2 = 2*pi/r24;
%tempo successivo
t5 = t4 + (C2)/cutting_speed;
%traiettoria
[x5_m, y5_m] = circumference( t4, t5 , Ox12, Oy12, r24);
%punti di arrivo in termini di coordinate x e y
x_movement = [x_movement, x5_m];
y_movement = [y_movement, y5_m];
%laser = 1, si effettua il taglio
laser = [laser,ones(1,length(x5_m))];

%% Punto 6
%linea verticale, da (2.5,2) a (2.5,4)
%senza effettuare alcun taglio
x6 = x5;%invariata
y6 = 4;
%tempo successivo
t6 = t5 + (y6-y5)/speed;
%traiettoria
[x6_m, y6_m] = segment(x5, y5, t5, t6, x6, y6);
%traiettoria in termini di coordinate cartesiane
x_movement = [x_movement, x6_m];
y_movement = [y_movement, y6_m];
%laser = 0, non si effettua il taglio
laser = [laser,zeros(1,length(x6_m))];  

%% Punto 7
%linea verticale, da (2.5, 4) a (2.5, 5)
%effettuando il taglio
x7 = x6;%invariata
y7 = 5;
%tempo finale
t7 = t6 + (y7-y6)/cutting_speed;
%traiettoria
[x7_m, y7_m] = segment(x6, y6, t6, t7, x7, y7);
%traiettoria in termini di coordinate
x_movement = [x_movement, x7_m];
y_movement = [y_movement, y7_m];
%laser = 1, si effettua il taglio
laser = [laser,ones(1,length(x7_m))]; 


%% Punto 8
%linea orizzontale, da (2.5, 5) a (5, 5) senza effettuare il taglio
%(tanto c'è già il taglio, il bordo del laminato)
x8 = 5;
y8 = y7;%invariata
%tempo successivo
t8 = t7 + (x8-x7)/speed;
%traiettoria
[x8_m, y8_m] = segment(x7, y7, t7, t8, x8, y8);
%in coordinate cartesiane
x_movement = [x_movement, x8_m];
y_movement = [y_movement, y8_m];
%laser = 0, non si effettua il taglio
laser = [laser,zeros(1,length(x8_m))]; 


%% Punto 9
%linea verticale da (5, 5) a (5, 0)
%si effettua il taglio
x9 = x8;%invariata
y9 = 0;
%tempo successivo
%c'e' il valore assoluto perche' la distanza tra i punti e' negativa
%in quanto il senso di percorrenza e' contrario
t9 = t8 + abs(y9-y8)/cutting_speed;
%traiettoria
[x9_m, y9_m] = segment(x8, y8, t8, t9, x9, y9);
%in coordinate cartesiane
x_movement = [x_movement, x9_m];
y_movement = [y_movement, y9_m];
%laser  = 1, si effettua il taglio
laser = [laser,ones(1,length(x9_m))]; 

%% Punto 10
%parto da (5,0) e arrivo a (7.5,0) senza tagliare
%linea orizzontale
x10 = 7.5;
y10 = y9;%invariata
%tempo successivo
t10 = t9 + (x10-x9)/speed;
%traiettoria
[x10_m, y10_m] = segment(x9, y9, t9, t10, x10, y10);
%punti di arrivo in termini di coordinate x e y
x_movement = [x_movement, x10_m];
y_movement = [y_movement, y10_m];
%laser = 0, non si effettua il taglio
laser = [laser, zeros(1,length(x10_m))]; 


%% Punto 11
%parto dal punto appena raggiunto (x10;y10), cioe' (7.5;0)
%e taglio da (7.5,0) a (7.5, 1)
%linea verticale
x11 = x10;%invariata
y11 = 1;
%tempo successivo
t11 = t10 + (y11-y10)/(cutting_speed);
%traiettoria
[x11_m, y11_m] = segment(x10, y10, t10, t11, x11, y11);
%punti di arrivo in termini di coordinate x e y
x_movement = [x_movement, x11_m];
y_movement = [y_movement, y11_m];
%laser = 1, si effettua il taglio
laser = [laser,ones(1,length(x11_m))];


%% Punto 12
%dal punto appena raggiunto taglio il primo cerchio, quello più esterno
%circumference C3
%(7.5,1) e' il punto di partenza, coincide con il punto di arrivo dopo
%aver percorso tutta la circumference
x12 = x11;
y12 = y11;
%coordinate del centro Ox34 e Oy34
%equazione della circumference
C3 = 2*pi/r13;
%tempo successivo
t12 = t11 + (C3)/cutting_speed;
%traiettoria
[x12_m, y12_m] = circumference( t11, t12 , Ox34, Oy34, r13);
%punti di arrivo in termini di coordinate x e y
x_movement = [x_movement, x12_m];
y_movement = [y_movement, y12_m];
%laser = 1, si effettua il taglio
laser = [laser,ones(1,length(x12_m))];

%% Punto 13
%tagliata la circumference mi sposto, da (7.5,1), 
%senza tagliare, in (7.5,2)
%linea verticale
x13 = x12;%invariata
y13 = 2;
%tempo successivo
t13 = t12 + (y13-y12)/speed;
%traiettoria
[x13_m, y13_m] = segment(x12, y12, t12, t13, x13, y13);
%punti di arrivo in termini di coordinate x e y
x_movement = [x_movement, x13_m];
y_movement = [y_movement, y13_m];
%laser = 0, non si effettua il taglio
laser = [laser,zeros(1,length(x13_m))];

%% Punto 14
%dal punto appena raggiunto taglio il secondo cerchio, quello interno
%circumference C4
%(7.5,2) e' il punto di partenza, coincide con il punto di arrivo dopo
%aver percorso tutta la circumference
x14 = x13;
y14 = y13;
%coordinate del centro Ox34 e Oy34
%equazione della circumference C4
C4 = 2*pi/r24;
%tempo successivo
t14 = t13 + (C4)/cutting_speed;
%traiettoria
[x14_m, y14_m] = circumference( t13, t14 , Ox34, Oy34, r24);
%punti di arrivo in termini di coordinate x e y
x_movement = [x_movement, x14_m];
y_movement = [y_movement, y14_m];
%laser = 1, si effettua il taglio
laser = [laser,ones(1,length(x14_m))];

%% Punto 15
%linea verticale, da (7.5,2) a (7.5,4)
%senza effettuare alcun taglio
x15 = x14;%invariata
y15 = 4;
%tempo successivo
t15 = t14 + (y15-y14)/speed;
%traiettoria
[x15_m, y15_m] = segment(x14, y14, t14, t15, x15, y15);
%traiettoria in termini di coordinate cartesiane
x_movement = [x_movement, x15_m];
y_movement = [y_movement, y15_m];
%laser = 0, non si effettua il taglio
laser = [laser,zeros(1,length(x15_m))];  

%% Punto 16
%linea verticale, da (7.5, 4) a (7.5, 5)
%effettuando il taglio
x16 = x15;%invariata
y16 = 5;
%tempo finale
t16 = t15 + (y16-y15)/cutting_speed;
%traiettoria
[x16_m, y16_m] = segment(x15, y15, t15, t16, x16, y16);
%traiettoria in termini di coordinate
x_movement = [x_movement, x16_m];
y_movement = [y_movement, y16_m];
%laser = 1, si effettua il taglio
laser = [laser,ones(1,length(x16_m))]; 

%% Punto 17 (ritorno)
%ci si muove in diagonale da (7.5, 5) a (0,0)
%tempo finale
t17 = t16 + sqrt((x0-x16)^2+(y0-y16)^2)/speed;
%traiettoria di idle (not working time)
%il macchinario ha terminato il suo lavoro
[x17_m, y17_m] = segment(x16, y16, t16, t17, x0, y0);
%in coordinate cartesiane
x_movement = [x_movement, x17_m];
y_movement = [y_movement, y17_m];
%laser = 0, non si effettua il taglio
laser = [laser,zeros(1,length(x17_m))];

