package com.github.fashionbrot.funds.dao.impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.fashionbrot.funds.dao.FundDao;
import com.github.fashionbrot.funds.entity.FundEntity;
import com.github.fashionbrot.funds.mapper.FundMapper;
import com.github.fashionbrot.funds.req.FundReq;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FundDaoImpl  extends ServiceImpl<FundMapper, FundEntity> implements FundDao {

    @Autowired
    private FundMapper fundMapper;


    @Override
    public List<FundEntity> pageList(FundReq req) {
        return fundMapper.pageList(req);
    }
}
