package eu.jpereira.trainings.designpatterns.structural.decorator.channel;

import eu.jpereira.trainings.designpatterns.structural.decorator.channel.decorator.AbstractSocialChanneldDecoratorTest;
import eu.jpereira.trainings.designpatterns.structural.decorator.channel.decorator.MessageTruncator;
import eu.jpereira.trainings.designpatterns.structural.decorator.channel.decorator.URLAppender;
import eu.jpereira.trainings.designpatterns.structural.decorator.channel.decorator.WordCensor;
import eu.jpereira.trainings.designpatterns.structural.decorator.channel.spy.TestSpySocialChannel;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class ChainCensorDecoratorTest extends AbstractSocialChanneldDecoratorTest {

    @Test
    public void testChainTwoDecorators() {
        // Create the builder
        SocialChannelBuilder builder = createTestSpySocialChannelBuilder();

        // create a spy social channel
        SocialChannelProperties props = new SocialChannelProperties().putProperty(SocialChannelPropertyKey.NAME, TestSpySocialChannel.NAME);

        // Chain decorators
        SocialChannel channel = builder.
                with(new MessageTruncator(10)).
                with(new WordCensor()).
                getDecoratedChannel(props);

        channel.deliverMessage("wow this is a message");
        // Spy channel. Should get the one created before
        TestSpySocialChannel spyChannel = (TestSpySocialChannel) builder.buildChannel(props);
        assertEquals("****** thi...", spyChannel.lastMessagePublished());
    }

}
