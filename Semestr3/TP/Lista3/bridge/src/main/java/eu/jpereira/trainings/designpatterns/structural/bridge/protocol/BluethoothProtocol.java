package eu.jpereira.trainings.designpatterns.structural.bridge.protocol;

public class BluethoothProtocol extends Protocol {

    /**
     * Start a session
     */
    @Override
    public void startSession() {
        super.setSessionActive(true);

    }

    /**
     * End a session
     */
    @Override
    public void endSession() {
        super.setSessionActive(false);

    }
}
