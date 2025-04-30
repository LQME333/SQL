package ds;

import java.util.Iterator;
import adt.Lista;
import exceptions.IndiceError;


class Nodo<E>{
    E dato;
    Nodo<E> next;

    Nodo(E dato, Nodo<E> next){
        this.dato = dato;
        this.next = next;
    }
}

public class ListaImpl<E> implements Lista<E> {
    private Nodo<E> primero = null;
    private int talla = 0;

    @Override
    public void insertar(int pos, E dato) throws IndiceError {
        if(pos>talla || pos<0) throw new IndiceError();
        if(pos == 0){ //lista vacia el primero es el nuevo nodo
            primero = new Nodo<>(dato, primero);
        }else{      //10->20->30
            Nodo<E> actual = primero; //actual=10
            for(int i=0; i<pos-1; i++){
                actual = actual.next;
                //actual = actual.next(20)
                //actual(20) = actual.next(30)
            }
            //actual.next=40
            actual.next = new Nodo<>(dato, actual.next);
            //40(lo introducimos nosotros) será el valor de la posicion +1 del actual
        }
        talla++;
    }

    @Override
    public void delete(int pos) throws IndiceError {
        //10->20->30->40
        if(pos>=talla || pos<0 ) throw new IndiceError();
        if(pos==0) primero = primero.next;   //20->30->40
        else{
            //10->20->30->40
            Nodo<E> actual = primero; //actual =10
            for(int i=0; i<pos-1;i++){
                actual = actual.next; //actual = 20, actual.next =30
            }
            actual.next = actual.next.next; //actual.next.next = 40, el 30 desaparece
        }
        talla--;
    }

    @Override
    public E obtener(int pos) throws IndiceError {
        if (pos >= talla || pos < 0) throw new IndiceError();

        Nodo<E> actual = primero;
        for (int i = 0; i < pos; i++) {
            actual = actual.next;
        }
        return actual.dato;
    }

    @Override
    public int buscar(E dato){
        Nodo<E> actual = primero;
        int pos=0;

        while(actual != null){ // si actual es el dato, devuelve posicvion, sino actual sera actual.next(avanza en la lista)
            if(actual.dato.equals(dato)){
                return pos;
            }
            actual = actual.next;
            pos++;
        }
        return -1;
    }

    @Override
    public Iterator<E> iterador() {
        return null;
    }

    @Override
    public int talla(){
        return talla;
    }

    @Override
    public Iterator<E> iterator(){
        return new NodoIterador();
    }

    public class NodoIterador implements Iterator<E>{
        private Nodo<E> actual;
        //constructor
        NodoIterador(){
            this.actual = primero;

        }

        @Override
        public boolean hasNext() {
            return actual != null;
        }

        @Override
        public E next() {
            if(!hasNext()){
                return null;
            }
            E dato = actual.dato;
            actual = actual.next;
            return dato;
        }
    }
}