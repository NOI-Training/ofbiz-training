package test.org;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ofbiz.base.lang.JSON;
import org.apache.ofbiz.entity.Delegator;
import org.apache.ofbiz.entity.GenericValue;

import java.util.List;

public class getTasks {
    public static String getTasks(HttpServletRequest request,
                                  HttpServletResponse response)
            throws Exception {

        Delegator delegator = (Delegator) request.getAttribute("delegator");

        List<GenericValue> tasks =
                delegator.findAll("ClsTask", false);

        response.setContentType("application/json");
        response.getWriter().write(
                JSON.from(tasks).toString()
        );

        return "success";
    }

}
