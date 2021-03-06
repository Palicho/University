import eu.jpereira.trainings.designpatterns.structural.proxy.TrafficLightsManagerTest;
import eu.jpereira.trainings.designpatterns.structural.proxy.testconfig.TestConfiguration;
import org.junit.Test;

public class TrafficLightsMenagerTest extends TrafficLightsManagerTest {
    public void setUp(){
        TestConfiguration.fakeFailuresInController = true;

    }

}
