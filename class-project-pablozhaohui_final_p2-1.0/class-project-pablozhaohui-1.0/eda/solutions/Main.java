package solutions;

import adt.Lista;
import ds.ListaImpl;
import ds.AVLImpl;
import ds.BSTImpl;
import exceptions.IndiceError;
import java.util.Iterator;

public class Main {
    public static void main(String[] args) {
        // === Lista ===
        Lista<Integer> lista = new ListaImpl<>();
        try {
            lista.insertar(0, 10);
            lista.insertar(1, 20);
            lista.insertar(2, 30);
            lista.insertar(3, 40);
            System.out.println("Talla actual: " + lista.talla());
            System.out.println("Elemento en pos 2: " + lista.obtener(2));
            int pos20 = lista.buscar(20);
            System.out.println("El 20 está en la posición: " + pos20);
            lista.delete(1);
            System.out.println("Talla después de eliminar pos 1: " + lista.talla());
            System.out.println("Recorriendo la lista con for:");
            for (int i = 0; i < lista.talla(); i++) {
                System.out.println(lista.obtener(i));
            }
            System.out.println("Recorriendo la lista con el iterador:");
            Iterator<Integer> it = lista.iterator();
            while (it.hasNext()) System.out.println(it.next());
            // provoca excepción
            lista.delete(0);
            lista.delete(0);
            lista.delete(0);
            lista.delete(0);
        } catch (IndiceError e) {
            System.out.println("Error lista: " + e.getMessage());
        }


        // === BST ===
        BSTImpl bst = new BSTImpl();
        int[] valsBST = {30, 20, 40, 10, 25, 35, 50};
        for (int v : valsBST) bst.add(v);
        System.out.println("\nRecorridos BST tras inserciones:");
        System.out.print("Preorden: ");
        for (BSTImpl.Nodo n : bst.preorden()) System.out.print(n.valor + " ");
        System.out.print("\nInorden:  ");
        for (BSTImpl.Nodo n : bst.inorden())  System.out.print(n.valor + " ");
        System.out.print("\nPostorden:");
        for (BSTImpl.Nodo n : bst.postorden()) System.out.print(n.valor + " ");
        System.out.println();
        // search, min, max
        int claveBST = 25;
        System.out.println("Buscar " + claveBST + " en BST: " + (bst.search(claveBST) != null ? "encontrado" : "no encontrado"));
        System.out.println("Mínimo BST: " + bst.min().valor);
        System.out.println("Máximo BST: " + bst.max().valor);
        // eliminar
        bst.delete(20);
        bst.delete(30);
        System.out.println("\nRecorridos BST tras eliminaciones (20,30):");
        System.out.print("Inorden:  "); for (BSTImpl.Nodo n : bst.inorden()) System.out.print(n.valor + " ");
        System.out.println();

        // === AVL ===
        AVLImpl avl = new AVLImpl();
        int[] valsAVL = {30, 20, 40, 10, 25, 35, 50};
        for (int v : valsAVL) avl.add(v);
        System.out.println("\nRecorridos AVL tras inserciones:");
        System.out.print("Preorden: ");
        for (AVLImpl.Nodo n : avl.preorden()) System.out.print(n.valor + " ");
        System.out.print("\nInorden:  ");
        for (AVLImpl.Nodo n : avl.inorden())  System.out.print(n.valor + " ");
        System.out.print("\nPostorden:");
        for (AVLImpl.Nodo n : avl.postorden()) System.out.print(n.valor + " ");
        System.out.println();
        // search, min, max
        int claveAVL = 25;
        AVLImpl.Nodo encontradoAVL = avl.search(claveAVL);
        System.out.println("Buscar " + claveAVL + ": " + (encontradoAVL != null ? "encontrado" : "no encontrado"));
        System.out.println("Mínimo AVL: " + avl.min().valor);
        System.out.println("Máximo AVL: " + avl.max().valor);
        // eliminar
        avl.delete(20);
        avl.delete(30);
        System.out.println("\nRecorridos AVL tras eliminaciones (20,30):");
        System.out.print("Inorden:  "); for (AVLImpl.Nodo n : avl.inorden()) System.out.print(n.valor + " ");
        System.out.println();

    }

}
