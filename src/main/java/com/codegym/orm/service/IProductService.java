package com.codegym.orm.service;

import com.codegym.orm.model.Product;

import java.util.List;

public interface IProductService extends IGenerateService<Product>{
    List<Product> findAllByPrice(double from, double to);
}
