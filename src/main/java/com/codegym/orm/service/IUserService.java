package com.codegym.orm.service;

import com.codegym.orm.model.User;
import com.codegym.orm.repository.IGenerateRepository;

import java.util.List;

public interface IUserService extends IGenerateRepository<User> {
    User findByUsernameContainingIgnoreCase(String username);
    List<User> findUserByUsernameContainingIgnoreCase(String username);

}
