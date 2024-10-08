package com.codegym.orm.repository.impl;

import com.codegym.orm.model.Invoicee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface InvoiceRepository extends JpaRepository<Invoicee, Long> {

}
