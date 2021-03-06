package eu.jpereira.trainings.designpatterns.structural.decorator.channel.decorator;

import java.util.ArrayList;

public class WordCensor  extends SocialChannelDecorator{

    String[] uglyWords= new String[]{"wow", "pow"};

    @Override
    public void deliverMessage(String message) {

        for(String word : uglyWords){
            message=removeUglyWords(message,word);
        }
        delegate.deliverMessage(message);

    }

    private String removeUglyWords(String message, String uglyWord){

        return message.replaceAll(uglyWord, "******");
    }
}
