package com.github.fashionbrot.funds.dao.impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.fashionbrot.funds.dao.FundValuationDao;
import com.github.fashionbrot.funds.entity.FundValuationEntity;
import com.github.fashionbrot.funds.mapper.FundValuationMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FundValuationDaoImpl  extends ServiceImpl<FundValuationMapper, FundValuationEntity> implements FundValuationDao {

    @Autowired
    private FundValuationMapper fundValuationMapper;



}
