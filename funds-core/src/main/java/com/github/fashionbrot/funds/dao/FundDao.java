package com.github.fashionbrot.funds.dao;


import com.baomidou.mybatisplus.extension.service.IService;
import com.github.fashionbrot.funds.entity.FundEntity;
import com.github.fashionbrot.funds.req.FundReq;

import java.util.List;


/**
 * 基金表
 *
 * @author fashionbrot
 * @email fashionbrot@163.com
 * @date 2020-12-05
 */

public interface FundDao extends IService<FundEntity> {


    List<FundEntity> pageList(FundReq req);
}