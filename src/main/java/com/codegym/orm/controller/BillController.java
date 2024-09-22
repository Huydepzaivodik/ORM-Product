package com.codegym.orm.controller;

import com.codegym.orm.model.Bill;
import com.codegym.orm.model.InvoiceBillDTO;
import com.codegym.orm.model.Invoicee;
import com.codegym.orm.model.User;
import com.codegym.orm.repository.impl.BillRepository;
import com.codegym.orm.service.impl.BillService;
import com.codegym.orm.service.impl.InvoiceService;
import com.codegym.orm.service.impl.UserService;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/bills")
public class BillController {

    @Autowired
    private InvoiceService invoiceService;

    @Autowired
    private BillService billService;

    @Autowired
    private UserService userService;

    @GetMapping("/show")
    public ModelAndView getBill(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView("TaoHoaDon");
        modelAndView.addObject("currentUser", session.getAttribute("currentUser"));
        return modelAndView;
    }

    @PostMapping("/create")
    public ResponseEntity<String> createBill(@RequestBody List<Bill> bills) {
        for (Bill bill : bills) {
            billService.save(bill);
        }
        return ResponseEntity.ok("Items saved successfully");
    }

    @GetMapping("/showInvoice")
    public ModelAndView getInvoice(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView("ShowInvoice");

        User user = (User) session.getAttribute("currentUser");
        List<Bill> bills = billService.findAllByUserId(user.getId());

        double totalAmount = 0;
        for (Bill bill : bills) {
            totalAmount += bill.getAmount();
        }

        modelAndView.addObject("totalAmount", totalAmount);
        modelAndView.addObject("bills", bills);
        modelAndView.addObject("billsJson", new Gson().toJson(bills));
        modelAndView.addObject("currentUser", user);
        return modelAndView;
    }

    @PostMapping("/updateBill")
    public ResponseEntity<String> updateBill(@RequestBody Bill bill) {
        Bill existingBill = billService.findBillByBillId(bill.getId());

        // Cập nhật các trường khác, ngoại trừ Date
        existingBill.setNameProduct(bill.getNameProduct());
        existingBill.setQuantity(bill.getQuantity());
        existingBill.setUnit(bill.getUnit());
        existingBill.setPrice(bill.getPrice());
        existingBill.setAmount(bill.getAmount());

        // Giữ nguyên giá trị Date hiện tại
        existingBill.setDate(existingBill.getDate());

        // Lưu bill đã được cập nhật
        billService.save(existingBill);

        return ResponseEntity.ok("Items updated successfully");
    }

    @DeleteMapping("/deleteBill/{id}")
    public ResponseEntity<String> deleteBill(@PathVariable Long id) {
        billService.remove(id);
        return ResponseEntity.ok("Items deleted successfully");
    }

    @GetMapping("/backToHome")
    private ModelAndView backToHome(HttpSession session) {
        session.removeAttribute("currentUser");
        ModelAndView modelAndView = new ModelAndView("Home");
        return modelAndView;
    }

    @PostMapping("/editBillWithInvoiceId")
    private ResponseEntity<String> editBillWithInvoiceId(@RequestBody InvoiceBillDTO invoiceBillDTO) {

        Long invoiceId = invoiceBillDTO.getInvoiceId();
        List<Long> billIds = invoiceBillDTO.getBill_ids();

        Invoicee invoicee = invoiceService.findById(invoiceId);


        for (Long billId : billIds) {
            Bill existingBill = billService.findBillByBillId(billId);
            existingBill.setInvoicee(invoicee);
            billService.save(existingBill);
        }

        return ResponseEntity.ok("Items updated successfully");

    }

    @GetMapping("/showTheBillById")
    private ModelAndView showTheBillById(@RequestParam("id") Long id) {
        User user = userService.findById(id);
        List<Bill> bills = billService.findAllByUserId(id);


        // Kiểm tra xem bills có rỗng không
        if (bills == null || bills.isEmpty()) {
            // Tạo ModelAndView cho trang hiển thị lỗi
            ModelAndView modelAndView = new ModelAndView("CheckBill");
            modelAndView.addObject("error", "Người này chưa có hóa đơn gì! Hãy xóa đơn này để tạo lại !");
            modelAndView.addObject("user", user);
            return modelAndView;
        }

        double totalAmount = 0;
        for (Bill bill : bills) {
            totalAmount += bill.getAmount();
            System.out.println(bill.getNameProduct());
        }
        ModelAndView modelAndView = new ModelAndView("CheckBill");
        modelAndView.addObject("totalAmount", totalAmount);
        modelAndView.addObject("bills", bills);
        modelAndView.addObject("user", user);
        return modelAndView;
    }

}
