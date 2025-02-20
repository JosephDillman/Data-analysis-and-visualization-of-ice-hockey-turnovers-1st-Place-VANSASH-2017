function canuckstracker
%display location of puck and mark turnover locations leading to clearances 
%import relevant data and organize to vectors, X and Y represent the X and Y position of puck, T is time
 filename = 'smalldata.xlsx';    
    X =                 xlsread(filename,'Sheet1','H95:H311'); 
    Y =                 xlsread(filename,'Sheet1','I95:I311');
    T =             xlsread(filename,'Sheet1','F95:F311');
    [num,txt,raw] =     xlsread(filename,'Sheet1','A95:A311');
    GAME = txt;
    [num,txt,raw] =     xlsread(filename,'Sheet1','B95:B311');
    TEAM = txt;
    [num,txt,raw] =     xlsread(filename,'Sheet1','G95:G311');
    PLAYER = txt;
    PERIOD =            xlsread(filename,'Sheet1','E95:E311');
    for q=1:length(T) %convert minute:seconds into seconds 
        w = datevec(T(q));
        s(q) = w(4)*60 + w(5);
    end
    T = xlsread(filename,'Sheet1','F2:F94'); %determine a clear
    count = 0;
    for i=1:(length(X)-1)
        if X(i) > 125
            if X(i+1) < 125
                count=count+1;
                A(count)=X(i);
                B(count)=Y(i);
                disp('A clear occurs at ')
                disp(s(i))
                disp(' seconds by player ')
                disp(PLAYER(i))
                disp('of team ')
                disp(TEAM(i))
                disp(' in period ')
                disp(PERIOD(i))
                disp(' of game ')
                disp(GAME(i))
            end
        end
    end
    tx=linspace(1, 800, length(X));        %smooth data for video using interpolation
    tix =linspace(1, 800, 4*length(X));
    xx=interp1(tx,X,tix,'pchip');
    
    ty=linspace(1, 800, length(Y));
    tiy=linspace(1, 800, 4*length(Y));
    yy=interp1(ty,Y,tiy, 'pchip');
    
        
    
    hold on;             %begin drawing diagram
    set(gcf,'units','points','position',[0,0,200,85])
    xlabel('Rink Length (ft)')
    ylabel('Rink Width (ft)')
    title('Puck/Player Tracker')
    
    plot(125, 0:85, 'b.')        %blue line
    plot(75, 0:85, 'b.')
    plot(100, 1:84, 'ro')        %centre
    plot(11,2:1.5:83, 'r.')        %goalline red
    plot(189,2:1.5:83, 'r.')
    plot(11,39.5:45.5, 'k.')     %goal black
    plot(189,39.5:45.5, 'k.')
    
    th = linspace( pi/2, -pi/2, 100); %goalie creases
    R = 4;  
    x = R*cos(th) ;
    y = R*sin(th) ;
    plot(x+ 11,y+ 42.5, 'r')
    plot(-x+ 189,y+ 42.5, 'r')
    
    plot(100,42.5, 'bo', 'MarkerSize', 59)                 %centre circle
    plot(31,20.5, 'ro', 'MarkerSize', 59)                  %faceoff circles
    plot(31,64.5, 'ro', 'MarkerSize', 59)
    plot(169,20.5, 'ro', 'MarkerSize', 59) 
    plot(169,64.5, 'ro', 'MarkerSize', 59)
    
    plot(16:184, 0, 'k.')                           %rink boarder
    plot(16:184, 85, 'k.')
    plot(0, 16:69, 'k.')
    plot(200, 16:69, 'k.')
    
    th2 = linspace(0, -pi/2, 100);               %rink curve
    R2 = 16;
    x2 = R2*cos(th2);
    y2 = R2*sin(th2);
    plot(-x2+16, y2+16, 'k', 'LineWidth', 2)
    plot(-x2+16, -y2+69, 'k', 'LineWidth', 2)
    plot(x2+184, y2+16, 'k', 'LineWidth', 2)
    plot(x2+184, -y2+69, 'k', 'LineWidth', 2)
    
    z=0;
    pause(2)
    h=plot(A,B,'kx', 'MarkerSize', 10, 'LineWidth', 4) %plot puck motion
    comet(xx,yy,0.05);

    
    hold off;
  



end 