package com.itheima.core.web.controller;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itheima.common.utils.Page;
import com.itheima.core.po.BaseDict;
import com.itheima.core.po.Customer;
import com.itheima.core.po.User;
import com.itheima.core.service.BaseDictService;
import com.itheima.core.service.CustomerService;

@Controller
public class CustomerController {
	@Autowired
	private CustomerService customerService;
	@Autowired
	private BaseDictService baseDictService;
	@Value("${customer.from.type}")
	private String FROM_TYPE;
	@Value("${customer.industry.type}")
	private String INDUSTRY_TYPE;
	@Value("${customer.level.type}")
	private String LEVEL_TYPE;
	@RequestMapping(value = "/customer/list.action")
	public String list(@RequestParam(defaultValue = "1")Integer page,@RequestParam(defaultValue = "10")Integer rows,String custName,String custSource,String custIndustry,String custLevel,Model model) {
		Page<Customer> customers = customerService.findCustomerList(page, rows, custName, custSource, custIndustry, custLevel);
		model.addAttribute("page",customers);
		List<BaseDict> fromType = baseDictService.findBaseDictByTypeCode(FROM_TYPE);
		List<BaseDict> industryType = baseDictService.findBaseDictByTypeCode(INDUSTRY_TYPE);
		List<BaseDict> levelType = baseDictService.findBaseDictByTypeCode(LEVEL_TYPE);
		model.addAttribute("fromType",fromType);
		model.addAttribute("industryType",industryType);
		model.addAttribute("levelType",levelType);
		model.addAttribute("custName",custName);
		model.addAttribute("custSource",custSource);
		model.addAttribute("custIndustry",custIndustry);
		model.addAttribute("custLevel",custLevel);
		return "customer";
	}
	@RequestMapping("customer/create.action")
	@ResponseBody
	public String customerCreate(Customer customer,HttpSession session) {
		User user = (User) session.getAttribute("USER_SESSION");
		customer.setCust_create_id(user.getUser_id());
		Date date = new Date();
		Timestamp timestamp = new Timestamp(date.getTime());
		customer.setCust_createtime(timestamp);
		int rows = customerService.createCustomer(customer);
		if(rows > 0)
			return "OK";
		else {
			return "FALT";
		}
	}
	@RequestMapping("customer/getCustomerById.action")
	@ResponseBody
	public Customer getCustomerById(Integer id) {
		Customer customer = customerService.getCustomerById(id);
		System.out.print(1);
		return customer;
	}
	@RequestMapping("customer/update.action")
	@ResponseBody
	public String customerUpdate(Customer customer) {
		int rows = customerService.updateCustomer(customer);
		System.out.println();
		if(rows > 0)
			return "OK";
		else {
			return "FALT";
		}
	}
	@RequestMapping("/customer/delete.action")
	@ResponseBody
	public String customerDelete(Integer id) {
		int rows = customerService.deleteCustomer(id);
		if(rows > 0)
			return "OK";
		else
			return "FALT";
	}
}
