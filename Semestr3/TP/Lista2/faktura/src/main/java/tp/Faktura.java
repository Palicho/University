package tp;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

public class Faktura {

    private int id;
    private ObservableList<Produkt> produkty;
    private Firma nabywca;
    // super konrad supeer!!!

   public void dodajProdukt(Produkt produkt){
       produkty.add(produkt);
   }

   public Faktura( int id){
       produkty = FXCollections.observableArrayList();
       this.id = id;
   }

   public void dodajFirme(Firma firma){
       this.nabywca=firma;
   }

   public ObservableList<Produkt> getProdukty(){
       return produkty;
   }

   public int getId() { return id;
   }

   public int getWartosc(){
       int wartosc=0;
       for( Produkt produkt : produkty){
           wartosc=produkt.getCena();
       }
       return wartosc;
   }

   public Firma getNabywca(){
       return nabywca;
   }



}
