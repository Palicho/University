import eu.jpereira.trainings.designpatterns.structural.proxy.TrafficLightsManager;
import eu.jpereira.trainings.designpatterns.structural.proxy.TrafficLightsManagerTest;
import eu.jpereira.trainings.designpatterns.structural.proxy.fakes.FakeResilientTrafficLightFactory;
import eu.jpereira.trainings.designpatterns.structural.proxy.testconfig.TestConfiguration;

public class ResilientTrafficLightsManagerTest extends TrafficLightsManagerTest {

    public  void setUp(){
        TestConfiguration.fakeFailuresInController= false;
    }

    @Override
    protected TrafficLightsManager createTrafficLightsManager(){
        TrafficLightsManager  trafficLightsManager= new TrafficLightsManager(new FakeResilientTrafficLightFactory());
        return  trafficLightsManager;

    }
}
