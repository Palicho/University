package tp;

import javafx.css.Match;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Firma {

    private String nazwa, NIP, adres;

    private static final String patternNip="\\d{10}";
    Pattern pattern = Pattern.compile(patternNip);
    Matcher matcher;
    public Firma( String nazwa, String NIP, String adres) throws IllegalArgumentException{
        matcher= pattern.matcher(NIP);
        this.nazwa=nazwa;
        if (matcher.matches())
            this.NIP=NIP;
        else
            throw new IllegalArgumentException();
        this.adres=adres;
    }

    public String getNazwa() {
        return nazwa;
    }

    public String getAdres() {
        return adres;
    }

    public String getNIP() {
        return NIP;
    }
}
