package com.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

/**
 * 服务发现中心启动类
 */
@SpringBootApplication
@EnableEurekaServer
public class DiscoveryServerApplication {
    
    public static void main(String[] args) {
        SpringApplication.run(DiscoveryServerApplication.class, args);
    }
} 