package com.github.fashionbrot.funds.dao.impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.fashionbrot.funds.dao.FundStockDao;
import com.github.fashionbrot.funds.entity.FundStockEntity;
import com.github.fashionbrot.funds.mapper.FundStockMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FundStockDaoImpl  extends ServiceImpl<FundStockMapper, FundStockEntity> implements FundStockDao {

    @Autowired
    private FundStockMapper fundStockMapper;



}
