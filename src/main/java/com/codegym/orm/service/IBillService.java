package com.codegym.orm.service;

import com.codegym.orm.model.Bill;
import com.codegym.orm.repository.IGenerateRepository;

import java.util.List;

public interface IBillService extends IGenerateRepository<Bill> {
    List<Bill> findAllByUserId(Long customerId);

    Bill findBillByBillId(Long billId);

    List<Bill> findAllByUserName(String userName);

}
