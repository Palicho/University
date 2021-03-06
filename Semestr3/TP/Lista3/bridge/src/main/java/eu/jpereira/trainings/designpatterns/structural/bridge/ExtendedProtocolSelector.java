package eu.jpereira.trainings.designpatterns.structural.bridge;

import eu.jpereira.trainings.designpatterns.structural.bridge.protocol.BluethoothProtocol;
import eu.jpereira.trainings.designpatterns.structural.bridge.protocol.Protocol;
import eu.jpereira.trainings.designpatterns.structural.bridge.protocol.ProtocolSelector;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

public class ExtendedProtocolSelector extends ProtocolSelector {

    @Override
    protected Collection<Protocol> createAditionalProtocols() {
        List<Protocol> list = new ArrayList<Protocol>();
        list.add(new BluethoothProtocol());
        return list;
    }

}
