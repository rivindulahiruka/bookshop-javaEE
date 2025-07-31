package main.model;

import java.sql.Timestamp;
import java.util.List;

public class Order {
    private int id;
    private int customerId;
    private String itemsJson;
    private double total;
    private Timestamp createdAt;

    public Order() {}

    public Order(int customerId, String itemsJson, double total) {
        this.customerId = customerId;
        this.itemsJson = itemsJson;
        this.total = total;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }
    public String getItemsJson() { return itemsJson; }
    public void setItemsJson(String itemsJson) { this.itemsJson = itemsJson; }

    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }


}
