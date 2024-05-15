package com.example.onlineBriefing.exceptions;

public class BriefingNotFoundException extends RuntimeException{
    public BriefingNotFoundException(Integer id) {
        super("Could not find briefing with id: " + id);
    }
}
