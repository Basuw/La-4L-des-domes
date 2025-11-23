package com.fourltroph.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ColorResponse {
    private Long id;
    private String name;
    private String label;
    private String hex;
    private String frontImage;
    private String backImage;
}
