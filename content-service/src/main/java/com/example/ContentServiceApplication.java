package com.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * 内容服务启动类
 */
@SpringBootApplication
@EnableDiscoveryClient
public class ContentServiceApplication {
    
    public static void main(String[] args) {
        SpringApplication.run(ContentServiceApplication.class, args);
    }
} 