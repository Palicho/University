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

public class FirmaPane extends GridPane {

    private Label labelNazwa, labelNIP, labelAdres;
    private TextField textFieldNazwa, textFieldNIP, textFieldAdres;
    private Button button;
    private HBox hbButton;

    private String nazwa,  adres, NIP;

    public FirmaPane( FakturaStage rootStage) {
        setAlignment(Pos.CENTER);
        setHgap(10);
        setVgap(10);
        setPadding(new Insets(25, 25, 25, 25));

        Text scenetitle = new Text("Podaj dane firmy");

        labelNazwa = new Label("Nazwa:");
        textFieldNazwa = new TextField();

        labelNIP = new Label("NIP:");
        textFieldNIP = new TextField();

        labelAdres = new Label("Adres:");
        textFieldAdres = new TextField();

        button = new Button("Dalej");
        button.setOnAction(new EventHandler<ActionEvent>() {

            @Override
            public void handle(ActionEvent event) {
                try{
                    rootStage.faktura.dodajFirme(getFirma());
                    setVisible(false);
                    rootStage.zamowieniePane.setVisible(true);
                }
                catch (IllegalArgumentException e){

                }
            }
        });

        add(scenetitle, 0, 0, 2, 1);


        add(labelNazwa,0,1);
        add(textFieldNazwa, 1, 1);

        add(labelAdres, 0, 2);
        add(textFieldAdres, 1, 2);

        add(labelNIP, 0, 3);
        add(textFieldNIP, 1, 3);

        hbButton = new HBox(10);
        hbButton.setAlignment(Pos.CENTER);
        hbButton.getChildren().add(button);

        add(hbButton,1,4);
        setVisible(false);
    }

    public Firma getFirma() throws  IllegalArgumentException{
        nazwa= textFieldNazwa.getText();
        NIP = textFieldNIP.getText();
        adres = textFieldAdres.getText();

        return   new Firma(nazwa, NIP, adres);
    }
}
