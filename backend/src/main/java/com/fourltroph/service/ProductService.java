package com.fourltroph.service;

import com.fourltroph.dto.ColorResponse;
import com.fourltroph.dto.ProductResponse;
import com.fourltroph.entity.Color;
import com.fourltroph.entity.Product;
import com.fourltroph.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductService {
    
    private final ProductRepository productRepository;
    
    public List<ProductResponse> getAllProducts() {
        return productRepository.findAll().stream()
                .map(this::mapToProductResponse)
                .collect(Collectors.toList());
    }
    
    public ProductResponse getProductById(Long id) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found: " + id));
        return mapToProductResponse(product);
    }
    
    public List<ProductResponse> getAvailableProducts() {
        return productRepository.findByStockGreaterThan(0).stream()
                .map(this::mapToProductResponse)
                .collect(Collectors.toList());
    }
    
    private ProductResponse mapToProductResponse(Product product) {
        return ProductResponse.builder()
                .id(product.getId())
                .name(product.getName())
                .description(product.getDescription())
                .price(product.getPrice())
                .stock(product.getStock())
                .size(product.getSize())
                .colors(product.getColors().stream()
                        .map(this::mapToColorResponse)
                        .collect(Collectors.toList()))
                .createdAt(product.getCreatedAt())
                .build();
    }
    
    private ColorResponse mapToColorResponse(Color color) {
        return ColorResponse.builder()
                .id(color.getId())
                .name(color.getName())
                .label(color.getLabel())
                .hex(color.getHex())
                .frontImage(color.getFrontImage())
                .backImage(color.getBackImage())
                .build();
    }
}
