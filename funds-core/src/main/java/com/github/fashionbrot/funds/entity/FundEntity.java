package com.github.fashionbrot.funds.entity;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

import java.util.Date;
import java.util.List;

/**
 * 基金表
 *
 * @author fashionbrot
 * @email fashionbrot@163.com
 * @date 2020-12-05
 */
@ApiModel(value = "基金表")
@Data
@TableName("fund")
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FundEntity {

	@TableId(type = IdType.AUTO)
	private Long id;

	@TableField(value = "create_id",fill = FieldFill.INSERT)
	private Long createId;

	@TableField(value="create_date",fill = FieldFill.INSERT)
	private Date createDate;

	@ApiModelProperty(value = "基金code")
	@TableField("fund_code")
	private String fundCode;

	@ApiModelProperty(value = "基金名称")
	@TableField("fund_name")
	private String fundName;

	@ApiModelProperty(value = "原费率")
	@TableField("fund_source_rate")
	private String fundSourceRate;

	@ApiModelProperty(value = "现费率")
	@TableField("fund_Rate")
	private String fundRate;

	@ApiModelProperty(value = "最小申购金额")
	@TableField("fund_minsg")
	private String fundMinsg;

	private transient List<FundValuationEntity> valuationList;

	private transient String guzhi;

	private transient String lastGuzhi;
}