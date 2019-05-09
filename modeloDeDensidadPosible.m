%Funcion para determinar la densidad probabilistica del posible modelo (lineal)
function densidadPosible = modeloDeDensidadPosible(parametros,x,y)  %Declaracion de la funcion
    %Asignacion de los parametros recibidos en variables    
    m = parametros(1); %pendiente
    b = parametros(2); %interseccion
    de = parametros(3); %desviacion estandar
    x = x;  %variables independientes del conjunto de datos
    y = y;  %variables dependientes del conjunto de datos
    posibleModelo = m*x+b;
    posibilidadesIndividuales = log(normpdf(y,posibleModelo,de));
    densidadPosible = sum(posibilidadesIndividuales);
end
    
    