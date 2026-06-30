package com.factory;

public class PdfDocument implements Document {

    public void open() {
        System.out.println("PDF Document Opened");
    }
}