package app.bean;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/SalesReportController")
public class SalesReportController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "report";

        try {
            if ("dashboard".equals(action)) {
                showDashboard(request, response);
            } else {
                showReport(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void showReport(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String startStr = request.getParameter("start");
        String endStr = request.getParameter("end");

        Date start = (startStr != null && !startStr.isEmpty()) ? Date.valueOf(startStr) : null;
        Date end   = (endStr != null && !endStr.isEmpty()) ? Date.valueOf(endStr) : null;

        List<SalesReport> report = SalesReportDAO.getSales(start, end);

        request.setAttribute("report", report);
        request.setAttribute("totalCarsSold", SalesReportDAO.getTotalCarsSold(start, end));
        request.setAttribute("totalRevenue", SalesReportDAO.getTotalRevenue(start, end));
        request.setAttribute("totalCommission", SalesReportDAO.getTotalCommission(start, end));
        request.setAttribute("carsInInventory", SalesReportDAO.getCarsInInventory());

        RequestDispatcher rd = request.getRequestDispatcher("salesreport.jsp");
        rd.forward(request, response);
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        // KPIs (all time)
        request.setAttribute("totalCarsSold", SalesReportDAO.getTotalCarsSold(null, null));
        request.setAttribute("totalRevenue", SalesReportDAO.getTotalRevenue(null, null));
        request.setAttribute("totalCommission", SalesReportDAO.getTotalCommission(null, null));
        request.setAttribute("carsInInventory", SalesReportDAO.getCarsInInventory());

        // Tables replacing charts
        request.setAttribute("monthlySales", SalesReportDAO.getMonthlySalesLast6());
        request.setAttribute("stockByBrand", SalesReportDAO.getStockByBrand());

        // Recent sales table in dashboard (reuse your report list, just show top 5 in JSP)
        request.setAttribute("recentSales", SalesReportDAO.getSales(null, null));

        RequestDispatcher rd = request.getRequestDispatcher("Dashboard.jsp");
        rd.forward(request, response);
    }
}
