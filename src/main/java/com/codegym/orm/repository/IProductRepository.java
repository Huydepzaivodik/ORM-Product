package com.codegym.orm.repository;

import com.codegym.orm.model.Product;

import java.util.List;

public interface IProductRepository extends IGenerateRepository<Product>{
    List<Product> findAllByPrice(double from, double to);
}
