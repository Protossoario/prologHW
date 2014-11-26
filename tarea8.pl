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
