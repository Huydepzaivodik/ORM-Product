package com.codegym.orm.service.impl;

import com.codegym.orm.model.Bill;
import com.codegym.orm.repository.impl.BillRepository;
import com.codegym.orm.service.IBillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BillService implements IBillService {
    @Autowired
    private BillRepository billRepository;

    @Override
    public List<Bill> findAll() {
        return billRepository.findAll();
    }

    @Override
    public Bill findById(Long id) {
        return billRepository.findById(id).get();
    }

    @Override
    public void save(Bill bill) {
        billRepository.save(bill);
    }

    @Override
    public void remove(Long id) {
        billRepository.deleteById(id);
    }

    @Override
    public List<Bill> findByName(String name) {
        return null;
    }

    @Override
    public List<Bill> findAllByUserId(Long customerId) {
        return billRepository.findAllByUserId(customerId);
    }

    @Override
    public Bill findBillByBillId(Long billId) {
        return billRepository.findBillByBillId(billId);
    }

    @Override
    public List<Bill> findAllByUserName(String userName) {
        return billRepository.findAllByUserName(userName);
    }
}
