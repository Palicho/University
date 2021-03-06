package eu.jpereira.trainings.designpatterns.structural.bridge;

import eu.jpereira.trainings.designpatterns.structural.bridge.protocol.BluethoothProtocol;
import eu.jpereira.trainings.designpatterns.structural.bridge.protocol.Protocol;

public class BluethoothProtocolTest extends  ProtocolTest {

    /**
     * Factory method
     *
     * @return
     */
    @Override
    protected Protocol createProtocolUnderTest() {
        return new BluethoothProtocol();
    }
}
