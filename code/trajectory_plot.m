%plot del movimento che la macchina a controllo assi
%compie durante l'esecuzione del taglio del laminato 

%% Disegno del laminato 
%il materiale e' un rettangolo di dimensioni (10 x 5)
%posizionato su un piano di taglio di dimensioni (12 x 7)
line([0 10], [0 0],'color', 'k', 'linewidth', 2)
line([0 10], [5 5],'color', 'k', 'linewidth', 2)
line([0 0], [0 5],'color', 'k', 'linewidth', 2)
line([10 10], [0 5],'color', 'k', 'linewidth', 2)
grid on
grid minor
axis equal
axis([0 12 0 7])
title('Planar Laser-Cutting Machine Trajectory')
xlabel('x-axis (m)')
xticks(0:1:12)
ylabel('y-axis (m)')
hold on

%% plot
 for i = 1:length(x_movement)
     %plot
      pause(0.00005)
      %cutting test
      if (laser(i)==0)
           %non si effettua il taglio
           plot(x_movement(i), y_movement(i),'color','b','Marker','.', 'MarkerSize', 7)
       else
           %si effettua il taglio
           plot(x_movement(i), y_movement(i),'color','r','Marker','.', 'MarkerSize', 5)
       end
 end

 %% tempo di simulazione su Simulink : 2366