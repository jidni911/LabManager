package com.jidnivai.labexamhelper.labexamhelper.entity;

import java.util.List;


import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Transient;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class MyFile {

    @Id
    private String path;//absolute path
    private String name;
    private Boolean isDirectory;//true if it is a folder
    @Transient
    private Boolean isSafe = false;
    private Boolean isException = false;//exception for system file
    

    
    @Transient
    private List<MyFile> children;
    

}
