package com.jidnivai.labexamhelper.labexamhelper.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import com.jidnivai.labexamhelper.labexamhelper.entity.MyFile;
import com.jidnivai.labexamhelper.labexamhelper.service.FileService;
import com.jidnivai.labexamhelper.labexamhelper.service.HomeService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class HomeController {

    @Autowired
    HomeService homeService;
    @Autowired
    private FileService fileService;

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("drives", fileService.getDrives());
        model.addAttribute("currentDrive", fileService.getCurrentDrive());
        model.addAttribute("files", fileService.listAllFiles());
        model.addAttribute("parentPath", "");
        String target = "D:\\";
        int depth = 3;
        MyFile fileTree = fileService.getFilesTree(target, depth);
        model.addAttribute("fileTree", fileTree);
        model.addAttribute("flatFileList", fileService.flattenFiles(fileTree));

        return homeService.home();
    }

    @GetMapping("/directory/{path}")
    public String browseDirectory(@PathVariable String path, Model model) {
        model.addAttribute("drives", fileService.getDrives());
        model.addAttribute("currentDrive", fileService.getCurrentDrive());
        model.addAttribute("parentPath", path + ",");
        model.addAttribute("files", fileService.listAllFiles(path));
        return homeService.home();
    }

    @GetMapping("/drive/{driveLetter}")
    public String setDrive(@PathVariable String driveLetter) {
        fileService.setDrive(driveLetter);
        return "redirect:/";
    }

    @GetMapping("/file/{fileName}")
    public ResponseEntity<Resource> serveFile(@PathVariable String fileName) {
        try {
            Resource resource = fileService.loadFileAsResource(fileName);
            if (resource.exists()) {
                return ResponseEntity.ok()
                        .header("Content-Disposition", "inline; filename=\"" + resource.getFilename() + "\"")
                        .body(resource);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }

}
