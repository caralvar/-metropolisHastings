% Tarea: Modelos probabilisticos de señales y sistemas 
% autor: Carlos A 
% Problema 1: Generacion de una distribucion semi normal por inverse transform sampling
% 			  Creacion de dos  vaiables no correlacionadas por box muller transform 
% Problema 2: Regresion lineal del conjunto de datos de fisher por el algoritmo 
%			  Metropolis-Hastings

u = rand(2,100000);
% Se obtiene r y cita realizando inverse transforma sampling de acuerdo a
% la multiplicacion de dos variables exponencialmente distribuidas
r = sqrt(-2*log(u(1,:)));
cita = 2*pi*u(2,:);
%Se pasan de coordenadas polares a cooerdenadas cartesianas
x1 = r.*cos(cita);
y1 = r.*sin(cita);
%Se grafican las variable
figure('name','Variable x no correlacionada obtenida por box muller transform');
histogram(x1);        %
figure('name','Variable y no correlacionada obtenida por box muller transform');
hh = histogram(y1);



%%%%%%%%%%%%%%%%%%%%%%%%%Promblema 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Primero se carga el conjunto de datos por usar sobre flores recolectado
%por Fisher
load fisheriris;
%Se definen las variables para determinar la relacion
largoSepalo = meas(:,1); %Variable dependiente (largo del sepalo)
anchoPetalo = meas(:,4); %Variable independiente (ancho del petalo)}
%Se grafica el confunto de datos


%Ahora se inicia el algoritmo Metropolis-Hastings
iteraciones = 100000; %Numero de pasos de la cadena de markov
i = 1;  
%Se define el vector que va a llevar los parametros a lo largo de la cadena
%de markov. Se llena con zeros inicialmente y 3 columnas para cada
%parametro.
parametros = zeros(iteraciones,3);
%Se establece un vector inicial y se le asigna a la matriz de parametros.
valorInicial = [1 4 1];
parametros(1,:) = valorInicial;
%Vector aleatorio inicial de desviacion estandar para cada parametro.
c = [0.1, 0.5, 0.3];

%Ciclo de la cadena de markov
while i<iteraciones
    %Se establece una propuesta aleatoria con los parametros actuales como
    %media.
    propuesta = normrnd(parametros(i,:),c);
    %Se establece la probabilidad de paso de la cadena como la razon entre
    %la densidad posterior  de la propuesta entre la densidad
    %posterior de los valores actuales, las densidades posteriores se
    %obtienen a partir de la inferencia bayesiana.
    probabilidadDePaso = exp(densidadPosterior(propuesta,anchoPetalo,largoSepalo)-densidadPosterior(parametros(i,:),anchoPetalo,largoSepalo));
   %Se genera un numero aleatorio con distribucion normal
    u = rand;
    %Si la probabilidad de paso es mayor a la probabilidad generada se
    %establecen la propuesta como los nuevos valores de la cadena
    if u < probabilidadDePaso
        parametros(i+1,:) = propuesta;
    else
    %Si no se establecen los parametros actuales como los siguientes en la
    %cadena
        parametros(i+1,:) = parametros(i,:);
    end
    i = i+1;
end   
%Se eliminan los primeros 5000 datos para obtener solo los obtenidos cuando
%se estabiliza la cadena.
parametros = parametros(5000:iteraciones,:);
%Se establecen los valores esperados como la media de las distribuciones
%obtenidas a partir del algoritmo
m = mean(parametros(:,1));
b = mean(parametros(:,2));
de = mean(parametros(:,3));
%Se muestran las distribuciones obtenidas
figure('name','Distribucion de la pendiente');
histogram(parametros(:,1));
hold on
plot([m,m],ylim,'r--','LineWidth',2)
hold off
figure('name','Distribucion de la intersección');
histogram(parametros(:,2));
hold on
plot([b,b],ylim,'r--','LineWidth',2)
hold off
figure('name','Distribucion de la desviación estandar');
histogram(parametros(:,3));
hold on
plot([de,de],ylim,'r--','LineWidth',2)
hold off

%Se establece la relacion lineal obtenida y se grafica con el conjunto de
%datos.
x = -2: 0.01 : 10;
y = m*x + b;

figure('name','Conjunto de datos');
gscatter(anchoPetalo,largoSepalo);
title('Largo del sépalo vs Ancho del pétalo');
xlabel('Ancho del pétalo');
ylabel('Largo del sépalo');
hold on;
plot(x,y);






