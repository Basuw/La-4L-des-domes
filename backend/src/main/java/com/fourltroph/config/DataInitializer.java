package com.fourltroph.config;

import com.fourltroph.entity.Product;
import com.fourltroph.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;

@Component
@RequiredArgsConstructor
public class DataInitializer implements CommandLineRunner {
    
    private final ProductRepository productRepository;
    
    @Override
    public void run(String... args) {
        if (productRepository.count() == 0) {
            Product tshirt1 = Product.builder()
                    .name("T-shirt 4L Trophy - Landscape")
                    .description("T-shirt premium en coton bio, édition exclusive 4L des Dômes. Design unique inspiré du désert marocain. Fabriqué à Clermont-Ferrand.")
                    .price(new BigDecimal("19.99"))
                    .size("M")
                    .stock(50)
                    .imageUrl("/t-shirt/front-t-shirt-landscape-no-background.png")
                    .build();
            
            Product tshirt2 = Product.builder()
                    .name("T-shirt 4L Trophy - Sponsors")
                    .description("T-shirt sportswear respirant, parfait pour l'aventure. Collection 4L des Dômes avec logo brodé. Fabriqué à Clermont-Ferrand.")
                    .price(new BigDecimal("19.99"))
                    .size("L")
                    .stock(50)
                    .imageUrl("/t-shirt/front-t-shirt-sponsor-no-background.png")
                    .build();
            
            productRepository.save(tshirt1);
            productRepository.save(tshirt2);
        }
    }
}
