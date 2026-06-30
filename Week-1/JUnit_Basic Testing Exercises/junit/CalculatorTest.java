package com.junit;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class CalculatorTest {

    Calculator calc = new Calculator();

    @Test
    public void testAdd() {
        assertEquals(10, calc.add(5, 5));
    }

    @Test
    public void testSubtract() {
        assertEquals(4, calc.subtract(10, 6));
    }

    @Test
    public void testMultiply() {
        assertEquals(20, calc.multiply(4, 5));
    }
}