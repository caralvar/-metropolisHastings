%Funcion que determinar la densidad probabilistica posterior, de acuerdo a la
%multiplicacion del modelo posible y la densidad priori, de acuerdo a la inferencia
%Bayesiana
function posterior = densidadPosterior(parametros,x,y)
    posterior = modeloDeDensidadPosible(parametros,x,y) + densidadPriori(parametros);
end