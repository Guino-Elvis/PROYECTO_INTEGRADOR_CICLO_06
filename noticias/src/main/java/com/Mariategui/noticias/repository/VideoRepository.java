package com.Mariategui.noticias.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Mariategui.noticias.entity.Video;

public interface VideoRepository extends JpaRepository<Video, Integer> {

}
