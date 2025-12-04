package com.example.todoapp.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

@RestController
@RequestMapping("/tasks")
public class TodoController {
    
    @GetMapping
    public ResponseEntity<String> getAllTasks() {
        return ResponseEntity.ok("""
            [
                {"id": 1, "title": "Learn Docker", "completed": true},
                {"id": 2, "title": "Setup Jenkins", "completed": false},
                {"id": 3, "title": "Deploy to Kubernetes", "completed": false}
            ]
            """);
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<String> getTaskById(@PathVariable Long id) {
        return ResponseEntity.ok(String.format("""
            {"id": %d, "title": "Task %d", "completed": false}
            """, id, id));
    }
    
    @PostMapping
    public ResponseEntity<String> createTask(@RequestBody String task) {
        return ResponseEntity.ok("Task created: " + task);
    }
    
    @GetMapping("/health")
    public ResponseEntity<String> healthCheck() {
        return ResponseEntity.ok("Application is running!");
    }
}