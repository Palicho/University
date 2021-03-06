package tp;

import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.text.Text;

public class ProduktPane extends GridPane {

    private Label labelNazwa, labelCena, labelIlosc, labelVAT;
    private TextField textFieldNazwa, textFieldCena, textFieldIlosc, textFieldVAT;
    private Button button;
    private HBox hbButton;

    private String nazwa;
    private  int cena, ilosc;

    public ProduktPane( FakturaStage stage ) {

        setAlignment(Pos.CENTER);
        setHgap(10);
        setVgap(10);
        setPadding(new Insets(25, 25, 25, 25));

        Text scenetitle = new Text("Podaj dane produktu");

        labelNazwa = new Label("Nazwa:");
        textFieldNazwa = new TextField();

        labelCena = new Label("Cena:");
        textFieldCena = new TextField();

        labelIlosc = new Label("Ilosc:");
        textFieldIlosc = new TextField();


        button = new Button("Dodaj");

        button.setOnAction(new EventHandler<ActionEvent>() {

            @Override
            public void handle(ActionEvent event) {
                try{
                    stage.faktura.dodajProdukt(getProdukt());
                    setVisible(false);
                    stage.zamowieniePane.setVisible(true);
                }
                catch (NumberFormatException e){

                }
            }
        });


        add(scenetitle, 0, 0, 2, 1);


        add(labelNazwa,0,1);
        add(textFieldNazwa, 1, 1);

        add(labelIlosc, 0, 2);
        add(textFieldIlosc, 1, 2);

        add(labelCena, 0, 3);
        add(textFieldCena, 1, 3);



        hbButton = new HBox(10);
        hbButton.setAlignment(Pos.CENTER);
        hbButton.getChildren().add(button);

        add(hbButton,1,5);
        setVisible(false);
    }


    public Produkt getProdukt() throws NumberFormatException{

        nazwa = textFieldNazwa.getText();
        cena = Integer.parseInt( textFieldCena.getText());
        ilosc = Integer.parseInt(textFieldIlosc.getText());



        textFieldNazwa.clear();
        textFieldCena.clear();
        textFieldIlosc.clear();

        return new Produkt(nazwa,cena, ilosc);
    }

}
