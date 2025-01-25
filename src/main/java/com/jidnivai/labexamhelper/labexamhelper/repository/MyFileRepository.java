package com.jidnivai.labexamhelper.labexamhelper.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.jidnivai.labexamhelper.labexamhelper.entity.MyFile;

import jakarta.transaction.Transactional;

@Repository
public interface MyFileRepository extends JpaRepository<MyFile, String> {

    @Query("SELECT m.path FROM MyFile m WHERE m.isException = true")
    List<String> findExceptionFiles();

    @Query("SELECT m.path FROM MyFile m")
    List<String> findSafeFiles();

    @Modifying
    @Transactional
    @Query("UPDATE MyFile m SET m.isException = :b")
    void updateAllIsException(@Param("b") boolean b);

}
