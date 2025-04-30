package ds;

import java.util.*;

public class BSTImpl {

    public class Nodo {
        public int valor;
        public Nodo izquierdo;
        public Nodo derecho;

        public Nodo(int valor) {
            this.valor = valor;
        }
    }

    private Nodo raiz;

    // Agregar un valor al árbol
    public void add(int valor) {
        Nodo nuevo = new Nodo(valor);
        if (raiz == null) {
            raiz = nuevo;
            return;
        }

        Nodo actual = raiz;
        while (true) {
            if (valor < actual.valor) {
                if (actual.izquierdo == null) {
                    actual.izquierdo = nuevo;
                    return;
                }
                actual = actual.izquierdo;
            } else if (valor > actual.valor) {
                if (actual.derecho == null) {
                    actual.derecho = nuevo;
                    return;
                }
                actual = actual.derecho;
            } else {
                return; // Valor duplicado, no se inserta
            }
        }
    }

    // Buscar un valor
    public Nodo search(int valor) {
        Nodo actual = raiz;
        while (actual != null) {
            if (valor < actual.valor) actual = actual.izquierdo;
            else if (valor > actual.valor) actual = actual.derecho;
            else return actual;
        }
        return null;
    }

    // Eliminar un valor
    public void delete(int valor) {
        raiz = deleteRec(raiz, valor);
    }

    private Nodo deleteRec(Nodo nodo, int valor) {
        if (nodo == null) return null;

        if (valor < nodo.valor) {
            nodo.izquierdo = deleteRec(nodo.izquierdo, valor);
        } else if (valor > nodo.valor) {
            nodo.derecho = deleteRec(nodo.derecho, valor);
        } else {
            if (nodo.izquierdo == null) return nodo.derecho;
            if (nodo.derecho == null) return nodo.izquierdo;

            Nodo sucesor = minNodo(nodo.derecho);
            nodo.valor = sucesor.valor;
            nodo.derecho = deleteRec(nodo.derecho, sucesor.valor);
        }
        return nodo;
    }

    // Obtener el nodo con el valor mínimo
    public Nodo min() {
        return minNodo(raiz);
    }

    private Nodo minNodo(Nodo nodo) {
        while (nodo != null && nodo.izquierdo != null)
            nodo = nodo.izquierdo;
        return nodo;
    }

    // Obtener el nodo con el valor máximo
    public Nodo max() {
        Nodo actual = raiz;
        while (actual != null && actual.derecho != null)
            actual = actual.derecho;
        return actual;
    }

    // Recorrido inorden
    public Iterable<Nodo> inorden() {
        List<Nodo> lista = new ArrayList<>();
        inordenRec(raiz, lista);
        return lista;
    }

    private void inordenRec(Nodo nodo, List<Nodo> lista) {
        if (nodo == null) return;
        inordenRec(nodo.izquierdo, lista);
        lista.add(nodo);
        inordenRec(nodo.derecho, lista);
    }

    // Recorrido preorden
    public Iterable<Nodo> preorden() {
        List<Nodo> lista = new ArrayList<>();
        preordenRec(raiz, lista);
        return lista;
    }

    private void preordenRec(Nodo nodo, List<Nodo> lista) {
        if (nodo == null) return;
        lista.add(nodo);
        preordenRec(nodo.izquierdo, lista);
        preordenRec(nodo.derecho, lista);
    }

    // Recorrido postorden
    public Iterable<Nodo> postorden() {
        List<Nodo> lista = new ArrayList<>();
        postordenRec(raiz, lista);
        return lista;
    }

    private void postordenRec(Nodo nodo, List<Nodo> lista) {
        if (nodo == null) return;
        postordenRec(nodo.izquierdo, lista);
        postordenRec(nodo.derecho, lista);
        lista.add(nodo);
    }
}
