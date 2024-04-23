package com.codegym.orm.controller;

import com.codegym.orm.model.Product;
import com.codegym.orm.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private IProductService productService;

    @GetMapping("/show")
    public ModelAndView showProductList() {
        List<Product> productList = productService.findAll();
        ModelAndView modelAndView = new ModelAndView("products");
        modelAndView.addObject("productList", productList);
        return modelAndView;
    }

    @GetMapping("/edit/{id}")
    public ModelAndView showProductDetail(@PathVariable Long id) {
        Product product = productService.findById(id);
        ModelAndView modelAndView = new ModelAndView("productInformation");
        modelAndView.addObject("product", product);
        return modelAndView;

    }

    @PostMapping("/add")
    public String addProduct(@ModelAttribute Product product) {
        productService.save(product);
        return "redirect:/products/show";
    }

    @PostMapping("/edit")
    public String editProduct(@ModelAttribute Product product) {
        productService.save(product);
        return "redirect:/products/show";
    }

    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable Long id) {
        productService.remove(id);
        return "redirect:/products/show";
    }

    @GetMapping("/searchName")
    public ModelAndView searchName(@RequestParam String name) {
        List<Product> productList = productService.findByName(name);
        ModelAndView modelAndView = new ModelAndView("products");
        modelAndView.addObject("productList", productList);
        return modelAndView;
    }

    @GetMapping("/searchPrice")
    public ModelAndView searchPrice(@RequestParam int priceSelect) {
        ModelAndView modelAndView = new ModelAndView("products");

        if (priceSelect == 1) {
            List<Product> productList = productService.findAllByPrice(1000, 2000);
            modelAndView.addObject("productList", productList);
        } else if (priceSelect == 2) {
            List<Product> productList = productService.findAllByPrice(2000, 3000);
            modelAndView.addObject("productList", productList);
        } else if (priceSelect == 0) {
            List<Product> productList = productService.findAll();
            modelAndView.addObject("productList", productList);
        } else {
            List<Product> productList = productService.findAllByPrice(3000, 99999);
            modelAndView.addObject("productList", productList);
        }
        return modelAndView;

    }

}
