package com.Mariategui.noticias.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Mariategui.noticias.entity.Blog;

public interface BlogRepository extends JpaRepository<Blog, Integer> {

}
