package com.codegym.orm.controller;

import com.codegym.orm.model.Bill;
import com.codegym.orm.model.User;
import com.codegym.orm.service.impl.BillService;
import com.codegym.orm.service.impl.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@CrossOrigin("*")
@Controller
@RequestMapping("/users")
public class UserController {

    @Autowired
    private BillService billService;

    @Autowired
    private UserService userService;

    @PostMapping("/addUser")
    public ModelAndView addUser(@ModelAttribute User user, HttpSession session) {
//        User u = userService.findByUsernameContainingIgnoreCase(user.getUsername());
//        if (u != null) {
//            redirectAttributes.addFlashAttribute("error", "Tên khách hàng này đã tồn tại !");
//            return new ModelAndView("redirect:/users/formUser");
//        } else {
            userService.save(user);
            session.setAttribute("currentUser", user);
            return new ModelAndView("redirect:/bills/show");

    }

    @GetMapping("/formUser")
    public ModelAndView formUser(@ModelAttribute("error") String error) {
        ModelAndView modelAndView = new ModelAndView("FormUser");
        modelAndView.addObject("error", error); // Thêm thông báo lỗi nếu có
        return modelAndView;
    }

    @PostMapping("/edit")
    public ModelAndView edit(HttpSession session, @RequestParam Long id, @RequestParam String name, @RequestParam String phone, @RequestParam String address) {
        User user = new User(id, name, phone, address);
        userService.save(user);
        if (session.getAttribute("currentUser") != null) {
            session.removeAttribute("currentUser");
        }
        session.setAttribute("currentUser", user);
        return new ModelAndView("redirect:/bills/show");
    }

    @PostMapping("/add")
    public ResponseEntity<String> add(@RequestBody User user) {
        userService.save(user);
        System.out.println("User received: " + user);
        return ResponseEntity.ok("User added successfully");
    }

    @PostMapping("/updateUser")
    public ResponseEntity<User> update(@RequestBody User user, HttpSession session) {
        userService.save(user);
        session.setAttribute("currentUser", user);
        return ResponseEntity.ok(user);
    }

    @GetMapping("/search")
    public ModelAndView search(@RequestParam("username") String username) {
        List<User> list = userService.findUserByUsernameContainingIgnoreCase(username);
        List<Bill> bills = billService.findAllByUserName(username);
        ModelAndView modelAndView = new ModelAndView("CheckInvoice");
        modelAndView.addObject("list", list);
        modelAndView.addObject("bills", bills);
        return modelAndView;
    }


}
