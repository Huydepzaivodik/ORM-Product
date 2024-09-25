package com.codegym.orm.model;
import javax.persistence.*;
import java.util.Date;
@Entity

public class Bill {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Date date;
    private String nameProduct;
    private Double quantity;
    private String unit;
    private Double price;
    private Double amount;

    @ManyToOne
    private User user;

    @ManyToOne
    private Invoicee invoicee;

    public Bill() {
    }

    public Bill(Long id, Date date, String nameProduct, Double quantity, String unit, Double price, Double amount, User user, Invoicee invoicee) {
        this.id = id;
        this.date = date;
        this.nameProduct = nameProduct;
        this.quantity = quantity;
        this.unit = unit;
        this.price = price;
        this.amount = amount;
        this.user = user;
        this.invoicee = invoicee;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getNameProduct() {
        return nameProduct;
    }

    public void setNameProduct(String nameProduct) {
        this.nameProduct = nameProduct;
    }

    public Double getQuantity() {
        return quantity;
    }

    public void setQuantity(Double quantity) {
        this.quantity = quantity;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Invoicee getInvoicee() {
        return invoicee;
    }

    public void setInvoicee(Invoicee invoicee) {
        this.invoicee = invoicee;
    }
}
