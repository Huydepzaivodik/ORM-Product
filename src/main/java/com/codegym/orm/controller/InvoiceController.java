package com.codegym.orm.controller;

import com.codegym.orm.model.Invoicee;
import com.codegym.orm.service.impl.InvoiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/invoice")
public class InvoiceController {

    @Autowired
    private InvoiceService invoiceService;

    @PostMapping("/addInvoice")
    public ResponseEntity<Invoicee> addInvoice(@RequestBody Invoicee invoicee) {
        invoiceService.save(invoicee);
        return new ResponseEntity<>(invoicee, HttpStatus.CREATED);
    }


    @GetMapping("/checkInvoice")
    public ModelAndView checkInvoice() {
        ModelAndView mav = new ModelAndView("CheckInvoice");
        return mav;
    }

    @PutMapping("/edit")
    public ResponseEntity<String> editInvoice(@RequestBody Invoicee invoice) {
        invoiceService.save(invoice);
        return new ResponseEntity<>("Successfully edited", HttpStatus.OK);
    }

}
