package exceptions;

public class ElementoNoEncontrado extends Exception{
    public ElementoNoEncontrado() {
        super("Elemento No Encontrado");
    }

    public ElementoNoEncontrado(String mensaje) {
        super(mensaje);
    }
}
