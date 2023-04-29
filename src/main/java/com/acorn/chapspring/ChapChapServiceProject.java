package com.acorn.chapspring;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;

@SpringBootApplication
@PropertySources(@PropertySource("classpath:/env.properties"))
public class ChapChapServiceProject {


    
    public static void main(String[] args) {
        SpringApplication.run(ChapChapServiceProject.class, args);
    }

}
