package tp;

import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.HBox;
import javafx.stage.Stage;
import javafx.scene.control.Button;


/**
 * JavaFX App
 */
public class App extends Application {

    ManagerFaktur managerFaktur;
    private BorderPane grid;
    Button addButton;
    Button showButton;


    @Override
    public  final void start(Stage stage) {

        stage.setTitle("FakturoMania");
        grid = new BorderPane();;
        grid.setPadding(new Insets(25, 25, 25, 25));

        managerFaktur = ManagerFaktur.getInstance();

        addButton = new Button("Nowa faktura");
        showButton= new Button("Wyświetl faktury");



        addButton.setOnAction(new EventHandler<ActionEvent>() {

            @Override
            public void handle(ActionEvent event) {

                FakturaStage fakturaStage = new FakturaStage( stage, managerFaktur.createFaktura() );
                fakturaStage.show();
            }
        });



        showButton.setOnAction(new EventHandler<ActionEvent>() {

            @Override
            public void handle(ActionEvent event) {

                ListaStage listaStage = new ListaStage(stage, managerFaktur.getFaktura(0));
                listaStage.show();

            }
        });

        Scene scene = new Scene(grid, 640, 480);
        HBox hbox = new HBox();

        hbox.getChildren().addAll(addButton, showButton);
        hbox.setAlignment( Pos.CENTER);
        BorderPane.setMargin(hbox, new Insets(12,12,12,12)); // optional

        grid.setBottom(hbox);
        stage.setScene(scene);
        stage.show();
    }


    public static void main(String[] args) {
        launch();
    }

}