
%Funcion, para determinar la densidad probabilistica a Priori de los parametros
function priori = densidadPriori(parametros)
    %Asignacion de los parametros recibidos en variables
    m = parametros(1); %pendiente
    b = parametros(2); %interseccion
    de = parametros(3); %desviacion estandar
    mPriori = log(unifpdf(m,0,10)); %densidad prob. uniforme de la pendiente
    bPriori = log(unifpdf(b,0,10)); %densidad prob. uniforme de la interseccion
    dePriori = log(unifpdf(de,0,10)); %densidad prob. uniforme de la desviacion estandar
    priori = mPriori + bPriori + dePriori;
end