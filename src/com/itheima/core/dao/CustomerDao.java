package com.itheima.core.dao;

import java.util.List;

import com.itheima.core.po.Customer;

public interface CustomerDao {
	public List<Customer> selectCustomerList(Customer customer);
	public Integer selectCustomerListCount(Customer customer);
	public int createCustomer(Customer customer);
	public Customer getCustomerById(Integer id);
	public int updateCustomer(Customer customer);
	public int deleteCustomer(Integer id);
}
