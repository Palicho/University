package tp;

import javafx.scene.Scene;
import javafx.scene.layout.StackPane;
import javafx.stage.Stage;

public class FakturaStage extends Stage {

    public FirmaPane firmaPane;
    public ProduktPane produktPane;
    public ZamowieniePane zamowieniePane;
    public ListaStage listaStage;
    public StackPane rootPane;
    private Scene scene;

    private int width= 460 , height= 200;

    public Faktura faktura;


    public FakturaStage(Stage rootStage, Faktura faktura) {

        setTitle("Nowa Faktura");
        this.faktura= faktura;

        rootPane= new StackPane();
        scene= new Scene(rootPane, width, height);


        firmaPane = new FirmaPane(this);
        produktPane = new ProduktPane(this);
        zamowieniePane = new ZamowieniePane(this);

        rootPane.getChildren().addAll(firmaPane, zamowieniePane, produktPane);
        firmaPane.setVisible(true);

        setScene(scene);
        setX(rootStage.getX()+ (rootStage.getWidth()-width)/2);
        setY(rootStage.getY() + (rootStage.getHeight()-height)/2);

    }

}

