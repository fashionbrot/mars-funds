package com.github.fashionbrot.funds.entity;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

import java.util.Date;

/**
 * 基金估值表
 *
 * @author fashionbrot
 * @email fashionbrot@163.com
 * @date 2020-12-05
 */
@ApiModel(value = "基金估值表")
@Data
@TableName("fund_valuation")
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FundValuationEntity {

	@TableId(type = IdType.AUTO)
	private Long id;

	@ApiModelProperty(value = "基金code")
	@TableField("fund_code")
	private String fundCode;

	@ApiModelProperty(value = "日期")
	@TableField("fund_date")
	private Date fundDate;

	@ApiModelProperty(value = "单位净值")
	@TableField("dwjz")
	private Double dwjz;

	@ApiModelProperty(value = "估值")
	@TableField("equity_return")
	private Double equityReturn;
}