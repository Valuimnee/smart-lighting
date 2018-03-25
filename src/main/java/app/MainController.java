package app;

import app.backend.dbDriver;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@MultipartConfig
@WebServlet("/controller")
public class MainController extends HttpServlet {

    private dbDriver db;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        System.out.println("[main controller] init");
        db = new dbDriver();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doAction(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doAction(request, response);
    }

    private void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            request.setAttribute("status", "404");
            request.getRequestDispatcher("/").forward(request, response);
            return;
        }
        System.out.println("[main controller] " + action);
        switch (action) {
            case "get-roads":
                request.setAttribute("roads", db.getRoads());
                break;
            case "get-stats":
                request.setAttribute("stats", db.getStats());
                break;
            case "get-sensors":
                request.setAttribute("noRoads", db.getNotWorkingRoads());
                break;
            case "report": {
                int id=Integer.valueOf(request.getParameter("id"));
                int total=Integer.valueOf(request.getParameter("total"));
                db.addRoadSensor(id, total);
                break;
            }
        }
        if (request.getAttribute("status") == null) {
            request.setAttribute("status", "200");
        }
        System.out.println("[main controller] " + request.getAttribute("status"));
        request.getRequestDispatcher("/").forward(request, response);
    }
}