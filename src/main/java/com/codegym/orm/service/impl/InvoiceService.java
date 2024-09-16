package com.codegym.orm.service.impl;

import com.codegym.orm.model.Invoicee;
import com.codegym.orm.repository.impl.InvoiceRepository;
import com.codegym.orm.service.IInvoiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InvoiceService implements IInvoiceService {
    @Autowired
    private InvoiceRepository invoiceRepository;

    @Override
    public List<Invoicee> findAll() {
        return List.of();
    }

    @Override
    public Invoicee findById(Long id) {
        return invoiceRepository.findById(id).get();
    }

    @Override
    public void save(Invoicee invoicee) {
        invoiceRepository.save(invoicee);
    }

    @Override
    public void remove(Long id) {

    }

    @Override
    public List<Invoicee> findByName(String name) {
        return List.of();
    }
}
