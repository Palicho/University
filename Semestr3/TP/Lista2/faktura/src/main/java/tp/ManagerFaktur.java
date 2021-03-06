package tp;

import java.util.ArrayList;

public class ManagerFaktur {

    private static final ManagerFaktur  instance = new ManagerFaktur();
    private static int numer =0;
    private ArrayList<Faktura> faktury;

    private ManagerFaktur(){
        faktury= new ArrayList<Faktura>();
    }

    public void nowaFaktura(Faktura faktura){
        faktury.add(faktura);
    }

    public Faktura createFaktura(){
        Faktura faktura= new Faktura(numer);
        nowaFaktura(faktura);
        return faktura;
    }

    public Faktura getFaktura(int id){
        return faktury.get(id);
    }

    public static int getNumer() {
        return numer;
    }

    public ArrayList<Faktura> getFaktury() {
        return faktury;
    }

    public static ManagerFaktur getInstance() {
        return instance;
    }
}
