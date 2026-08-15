package lk.jiat.ElectroZone.controller.api;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.MultivaluedMap;
import jakarta.ws.rs.core.Response;
import lk.jiat.ElectroZone.service.OrderService;
import lk.jiat.ElectroZone.util.Env;
import lk.jiat.ElectroZone.util.PayHereUtil;

import java.net.URI;

@Path("/payments")
public class PaymentController {
    @Path("/return")
    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public Response paymentSuccess(@QueryParam("order_id") String payhereOrderId) {

        OrderService orderService = new OrderService();
        try {

            int oId = Integer.parseInt(payhereOrderId.replaceAll(lk.jiat.ElectroZone.validation.Validator.NON_DIGIT_PATTERN, ""));
            org.hibernate.Session hibernateSession = lk.jiat.ElectroZone.util.HibernateUtil.getSessionFactory().openSession();
            lk.jiat.ElectroZone.entity.Order order = hibernateSession.find(lk.jiat.ElectroZone.entity.Order.class, oId);
            if (order != null && "PENDING".equals(order.getStatus().getValue())) {
                orderService.completeOrder(payhereOrderId);
            }
            hibernateSession.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Response.seeOther(URI.create(Env.get("app.url") + "/invoice.jsp?orderId=" + payhereOrderId)).build();
    }

    @Path("/cancel")
    @GET
    public Response paymentCancel() {
        System.out.println("Payment canceled");
        return Response.ok().build();
    }

    @Path("/notify")
    @POST
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public Response paymentNotify(MultivaluedMap<String, String> form) {
        String orderId = form.getFirst("order_id");
        String statusCode = form.getFirst("status_code");

        if (!PayHereUtil.validateNotify(form)) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("INVALID SIGNATURE").build();
        }

        OrderService orderService = new OrderService();
        if (Integer.parseInt(statusCode) == PayHereUtil.PAYMENT_SUCCESS) {

            orderService.completeOrder(orderId);
        } else {

            orderService.failedOrder(orderId);
        }
        return Response.ok().build();
    }
}
