
package com.github.fashionbrot.funds.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.fashionbrot.funds.entity.FundEntity;
import com.github.fashionbrot.funds.req.FundReq;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 基金表
 *
 * @author fashionbrot
 * @email fashionbrot@163.com
 * @date 2020-12-05
 */
@Mapper
public interface FundMapper extends BaseMapper<FundEntity> {


    List<FundEntity> pageList(FundReq req);
}