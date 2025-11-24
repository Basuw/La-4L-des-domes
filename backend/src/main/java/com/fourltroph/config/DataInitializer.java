package com.fourltroph.config;

import com.fourltroph.entity.Color;
import com.fourltroph.entity.Product;
import com.fourltroph.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class DataInitializer implements CommandLineRunner {
    
    private final ProductRepository productRepository;
    
    @Override
    public void run(String... args) {
        try {
            if (productRepository.count() == 0) {
                log.info("Initializing products data...");
                initializeProducts();
                log.info("Products data initialized successfully");
            } else {
                log.info("Products already exist (count: {}), skipping initialization", productRepository.count());
            }
        } catch (Exception e) {
            log.error("Error initializing products data", e);
        }
    }
    
    private void initializeProducts() {
        // T-Shirt Classique
        Product tshirt = Product.builder()
                .name("T-Shirt 4L Trophy")
                .description("T-shirt officiel du 4L Trophy avec le logo emblématique")
                .price(new BigDecimal("25.00"))
                .stock(100)
                .colors(new ArrayList<>())
                .build();
        
        Color whiteColor = Color.builder()
                .name("White")
                .label("Blanc")
                .hex("#FFFFFF")
                .frontImage("/clothes/front-white-t-shirt.png")
                .backImage("/clothes/back-white-t-shirt.png")
                .product(tshirt)
                .build();
        
        Color blackColor = Color.builder()
                .name("Black")
                .label("Noir")
                .hex("#000000")
                .frontImage("/clothes/front-black-t-shirt.png")
                .backImage("/clothes/back-black-t-shirt.png")
                .product(tshirt)
                .build();
        
        tshirt.getColors().add(whiteColor);
        tshirt.getColors().add(blackColor);
        
        // Pull
        Product pull = Product.builder()
                .name("Pull 4L Trophy")
                .description("Pull confortable aux couleurs du 4L Trophy")
                .price(new BigDecimal("45.00"))
                .stock(50)
                .colors(new ArrayList<>())
                .build();
        
        Color beigeColor = Color.builder()
                .name("Beige")
                .label("Beige")
                .hex("#D4C5B9")
                .frontImage("/clothes/front-beige-pull.png")
                .backImage("/clothes/back-beige-pull.png")
                .product(pull)
                .build();
        
        Color blueColor = Color.builder()
                .name("Blue")
                .label("Bleu")
                .hex("#4A90E2")
                .frontImage("/clothes/front-blue-pull.png")
                .backImage("/clothes/back-blue-pull.png")
                .product(pull)
                .build();
        
        pull.getColors().add(beigeColor);
        pull.getColors().add(blueColor);
        
        productRepository.saveAll(List.of(tshirt, pull));
    }
}
