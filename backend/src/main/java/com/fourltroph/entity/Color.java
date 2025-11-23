package com.fourltroph.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "colors")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Color {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    @JsonBackReference
    private Product product;
    
    @Column(nullable = false)
    private String name;
    
    @Column(nullable = false)
    private String label;
    
    @Column(nullable = false)
    private String hex;
    
    @Column(nullable = false)
    private String frontImage;
    
    @Column(nullable = false)
    private String backImage;
}
