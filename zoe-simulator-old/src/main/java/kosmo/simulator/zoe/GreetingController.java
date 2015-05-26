package kosmo.simulator.zoe;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * REST controller example.
 * 
 * 
 */
@RestController
@RequestMapping(value = "/greeting",
        produces = MediaType.APPLICATION_JSON_VALUE)
public class GreetingController {

    private static final String GREETING_TEMPLATE = "Hello, %s!";

    private static final Log LOG = LogFactory.getLog(GreetingController.class);

    /**
     * Example of a GET operation without parameters.
     * <p>
     * To call this method uses an URL like "/greeting".
     */
    @RequestMapping(method = RequestMethod.GET)
    public GreetingResponse exampleWithoutParameters() {
        LOG.debug("exampleWithoutParameters");
        GreetingResponse response = new GreetingResponse();
        response.setGreeting(String.format(GREETING_TEMPLATE, "World"));
        return response;
    }

    /**
     * Example of a POST operation with a JSON request
     * <p>
     * To call this method POST to an URL like "/greeting".
     */
    @RequestMapping(method = RequestMethod.POST)
    public GreetingResponse exampleWithJsonPost(
            @RequestBody GreetingRequest request) {
        LOG.debug("exampleWithJsonPost");
        GreetingResponse response = new GreetingResponse();
        response.setGreeting(String.format(GREETING_TEMPLATE, request.getName()
                + " " + request.getSurname()));
        return response;
    }

    /**
     * Example of an operation with path variables.
     * <p>
     * To call this method uses an URL like "/greeting/Foo".
     */
    @RequestMapping(value = "/{name}", method = RequestMethod.GET)
    public GreetingResponse exampleWithPathVariables(
            @PathVariable("name") String name) {
        LOG.debug("exampleWithPathVariables");
        GreetingResponse response = new GreetingResponse();
        response.setGreeting(String.format(GREETING_TEMPLATE, name));
        return response;
    }

    /**
     * Example of an operation with standard request parameters.
     * <p>
     * To call this method uses an URL like "/greeting/params?name=Foo".
     */
    @RequestMapping("/params")
    public GreetingResponse exampleWithParameters(
            @RequestParam("name") String name) {
        LOG.debug("exampleWithParameters");
        GreetingResponse response = new GreetingResponse();
        response.setGreeting(String.format(GREETING_TEMPLATE, name));
        return response;
    }

}
