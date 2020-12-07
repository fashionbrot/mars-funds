package com.github.fashionbrot.funds.entity;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

import java.util.Date;

/**
 * 用户持仓基金
 *
 * @author fashionbrot
 * @email fashionbrot@163.com
 * @date 2020-12-07
 */
@ApiModel(value = "用户持仓基金")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@TableName("fund_hold")
public class FundHoldEntity  {


	@TableId(type = IdType.AUTO)
	private Long id;

	@TableField(value="create_date",fill = FieldFill.INSERT)
	private Date createDate;

	@ApiModelProperty(value = "基金code")
	@TableField("fund_code")
	private String fundCode;

	@ApiModelProperty(value = "基金名称")
	@TableField("fund_name")
	private String fundName;

	@ApiModelProperty(value = "用户")
	@TableField("user_name")
	private String userName;


	private transient String fundCodes;
}