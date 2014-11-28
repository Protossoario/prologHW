% Eduardo Alberto Sanchez Alvarado A01195815

% Predicado que verifica que la segunda lista sea un subconjunto de la primera
subconjunto([], []).
subconjunto([X|Xs],[X|Ys]) :- subconjunto(Xs, Ys).
subconjunto([_|Xs], Ys) :- subconjunto(Xs, Ys).

% Obtiene todos los posibles subconjuntos de la lista y los guarda en Resultado
potencia(Lista, Resultado) :- findall(X, subconjunto(Lista, X), Resultado).

% Grafo g
nodo(g, a).
nodo(g, b).
nodo(g, c).
nodo(g, d).
nodo(g, e).
arco(g, a, b, 2).
arco(g, a, d, 10).
arco(g, b, c, 9).
arco(g, b, e, 5).
arco(g, c, a, 12).
arco(g, c, d, 6).
arco(g, d, e, 7).
arco(g, e, c, 3).

% Un solo nodo en la ruta.
costo(_, [_], 0) :- !.
% El costo total es la suma del costo entre los dos nodos siguientes mas el costo del resto de la ruta a partir del segundo nodo.
costo(Grafo, [Nodo1, Nodo2 | Ruta], Costo) :- arco(Grafo, Nodo1, Nodo2, Costo1), costo(Grafo, [Nodo2 | Ruta], Costo2), !, Costo is Costo1 + Costo2.

% Obtiene la lista de nodos del grafo y se la pasa a la funcion auxiliar.
arcos(Grafo, L) :- findall(X, nodo(Grafo, X), Nodos), cuenta_arcos(Grafo, Nodos, L).

% Recibe el grafo y una lista de nodos; regresa una lista con los nodos y la cantidad de arcos que tienen dentro del grafo.
cuenta_arcos(_, [], []).
cuenta_arcos(Grafo, [Nodo|Resto], Lista) :- findall(X, arco(Grafo, Nodo, X, _), Arcos), cuenta_arcos(Grafo, Resto, Lista2), !, length(Arcos, CantArcos), Lista = [[Nodo, CantArcos] | Lista2].

% Regresa el costo de atravesar de un nodo a otro, o un cero si no hay arco que no los conecte.
costo(Grafo, Nodo1, Nodo2, C) :- arco(Grafo, Nodo1, Nodo2, C).
costo(Grafo, Nodo1, Nodo2, 0) :- not(arco(Grafo, Nodo1, Nodo2, _)).

% Obtiene la lista de nodos del grafo y para cada uno obtiene su lista de adyacencia, regresando una lista de todas las lista de adyacencia del grafo (matriz de adyacencia).
adyacencias(Grafo, L) :- findall(X, nodo(Grafo, X), Nodos), maplist(lista_adyacencias(Grafo, Nodos), Nodos, L).

% Regresa una lista de adyacencias encabezada por el nodo dentro del grafo.
lista_adyacencias(Grafo, Nodos, Nodo, Lista) :- costos(Grafo, Nodo, Nodos, Costos), Lista = [Nodo | Costos].

% Regresa una lista de costos desde el nodo hacia los nodos de la lista dentro del grafo.
costos(_, _, [], []).
costos(Grafo, Nodo1, [Nodo2|Resto], Costos) :- costo(Grafo, Nodo1, Nodo2, C), costos(Grafo, Nodo1, Resto, Costos2), !, Costos = [C|Costos2].
