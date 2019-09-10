package com.itheima.core.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itheima.core.dao.BaseDictDao;
import com.itheima.core.po.BaseDict;

@Service("baseDictService")
public class BaseDictServiceImpl implements BaseDictService{
	@Autowired
	private BaseDictDao baseDictDao;
	@Override
	public List<BaseDict> findBaseDictByTypeCode(String typecode) {
		// TODO Auto-generated method stub
		return baseDictDao.selectBaseDictByTypeCode(typecode);
	}

}
