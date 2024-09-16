package com.codegym.orm.service.impl;

import com.codegym.orm.model.User;
import com.codegym.orm.repository.impl.UserRepository;
import com.codegym.orm.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService implements IUserService {
    @Autowired
    private UserRepository userRepository;


    @Override
    public List<User> findAll() {
        return null;
    }

    @Override
    public User findById(Long id) {
        return userRepository.findById(id).get();
    }

    @Override
    public void save(User user) {
        userRepository.save(user);
    }

    @Override
    public void remove(Long id) {

    }

    @Override
    public List<User> findByName(String name) {
        return null;
    }

    @Override
    public User findByUsernameContainingIgnoreCase(String username) {
        return userRepository.findByUsernameContainingIgnoreCase(username);
    }

    @Override
    public List<User> findUserByUsernameContainingIgnoreCase(String username) {
        return userRepository.findUserByUsernameContainingIgnoreCase(username);
    }
}
