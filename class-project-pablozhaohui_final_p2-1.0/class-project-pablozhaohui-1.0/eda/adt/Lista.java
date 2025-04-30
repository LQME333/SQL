package adt;

import java.util.Iterator;
import exceptions.IndiceError;

public interface Lista<E> extends Iterable<E>{
    void insertar(int pos, E dato) throws IndiceError;
    void delete(int pos) throws IndiceError;
    E obtener(int pos) throws IndiceError;
    int buscar(E dato);
    Iterator<E> iterador();
    int talla();

}