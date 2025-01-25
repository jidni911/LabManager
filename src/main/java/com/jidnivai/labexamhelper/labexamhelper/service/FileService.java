package com.jidnivai.labexamhelper.labexamhelper.service;

// FileService.java
import java.io.File;
import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;

import com.jidnivai.labexamhelper.labexamhelper.entity.MyFile;
import com.jidnivai.labexamhelper.labexamhelper.repository.MyFileRepository;

@Service
public class FileService {

    @Autowired
    MyFileRepository myFileRepository;

    private String currentDrive = "C:";

    private Set<String> exceptionSet = new HashSet<>();
    private Set<String> safeSet = new HashSet<>();

    public List<File> listAllFiles() {
        File rootDir = new File(currentDrive + "/");
        File[] files = rootDir.listFiles();
        if (files == null) {
            return new ArrayList<>();
        } else {
            return new ArrayList<>(List.of(files));
        }
    }

    public List<String> getDrives() {

        File[] rootDir = File.listRoots();
        List<String> drives = new ArrayList<>();
        for (int i = 0; i < rootDir.length; i++) {
            drives.add(rootDir[i].toPath().toString().substring(0, 2));
        }
        return drives;
    }

    public void setDrive(String driveLetter) {
        currentDrive = driveLetter;
    }

    public String getCurrentDrive() {
        return currentDrive;
    }

    public List<File> listAllFiles(String path) {
        File dir = new File(currentDrive + "/" + path.replace(",", "/"));
        List<File> files = Arrays.asList(dir.listFiles());

        return files == null ? new ArrayList<>() : files;
    }

    public List<MyFile> getFileList(String path) {
        File dir = new File(path.replace(",", "/"));
        List<File> files = Arrays.asList(dir.listFiles());

        List<MyFile> myFiles = new ArrayList<>();
        for (File file : files) {
            MyFile myFile = new MyFile();
            myFile.setName(file.getName());
            myFile.setPath(file.getAbsolutePath().replace("\\", ","));
            myFile.setIsDirectory(file.isDirectory());
            myFiles.add(myFile);
        }

        return myFiles;
    }

    public Resource loadFileAsResource(String fileName) throws MalformedURLException {
        Path filePath = Paths.get(currentDrive).resolve(fileName.replace(",", "/")).normalize();
        return new UrlResource(filePath.toUri());
    }

    public MyFile getFilesTree(String absolutePath,int depth) {
        System.out.println("crawling " + absolutePath);
        exceptionSet = new HashSet<>(myFileRepository.findExceptionFiles());
        safeSet = new HashSet<>(myFileRepository.findSafeFiles());

        MyFile myFile = new MyFile();
        myFile.setPath(absolutePath);
        crawl(myFile, depth-1);
        System.out.println("done");
        
        return myFile;
    }

    private void crawl(MyFile myFile, int depth) {
        File dir = new File(myFile.getPath());
        myFile.setName(dir.getName());
        myFile.setIsDirectory(dir.isDirectory());
        myFile.setIsException(exceptionSet.contains(myFile.getPath()));
        myFile.setIsSafe(safeSet.contains(myFile.getPath()));

        if (!myFile.getIsDirectory() || myFile.getIsException()) {
           myFile.setChildren(null);
           return;
        }

        List<MyFile> children = new ArrayList<>();
        File[] files = dir.listFiles();
        if(files != null && depth > 0) {
            for (File file : files) {
                MyFile child = new MyFile();
                child.setPath(file.getAbsolutePath());
                crawl(child, depth-1);
                children.add(child);
            }
        } else {
            myFile.setChildren(null);
            return;
        }

        myFile.setChildren(children);
    }

    public List<MyFile> flattenFiles(MyFile root) {
        List<MyFile> flatList = new ArrayList<>();
        flatten(root, flatList);
        return flatList;
    }
    
    private void flatten(MyFile current, List<MyFile> flatList) {
        if (current == null) return;
    
        // Add the current file to the list
        flatList.add(current);
    
        // If it has children, flatten them as well
        if (current.getChildren() != null) {
            for (MyFile child : current.getChildren()) {
                flatten(child, flatList);
            }
        }
    }

    public void safeToggle(String decodedPath) {
        safeSet = new HashSet<>(myFileRepository.findSafeFiles());
        if (safeSet.contains(decodedPath)) {
            myFileRepository.deleteById(decodedPath);
            return;
        }
        File file = new File(decodedPath);
        MyFile myFile = new MyFile();
        myFile.setName(file.getName());
        myFile.setPath(file.getAbsolutePath());
        myFile.setIsDirectory(file.isDirectory());
        myFileRepository.save(myFile);
    }

    public List<MyFile> getDatabase() {
        return myFileRepository.findAll();
    }

    public void exceptionToggle(String decodedPath) {
        exceptionSet = new HashSet<>(myFileRepository.findExceptionFiles());
        if (exceptionSet.contains(decodedPath)) {
            MyFile myFile = myFileRepository.findById(decodedPath).get();
            myFile.setIsException(false);
            myFileRepository.save(myFile);
            return;
        }
        File file = new File(decodedPath);
        MyFile myFile = new MyFile();
        myFile.setName(file.getName());
        myFile.setPath(file.getAbsolutePath());
        myFile.setIsDirectory(file.isDirectory());
        myFile.setIsException(true);
        myFileRepository.save(myFile);
    }

    public void markAllSafe(String target,int depth) {
        MyFile fileTree = getFilesTree(target,depth);
        List<MyFile> allFiles =flattenFiles(fileTree);
        myFileRepository.saveAll(allFiles);
    }

    public void markAllUnsafe() {
        myFileRepository.deleteAll();
    }
    public void markAllNoException() {
        myFileRepository.updateAllIsException(false);
    }

    public void deleteAllUnsafe(String target,int depth) {
        safeSet = new HashSet<>(myFileRepository.findSafeFiles());
        MyFile fileTree = getFilesTree(target, depth);
        List<MyFile> allFiles =flattenFiles(fileTree);
        for (MyFile file : allFiles) {
            if (!safeSet.contains(file.getPath())) {
                File f = new File(file.getPath());
                f.delete();
            }
        }
    }

}