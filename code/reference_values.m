%passaggio delle variabili salvate
%nel workspace all'ambiente Simulink tramite la funzione timeseries()

%% riferimenti ottenuti tramite lo script reference_generator

%posizione lungo l'asse x
x = timeseries(x_movement);
%posizione lungo l'asse y
y = timeseries(y_movement);

%velocita' lungo l'asse x
%ottenuta come derivata della posizione lungo x
dotx = diff(x_movement); %derivata di x
vx = timeseries(dotx);
%velocita' lungo l'asse y
%ottenuta come derivata della posizione lungo y
doty = diff(y_movement); %derivata di y
vy = timeseries(doty);

%accelerazione lungo l'asse x
%ottenuta come derivata della velocita' lungo l'asse x
dotdotx = diff(dotx);
ax = timeseries(dotdotx);
%accelerazione lungo l'asse y
%ottenuta come derivata della velocita' lungo l'asse y
dotdoty = diff(doty);
ay = timeseries(dotdoty);

%flag di taglio: variabile booleana laser
laser = timeseries(laser);