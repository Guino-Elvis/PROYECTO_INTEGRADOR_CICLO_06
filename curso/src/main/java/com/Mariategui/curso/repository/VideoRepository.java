package com.Mariategui.curso.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Mariategui.curso.entity.Video;

public interface VideoRepository extends JpaRepository<Video, Integer> {

}
