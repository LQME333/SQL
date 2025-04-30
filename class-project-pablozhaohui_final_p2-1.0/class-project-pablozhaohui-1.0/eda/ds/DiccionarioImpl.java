package ds;

import adt.Diccionario;
import adt.Lista;
import exceptions.ElementoDuplicado;
import exceptions.ElementoNoEncontrado;
import java.util.Iterator;

/**
 * Implementación de Diccionario<K, V> usando
 * una tabla hash con encadenamiento.
 */
public class DiccionarioImpl<K, V> implements Diccionario<K, V> {

    // Clase interna para almacenar pares (clave, valor)
    private static class Entrada<K, V> {
        K clave;
        V valor;

        Entrada(K clave, V valor) {
            this.clave = clave;
            this.valor = valor;
        }

        @Override
        public boolean equals(Object obj) {
            if (!(obj instanceof Entrada<?, ?> other)) return false;
            return this.clave.equals(other.clave);
        }
    }

    private Lista<Entrada<K, V>>[] tabla; // Array de listas para colisiones
    private int numElementos;             // Cantidad de pares almacenados

    @SuppressWarnings("unchecked")
    public DiccionarioImpl(int capacidad) {
        // Se crea un array de tamaño "capacidad"
        tabla = new Lista[capacidad];
        // Inicializamos cada posición con una lista vacía
        for (int i = 0; i < capacidad; i++) {
            tabla[i] = new ListaImpl<>();
        }
        numElementos = 0;
    }

    // Función hash para calcular la posición
    private int hash(K clave) {
        return Math.abs(clave.hashCode() % tabla.length);
    }

    @Override
    public V insertar(K key, V value) throws ElementoDuplicado {
        int indice = hash(key);
        Lista<Entrada<K, V>> bucket = tabla[indice];

        // Buscamos si ya existe la clave
        int pos = bucket.buscar(new Entrada<>(key, null));
        if (pos != -1) {
            // Clave repetida: actualizamos valor y retornamos el antiguo
            Entrada<K, V> e;
            try {
                e = bucket.obtener(pos);
            } catch (Exception ex) {
                // Debería no pasar si pos != -1
                throw new ElementoDuplicado("Error al obtener elemento duplicado");
            }
            V oldValue = e.valor;
            e.valor = value;
            return oldValue;
        }
        // Clave nueva: insertamos al inicio (pos=0) o al final, como prefieras
        try {
            bucket.insertar(0, new Entrada<>(key, value));
        } catch (Exception ex) {
            throw new ElementoDuplicado("Error al insertar clave nueva");
        }
        numElementos++;
        return null; // No existía antes
    }

    @Override
    public V obtener(K key) throws ElementoNoEncontrado {
        int indice = hash(key);
        Lista<Entrada<K, V>> bucket = tabla[indice];

        int pos = bucket.buscar(new Entrada<>(key, null));
        if (pos != -1) {
            try {
                return bucket.obtener(pos).valor;
            } catch (Exception ex) {
                throw new ElementoNoEncontrado("Error al obtener la clave");
            }
        }
        // No existe
        throw new ElementoNoEncontrado("Clave no encontrada: " + key);
    }

    @Override
    public V eliminar(K key) throws ElementoNoEncontrado {
        int indice = hash(key);
        Lista<Entrada<K, V>> bucket = tabla[indice];

        int pos = bucket.buscar(new Entrada<>(key, null));
        if (pos != -1) {
            try {
                V valorEliminado = bucket.obtener(pos).valor;
                bucket.delete(pos);
                numElementos--;
                return valorEliminado;
            } catch (Exception ex) {
                throw new ElementoNoEncontrado("Error al eliminar la clave");
            }
        }
        throw new ElementoNoEncontrado("Clave a eliminar no encontrada: " + key);
    }

    @Override
    public boolean contiene(K key) {
        try {
            this.obtener(key);
            return true;
        } catch (ElementoNoEncontrado ex) {
            return false;
        }
    }

    @Override
    public int talla() {
        return numElementos;
    }

    @Override
    public boolean esVacia() {
        return numElementos == 0;
    }

    @SuppressWarnings("unchecked")
    @Override
    public void borrar() {
        // Reemplaza cada bucket por uno nuevo
        for (int i = 0; i < tabla.length; i++) {
            tabla[i] = new ListaImpl<>();
        }
        numElementos = 0;
    }

    @Override
    public Iterator<K> iterator() {
        return new IteradorClaves();
    }

    // Iterador que recorre cada bucket y devuelve las claves
    private class IteradorClaves implements Iterator<K> {
        private int indiceActual = 0;
        private Iterator<Entrada<K, V>> iterBucket = null;

        IteradorClaves() {
            avanzarBucket();
        }

        private void avanzarBucket() {
            // Mientras no encontremos un bucket no vacío, avanzar
            while (indiceActual < tabla.length) {
                // Si el bucket actual no está vacío, obtenemos su iterador
                if (tabla[indiceActual].talla() > 0) {
                    iterBucket = tabla[indiceActual].iterator();
                    return;
                }
                indiceActual++;
            }
            iterBucket = null;
        }

        @Override
        public boolean hasNext() {
            if (iterBucket == null) {
                return false;
            }
            // Si el iter actual se acaba, pasamos al siguiente bucket
            if (!iterBucket.hasNext()) {
                indiceActual++;
                avanzarBucket();
                return iterBucket != null && iterBucket.hasNext();
            }
            return true;
        }

        @Override
        public K next() {
            if (!hasNext()) {
                return null;
            }
            // Tomamos la clave del elemento actual
            Entrada<K, V> e = iterBucket.next();
            return e.clave;
        }
    }
}