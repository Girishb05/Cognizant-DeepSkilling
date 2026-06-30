package com.junit;

import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.After;
import org.junit.Test;

public class AAATest {

    private Calculator calc;

    @Before
    public void setUp() {
        System.out.println("Setup Method");
        calc = new Calculator();
    }

    @After
    public void tearDown() {
        System.out.println("Teardown Method");
    }

    @Test
    public void testAddition() {

        // Arrange
        int a = 10;
        int b = 20;

        // Act
        int result = calc.add(a, b);

        // Assert
        assertEquals(30, result);
    }

    @Test
    public void testMultiplication() {

        // Arrange
        int a = 4;
        int b = 5;

        // Act
        int result = calc.multiply(a, b);

        // Assert
        assertEquals(20, result);
    }
}