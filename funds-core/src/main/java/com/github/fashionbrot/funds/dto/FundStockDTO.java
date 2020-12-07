package com.github.fashionbrot.funds.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;


/**
 * 基金-持仓股票
 *
 * @author fashionbrot
 * @email fashionbrot@163.com
 * @date 2020-12-05
 */
@Data
@ApiModel(value = "基金-持仓股票")
public class FundStockDTO implements Serializable {
    private static final long serialVersionUID = 1L;

	@ApiModelProperty(value = "自增id")
	private Long id;

	@ApiModelProperty(value = "基金Id")
	private Long fundId;

	@ApiModelProperty(value = "股票code")
	private String stockCode;

	@ApiModelProperty(value = "股票名称")
	private String stockName;

}