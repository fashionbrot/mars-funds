package com.github.fashionbrot.funds.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;


/**
 * 基金表
 *
 * @author fashionbrot
 * @email fashionbrot@163.com
 * @date 2020-12-05
 */
@Data
@ApiModel(value = "基金表")
public class FundDTO implements Serializable {
    private static final long serialVersionUID = 1L;

	@ApiModelProperty(value = "自增id")
	private Long id;

	@ApiModelProperty(value = "基金code")
	private String fundCode;

	@ApiModelProperty(value = "基金名称")
	private String fundName;

	@ApiModelProperty(value = "原费率")
	private String fundSourceRate;

	@ApiModelProperty(value = "现费率")
	private String fundRate;

	@ApiModelProperty(value = "最小申购金额")
	private String fundMinsg;

}