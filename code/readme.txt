Contenuto della directory di progetto:

-reference_generator.m:	script che genera i riferimenti da inseguire per la
			realizzazione della traiettoria di taglio nel piano;
-reference_values.m: 	passa i riferimenti all'ambiente Simulink:
-trajectory_plot.m:	esegue il plot della traiettoria definita tramite
			i riferimenti trovati lungo gli assi x e y;
-segment.m: 		descrive un segmento che interpola i due punti assegnati;
-circumference.m: 	descrive un arco di circonferenza di centro O e raggio r, 
		   	a partire dal punto in cui ci si trova, restituendo il punto
		   	finale, in termini di coordinate x e y;
-motor_parameters.m: 	parametri del motore DC;

-two_axis_motor_control.slx: 	esegue l'azione di controllo sia sul motore di destra che su quello di sinistra, effettuando
			 	l'inseguimento dei riferimenti ottenuti, rispettivamente, per l'asse x e per l'asse y;

-motor_control.m:	test di verifica sul corretto funzionamento dell'azione di controllo;




