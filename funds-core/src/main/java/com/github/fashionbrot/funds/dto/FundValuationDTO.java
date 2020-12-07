package com.github.fashionbrot.funds.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;


/**
 * 基金估值表
 *
 * @author fashionbrot
 * @email fashionbrot@163.com
 * @date 2020-12-05
 */
@Data
@ApiModel(value = "基金估值表")
public class FundValuationDTO implements Serializable {
    private static final long serialVersionUID = 1L;

	@ApiModelProperty(value = "自增id")
	private Long id;

	@ApiModelProperty(value = "基金Id")
	private Long fundId;

	@ApiModelProperty(value = "日期")
	private String fundDate;

	@ApiModelProperty(value = "单位净值")
	private String dwjz;

	@ApiModelProperty(value = "估值")
	private String equityReturn;

}