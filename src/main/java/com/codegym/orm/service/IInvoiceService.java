package com.codegym.orm.service;

import com.codegym.orm.model.Invoicee;
import com.codegym.orm.repository.IGenerateRepository;
import org.springframework.stereotype.Service;

@Service
public interface IInvoiceService extends IGenerateRepository<Invoicee> {


}
