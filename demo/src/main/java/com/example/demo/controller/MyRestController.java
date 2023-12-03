package com.example.demo.controller;

import com.example.demo.model.Message;
import com.example.demo.repository.MessageRepository;
import com.example.demo.dto.MessageContentDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class MyRestController {

    @Autowired
    private MessageRepository messageRepository;

    @PostMapping("/post")
    public String handlePostRequest(@RequestBody MessageContentDTO messageContentDTO) {
        String data = messageContentDTO.getContent();
        Message message = new Message();
        message.setData(data);
        messageRepository.save(message);
        return "Received POST request and saved data: " + data;
    }

    @GetMapping("/get")
    public List<Message> handleGetRequest() {
        return messageRepository.findAll();
    }
}
