package ds;

import java.util.*;

public class AVLImpl {

    public static class Nodo {
        public int valor;
        public int altura;
        public Nodo izquierdo, derecho;

        public Nodo(int valor) {
            this.valor = valor;
            this.altura = 1;
        }
    }

    private Nodo raiz;

    // Inserta un valor
    public void add(int valor) {
        raiz = insertar(raiz, valor);
    }

    // Elimina un valor
    public void delete(int valor) {
        raiz = eliminar(raiz, valor);
    }

    // Busca un valor
    public Nodo search(int valor) {
        Nodo actual = raiz;
        while (actual != null) {
            if (valor < actual.valor) actual = actual.izquierdo;
            else if (valor > actual.valor) actual = actual.derecho;
            else return actual;
        }
        return null;
    }

    // Devuelve el nodo con valor mínimo
    public Nodo min() {
        Nodo actual = raiz;
        while (actual != null && actual.izquierdo != null)
            actual = actual.izquierdo;
        return actual;
    }

    // Devuelve el nodo con valor máximo
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

    // Recorrido preorden
    public Iterable<Nodo> preorden() {
        List<Nodo> lista = new ArrayList<>();
        preordenRec(raiz, lista);
        return lista;
    }

    // Recorrido postorden
    public Iterable<Nodo> postorden() {
        List<Nodo> lista = new ArrayList<>();
        postordenRec(raiz, lista);
        return lista;
    }

    // --------------------------------------
    // Métodos auxiliares privados

    private Nodo insertar(Nodo nodo, int valor) {
        if (nodo == null) return new Nodo(valor);
        if (valor < nodo.valor) nodo.izquierdo = insertar(nodo.izquierdo, valor);
        else if (valor > nodo.valor) nodo.derecho = insertar(nodo.derecho, valor);
        else return nodo; // duplicado

        actualizarAltura(nodo);
        return balancear(nodo, valor);
    }

    private Nodo eliminar(Nodo nodo, int valor) {
        if (nodo == null) return null;
        if (valor < nodo.valor) nodo.izquierdo = eliminar(nodo.izquierdo, valor);
        else if (valor > nodo.valor) nodo.derecho = eliminar(nodo.derecho, valor);
        else {
            if (nodo.izquierdo == null) return nodo.derecho;
            if (nodo.derecho == null) return nodo.izquierdo;
            Nodo sucesor = minNodo(nodo.derecho);
            nodo.valor = sucesor.valor;
            nodo.derecho = eliminar(nodo.derecho, sucesor.valor);
        }
        actualizarAltura(nodo);
        return rotarSiDesequilibrado(nodo);
    }

    private void inordenRec(Nodo nodo, List<Nodo> lista) {
        if (nodo == null) return;
        inordenRec(nodo.izquierdo, lista);
        lista.add(nodo);
        inordenRec(nodo.derecho, lista);
    }

    private void preordenRec(Nodo nodo, List<Nodo> lista) {
        if (nodo == null) return;
        lista.add(nodo);
        preordenRec(nodo.izquierdo, lista);
        preordenRec(nodo.derecho, lista);
    }

    private void postordenRec(Nodo nodo, List<Nodo> lista) {
        if (nodo == null) return;
        postordenRec(nodo.izquierdo, lista);
        postordenRec(nodo.derecho, lista);
        lista.add(nodo);
    }

    private int altura(Nodo n) {
        return (n == null) ? 0 : n.altura;
    }

    private void actualizarAltura(Nodo n) {
        n.altura = 1 + Math.max(altura(n.izquierdo), altura(n.derecho));
    }

    private int getBalance(Nodo n) {
        return (n == null) ? 0 : altura(n.izquierdo) - altura(n.derecho);
    }

    private Nodo balancear(Nodo nodo, int valor) {
        int balance = getBalance(nodo);
        if (balance > 1 && valor < nodo.izquierdo.valor) return rotacionDerecha(nodo);
        if (balance < -1 && valor > nodo.derecho.valor) return rotacionIzquierda(nodo);
        if (balance > 1) {
            nodo.izquierdo = rotacionIzquierda(nodo.izquierdo);
            return rotacionDerecha(nodo);
        }
        if (balance < -1) {
            nodo.derecho = rotacionDerecha(nodo.derecho);
            return rotacionIzquierda(nodo);
        }
        return nodo;
    }

    private Nodo rotarSiDesequilibrado(Nodo nodo) {
        int balance = getBalance(nodo);
        if (balance > 1 && getBalance(nodo.izquierdo) >= 0) return rotacionDerecha(nodo);
        if (balance > 1) {
            nodo.izquierdo = rotacionIzquierda(nodo.izquierdo);
            return rotacionDerecha(nodo);
        }
        if (balance < -1 && getBalance(nodo.derecho) <= 0) return rotacionIzquierda(nodo);
        if (balance < -1) {
            nodo.derecho = rotacionDerecha(nodo.derecho);
            return rotacionIzquierda(nodo);
        }
        return nodo;
    }

    private Nodo minNodo(Nodo nodo) {
        while (nodo.izquierdo != null) nodo = nodo.izquierdo;
        return nodo;
    }

    private Nodo rotacionDerecha(Nodo y) {
        Nodo x = y.izquierdo;
        Nodo T2 = x.derecho;
        x.derecho = y;
        y.izquierdo = T2;
        actualizarAltura(y);
        actualizarAltura(x);
        return x;
    }

    private Nodo rotacionIzquierda(Nodo x) {
        Nodo y = x.derecho;
        Nodo T2 = y.izquierdo;
        y.izquierdo = x;
        x.derecho = T2;
        actualizarAltura(x);
        actualizarAltura(y);
        return y;
    }
}
