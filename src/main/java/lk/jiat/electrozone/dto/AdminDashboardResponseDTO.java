package lk.jiat.ElectroZone.dto;

import java.util.List;

public class AdminDashboardResponseDTO {
    private boolean status;
    private String message;
    
    private double totalRevenue;
    private long totalOrders;
    private long totalProducts;
    private long totalCustomers;
    
    private List<InvoiceDTO> recentOrders;
    private List<ProductDTO> lowStockAlerts;

    public boolean isStatus() { return status; }
    public void setStatus(boolean status) { this.status = status; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    
    public double getTotalRevenue() { return totalRevenue; }
    public void setTotalRevenue(double totalRevenue) { this.totalRevenue = totalRevenue; }
    public long getTotalOrders() { return totalOrders; }
    public void setTotalOrders(long totalOrders) { this.totalOrders = totalOrders; }
    public long getTotalProducts() { return totalProducts; }
    public void setTotalProducts(long totalProducts) { this.totalProducts = totalProducts; }
    public long getTotalCustomers() { return totalCustomers; }
    public void setTotalCustomers(long totalCustomers) { this.totalCustomers = totalCustomers; }
    
    public List<InvoiceDTO> getRecentOrders() { return recentOrders; }
    public void setRecentOrders(List<InvoiceDTO> recentOrders) { this.recentOrders = recentOrders; }
    public List<ProductDTO> getLowStockAlerts() { return lowStockAlerts; }
    public void setLowStockAlerts(List<ProductDTO> lowStockAlerts) { this.lowStockAlerts = lowStockAlerts; }
}
