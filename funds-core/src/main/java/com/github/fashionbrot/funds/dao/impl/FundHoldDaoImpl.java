package com.github.fashionbrot.funds.dao.impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.fashionbrot.funds.dao.FundHoldDao;
import com.github.fashionbrot.funds.entity.FundHoldEntity;
import com.github.fashionbrot.funds.mapper.FundHoldMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FundHoldDaoImpl extends ServiceImpl<FundHoldMapper, FundHoldEntity> implements FundHoldDao {

    @Autowired
    private FundHoldMapper fundHoldMapper;



}
