package com.example.onlineBriefing.exceptions;

public class NotNewsException extends RuntimeException {
    public NotNewsException() {
        super("No news found.");
    }
}

