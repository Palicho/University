package tp;

import javafx.geometry.Insets;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import javafx.stage.Stage;

public class ListaStage extends Stage {
    int column= 1;
    int row =1;
    private TableView table = new TableView();

    public ListaStage(Stage rootStage, Faktura faktura){

        Scene scene = new Scene(new Group());
        setTitle("Faktura");
        setWidth(300);
        setHeight(600);

        final Label label = new Label("Faktura "+ faktura.getId()+"/2019" );
        label.setFont(new Font("Arial", 20));

       // table.setEditable(true);


        TableColumn nazwaCol = new TableColumn("Nazwa");
        nazwaCol.setMinWidth(100);
        nazwaCol.setCellValueFactory(new PropertyValueFactory<Produkt, String>("nazwa"));

        TableColumn cenaCol = new TableColumn("Cena");
        cenaCol.setMinWidth(100);
        cenaCol.setCellValueFactory(new PropertyValueFactory<Produkt, String>("cena"));

        TableColumn iloscCol = new TableColumn("Ilosc");
        iloscCol.setMinWidth(100);
        iloscCol.setCellValueFactory( new PropertyValueFactory<Produkt, String>("ilosc"));

        table.setItems(faktura.getProdukty());
        table.getColumns().addAll( nazwaCol, cenaCol, iloscCol);


        final VBox vbox = new VBox();
        vbox.setSpacing(5);
        vbox.setPadding(new Insets(10, 0, 0, 10));
        vbox.getChildren().addAll(label, table);



        final VBox nab = new VBox();
        vbox.setSpacing(5);
        vbox.setPadding(new Insets(10, 0, 0, 10));
        vbox.getChildren().addAll(new Label("Nabywca:"),new Label("Nazwa: "+ faktura.getNabywca().getNazwa()),new Label("Adres: "+ faktura.getNabywca().getAdres()), new Label("NIP: "+ faktura.getNabywca().getNIP()) );


        final HBox hBox= new HBox();
        hBox.setSpacing(5);
        vbox.setPadding(new Insets(10, 0, 0, 10));
        hBox.getChildren().addAll(vbox,nab);
        ((Group) scene.getRoot()).getChildren().addAll(hBox);

        setScene(scene);

    }
}
