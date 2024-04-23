package com.codegym.orm.controller;

import com.codegym.orm.model.Student;
import com.codegym.orm.service.IStudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/students")
public class StudentController {
    @Autowired
    private IStudentService studentService;

    @GetMapping("/show")
    public ModelAndView showStudentList() {
        List<Student> studentList = studentService.findAll();
        ModelAndView modelAndView = new ModelAndView("students");
        modelAndView.addObject("studentList", studentList);
        return modelAndView;
    }

    @PostMapping("/add")
    public String addStudent(@ModelAttribute Student student) {
        studentService.save(student);
        return "redirect:/students/show";
    }

    @GetMapping("/edit/{id}")
    public ModelAndView showStudentDetail(@PathVariable Long id) {
        Student student = studentService.findById(id);
        ModelAndView modelAndView = new ModelAndView("StudentInformation", "student", student);
        return modelAndView;

    }



    @PostMapping("/edit")
    public String editStudent(@ModelAttribute Student student) {
        studentService.save(student);
        return "redirect:/students/show";
    }

    @GetMapping("/delete/{id}")
    public String deleteStudent(@PathVariable Long id) {
        studentService.remove(id);
        return "redirect:/students/show";

    }

    @GetMapping("/searchName")
    public ModelAndView searchName(@RequestParam String name) {
        List<Student> studentList = studentService.findByName(name.trim());
        ModelAndView modelAndView = new ModelAndView("students", "studentList", studentList);
        return modelAndView;
    }


}
