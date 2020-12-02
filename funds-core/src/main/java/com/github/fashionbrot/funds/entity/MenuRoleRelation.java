package com.github.fashionbrot.funds.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author fashionbrot
 * @version 0.1.0
 * @date 2019/12/8 22:45
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@TableName("menu_role_relation")
public class MenuRoleRelation extends BaseEntity{


    @TableField("menu_id")
    private Long menuId;

    @TableField("role_id")
    private Long roleId;
}
