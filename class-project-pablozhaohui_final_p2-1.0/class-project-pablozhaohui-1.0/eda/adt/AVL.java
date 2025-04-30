package adt;

import ds.AVLImpl;

public interface AVL {

    void add(int valor);
    AVLImpl.Nodo search(int valor);
    void delete(int valor);
    AVLImpl.Nodo min();
    AVLImpl.Nodo max();

    Iterable<AVLImpl.Nodo> inorden();
    Iterable<AVLImpl.Nodo> preorden();
    Iterable<AVLImpl.Nodo> postorden();
}