package com.jidnivai.labexamhelper.labexamhelper.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jidnivai.labexamhelper.labexamhelper.entity.MyFile;
import com.jidnivai.labexamhelper.labexamhelper.service.FileService;

import java.net.URI;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@RestController
@RequestMapping("/file")
public class FileController {

    @Autowired
    FileService fileService;

    private String target = "B:\\";

    @GetMapping("/listAllFiles/{path}")
    public List<MyFile> getFileList(@PathVariable String path) {
        return fileService.getFileList(path);
    }

    @GetMapping("/safeToggle/{path}")
    public ResponseEntity<Void> safeToggle(@PathVariable String path) {
        String decodedPath = path.replace(",", "\\");
        fileService.safeToggle(decodedPath);
        return ResponseEntity.status(HttpStatus.FOUND)
                .location(URI.create("/"))
                .build();
    }

    @GetMapping("/exceptionToggle/{path}")
    public ResponseEntity<Void> exceptionTogle(@PathVariable String path) {
        String decodedPath = path.replace(",", "\\");
        fileService.exceptionToggle(decodedPath);
        return ResponseEntity.status(HttpStatus.FOUND)
                .location(URI.create("/"))
                .build();
    }

    @GetMapping("/markAllSafe")
    public ResponseEntity<Void> markAllSafe() {
        fileService.markAllSafe(target,5);
        return ResponseEntity.status(HttpStatus.FOUND)
                .location(URI.create("/"))
                .build();
    }

    @GetMapping("/markAllUnsafe")
    public ResponseEntity<Void> markAllUnsafe() {
        fileService.markAllUnsafe();
        return ResponseEntity.status(HttpStatus.FOUND)
                .location(URI.create("/"))
                .build();
    }

    @GetMapping("/markAllNoException")
    public ResponseEntity<Void> markAllNoException() {
        fileService.markAllNoException();
        return ResponseEntity.status(HttpStatus.FOUND)
                .location(URI.create("/"))
                .build();
    }

    @GetMapping("/deleteAllUnsafe")
    public ResponseEntity<Void> deleteAllUnsafe() {
        fileService.deleteAllUnsafe(target,5);
        return ResponseEntity.status(HttpStatus.FOUND)
                .location(URI.create("/"))
                .build();
    }

}
