package com.codegym.orm.repository.impl;

import com.codegym.orm.model.Bill;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BillRepository extends JpaRepository<Bill, Long> {

    @Query(value = "select b from Bill b where b.user.id = :user_id")
    List<Bill> findAllByUserId(@Param("user_id") Long id);

    @Query(value = "select b from Bill b where b.id = :id")
    Bill findBillByBillId(@Param("id") Long id);

    @Query(value = "select b from Bill b where b.user.id =:id")
    List<Bill> findBillByUserId(@Param("id") Long id);

    @Query(value = "SELECT b FROM Bill b JOIN b.user u WHERE u.username LIKE %:userName%")
    List<Bill> findAllByUserName(@Param("userName") String userName);
}
