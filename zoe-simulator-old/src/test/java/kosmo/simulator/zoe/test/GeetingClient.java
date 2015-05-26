package kosmo.simulator.zoe.test;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.client.RestTemplate;

import kosmo.simulator.zoe.GreetingRequest;
import kosmo.simulator.zoe.GreetingResponse;

/**
 * Tests the REST greeting controller.
 * 
 * 
 */
public class GeetingClient extends AbstractTest {

    private final RestTemplate template = new RestTemplate();

    @Value("${test.greeting.URL}")
    private String greetingURL;

    @Test
    public void greeting() {
        GreetingRequest request = new GreetingRequest();
        request.setName("Mr");
        request.setSurname("Foo");
        GreetingResponse response = template.postForObject(greetingURL,
                request, GreetingResponse.class);
        log.info(response.getGreeting());
        Assert.assertEquals("Hello, Mr Foo!", response.getGreeting());
    }

}
