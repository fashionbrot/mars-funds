package com.github.fashionbrot.funds.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;


/**
 * 用户持仓基金
 *
 * @author fashionbrot
 * @email fashionbrot@163.com
 * @date 2020-12-07
 */
@Data
@ApiModel(value = "用户持仓基金")
public class FundHoldDTO implements Serializable {
    private static final long serialVersionUID = 1L;

	@ApiModelProperty(value = "自增id")
	private Long id;

	@ApiModelProperty(value = "股票code")
	private String fundCode;

	@ApiModelProperty(value = "股票名称")
	private String fundName;

	@ApiModelProperty(value = "用户")
	private String userName;

}