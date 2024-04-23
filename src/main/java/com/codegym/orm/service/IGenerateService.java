package com.codegym.orm.service;

import java.util.List;

public interface IGenerateService <T>{
    List<T> findAll();

    T findById(Long id);

    void save(T t);

    void remove(Long id);

    List<T> findByName(String name);

}
