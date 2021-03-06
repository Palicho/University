package tp;

import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;

public class Produkt {

    private SimpleStringProperty nazwa;
    private SimpleIntegerProperty cena, ilosc;


    public Produkt(String nazwa, int cena, int  ilosc){
        this.nazwa=new SimpleStringProperty(nazwa);
        this.cena=new SimpleIntegerProperty(cena);
        this.ilosc=new SimpleIntegerProperty(ilosc);
    }

    public String getNazwa(){
        return nazwa.get();
    }

    public int getCena() {
        return cena.get();
    }

    public int getIlosc() {
        return ilosc.get();
    }

    public void setNazwa(String nazwa) {
        this.nazwa.set(nazwa);
    }

    public void setCena(int cena) {
        this.cena.set(cena);
    }

    public void setIlosc(int ilosc) {
        this.ilosc.set(ilosc);
    }


    public int wartoscNetto(){
        return 0;
    }

    public int wartoscBrutto(){
        return 0;
    }
}
