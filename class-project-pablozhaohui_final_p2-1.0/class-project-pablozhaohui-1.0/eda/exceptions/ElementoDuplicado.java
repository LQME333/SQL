package exceptions;

public class ElementoDuplicado extends Exception{
    public ElementoDuplicado(){
        super("Elemento Duplicado");
    }

    public ElementoDuplicado(String mensaje) {
        super(mensaje);
    }
}