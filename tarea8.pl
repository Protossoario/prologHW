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
costo(Grafo, [Nodo1, Nodo2], Costo) :- arco(Grafo, Nodo1, Nodo2, Costo).
costo(Grafo, [Nodo1, Nodo2 | Ruta], Costo) :- arco(Grafo, Nodo1, Nodo2, Costo1), costo(Grafo, [Nodo2 | Ruta], Costo2), Costo is Costo1 + Costo2.
