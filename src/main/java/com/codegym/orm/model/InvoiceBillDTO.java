package com.codegym.orm.model;

import java.util.List;

public class InvoiceBillDTO {
    private List<Long> bill_ids;
    private Long invoiceId;

    public InvoiceBillDTO() {
    }

    public InvoiceBillDTO(List<Long> bill_ids, Long invoiceId) {
        this.bill_ids = bill_ids;
        this.invoiceId = invoiceId;
    }

    public List<Long> getBill_ids() {
        return bill_ids;
    }

    public void setBill_ids(List<Long> bill_ids) {
        this.bill_ids = bill_ids;
    }

    public Long getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(Long invoiceId) {
        this.invoiceId = invoiceId;
    }
}
