package adt;

import ds.BSTImpl;

public interface BST {

    void add(int valor);
    BSTImpl.Nodo search(int valor);
    void delete(int valor);
    BSTImpl.Nodo min();
    BSTImpl.Nodo max();

    Iterable<BSTImpl.Nodo> inorden();
    Iterable<BSTImpl.Nodo> preorden();
    Iterable<BSTImpl.Nodo> postorden();
}
