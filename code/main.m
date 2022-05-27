%script di esecuzione di tutti i file necessari al controllo
%del motore in corrente continua a due assi

%% generazione dei riferimenti 
%necessari all'inseguimento della traiettoria che i due motori DC devono 
%descrivere per il taglio della lastra di laminato, con conseguente plot 
reference_generator

%% inseguimento della traiettoria
figure(1)
trajectory_plot

%% passaggio a Simulink dei riferimenti
reference_values

%% caricamento nel workspace dei parametri dei due motori DC
motor_parameters

%% apertura del file Simulink
open('two_axes_motor_control')

%% simulazione
sim('two_axes_motor_control')
