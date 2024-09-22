package com.codegym.orm.controller;

import com.codegym.orm.model.Bill;
import com.codegym.orm.model.Invoicee;
import com.codegym.orm.model.User;
import com.codegym.orm.service.impl.BillService;
import com.codegym.orm.service.impl.InvoiceService;
import com.codegym.orm.service.impl.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/invoice")
public class InvoiceController {

    @Autowired
    private InvoiceService invoiceService;

    @Autowired
    private UserService userService;

    @Autowired
    private BillService billService;

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

    @DeleteMapping("/deleteBill/{id}")
    public ResponseEntity<String> deleteBill(@PathVariable Long id) {

        List<Bill> bills = billService.findAllByUserId(id);
        if (!bills.isEmpty()) {
            for (Bill bill : bills) {
                billService.remove(bill.getId());
            }
            if (bills.get(0).getInvoicee() != null) {
                invoiceService.remove(bills.get(0).getInvoicee().getId());
                userService.remove(id);
            } else {
                userService.remove(id);
            }

        } else {
            userService.remove(id);
        }
        return new ResponseEntity<>("Successfully deleted", HttpStatus.OK);
    }

}
