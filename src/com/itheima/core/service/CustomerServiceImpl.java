package com.itheima.core.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itheima.common.utils.Page;
import com.itheima.core.dao.CustomerDao;
import com.itheima.core.po.Customer;

@Service
@Transactional
public class CustomerServiceImpl implements	CustomerService{
	@Autowired
	private CustomerDao customerDao;
	@Override
	public Page<Customer> findCustomerList(Integer page, Integer rows, String custName, String custSrouce,
			String custIndustry, String custLevel) {
		// TODO Auto-generated method stub
		Customer customer = new Customer();
		if(StringUtils.isNotBlank(custName))
			customer.setCust_name(custName);
		if(StringUtils.isNotBlank(custSrouce))
			customer.setCust_source(custSrouce);
		if (StringUtils.isNotBlank(custIndustry)) {
			customer.setCust_indesury(custIndustry);
		}
		if (StringUtils.isNotBlank(custLevel)) {
			customer.setCust_level(custLevel);
		}
		customer.setStart((page-1)*rows);
		customer.setRows(rows);
		List<Customer> customers = customerDao.selectCustomerList(customer);
		Integer count = customerDao.selectCustomerListCount(customer);
		Page<Customer> result = new Page<>();
		result.setPage(page);
		result.setRows(customers);
		result.setSize(rows);
		result.setTotal(count);
		return result;
	}
	public int createCustomer(Customer customer) {
		return customerDao.createCustomer(customer);
	}
	public Customer getCustomerById(Integer id) {
		Customer customer = customerDao.getCustomerById(id);
		return customer;
	}
	public int updateCustomer(Customer customer) {
		return customerDao.updateCustomer(customer);
	}
	public int deleteCustomer(Integer id) {
		return customerDao.deleteCustomer(id);
	}

}
