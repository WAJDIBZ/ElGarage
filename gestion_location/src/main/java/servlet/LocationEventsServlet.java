package servlet;

import doo.LocationDAO;
import entity.Location;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;
import com.google.gson.*;

@WebServlet("/LocationEvents")
public class LocationEventsServlet extends HttpServlet {
    private final LocationDAO dao = new LocationDAO();
    private final Gson gson = new GsonBuilder()
            .setDateFormat("yyyy-MM-dd")
            .create();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Location> locs = dao.getAllLocations();
        // Adapter pour FullCalendar
        JsonArray events = new JsonArray();
        for (Location l : locs) {
            JsonObject e = new JsonObject();
            e.addProperty("title",
                    "Client #" + l.getCodeClient() + " → " + l.getMatricule());
            e.addProperty("start", l.getDateDebut().toString());
            // FullCalendar attend end exclusive, on ajoute un jour pour inclure la fin
            Date fin = l.getDateFin();
            JsonPrimitive end = new JsonPrimitive(
                    fin.toLocalDate().plusDays(1).toString());
            e.add("end", end);
            events.add(e);
        }
        resp.setContentType("application/json");
        try (PrintWriter out = resp.getWriter()) {
            out.print(gson.toJson(events));
        }
    }
}
