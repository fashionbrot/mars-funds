package com.github.fashionbrot.funds.vo;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class LoginVo {
    private String realName;
    private String roleName;
    private Long userId;
}
