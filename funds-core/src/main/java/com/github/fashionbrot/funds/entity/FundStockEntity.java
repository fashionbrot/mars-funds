package com.github.fashionbrot.funds.entity;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

import java.util.Date;

/**
 * 基金-持仓股票
 *
 * @author fashionbrot
 * @email fashionbrot@163.com
 * @date 2020-12-05
 */
@ApiModel(value = "基金-持仓股票")
@Data
@TableName("fund_stock")
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class FundStockEntity {

	@TableId(type = IdType.AUTO)
	private Long id;

	@TableField(value = "create_id",fill = FieldFill.INSERT)
	private Long createId;

	@TableField(value="create_date",fill = FieldFill.INSERT)
	private Date createDate;

	@ApiModelProperty(value = "基金Id")
	@TableField("fund_id")
	private Long fundId;

	@ApiModelProperty(value = "股票code")
	@TableField("stock_code")
	private String stockCode;

	@ApiModelProperty(value = "股票名称")
	@TableField("stock_name")
	private String stockName;
}