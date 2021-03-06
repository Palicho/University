import eu.jpereira.trainings.designpatterns.structural.proxy.TrafficLightsManager;
import eu.jpereira.trainings.designpatterns.structural.proxy.TrafficLightsManagerTest;
import eu.jpereira.trainings.designpatterns.structural.proxy.fakes.FakeProxyTrafficLightFactory;
import eu.jpereira.trainings.designpatterns.structural.proxy.testconfig.TestConfiguration;
import org.junit.Before;

public class ProxyTrafficLightsManagerTest  extends TrafficLightsManagerTest {

    @Before
    public  void setUp(){
        TestConfiguration.fakeFailuresInController = true;
    }

    @Override
    protected TrafficLightsManager createTrafficLightsManager(){
        TrafficLightsManager menger = new TrafficLightsManager(new FakeProxyTrafficLightFactory());
        return menger;
    }

}
