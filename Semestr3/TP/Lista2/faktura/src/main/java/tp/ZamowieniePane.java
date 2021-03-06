package tp;

import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.control.Button;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.stage.Stage;

import java.nio.Buffer;

public class ZamowieniePane extends BorderPane {
    private Button dodajButton, zakonczButton;

    public ZamowieniePane(FakturaStage rootStage) {
        dodajButton= new Button("Dodaj produkt do faktury");

        dodajButton.setOnAction(new EventHandler<ActionEvent>() {

            @Override
            public void handle(ActionEvent event) {
                setVisible(false);
                rootStage.produktPane.setVisible(true);

            }
        });



        zakonczButton = new Button( " Stwórz fakture ");

        zakonczButton.setOnAction(new EventHandler<ActionEvent>() {

            @Override
            public void handle(ActionEvent event) {
                rootStage.close();

            }
        });
        HBox hbox = new HBox();
        hbox.getChildren().addAll(dodajButton, zakonczButton);
        hbox.setAlignment( Pos.CENTER);
        BorderPane.setMargin(hbox, new Insets(12,12,12,12)); // optional

        setBottom(hbox);
        setVisible(false);
    }
}
