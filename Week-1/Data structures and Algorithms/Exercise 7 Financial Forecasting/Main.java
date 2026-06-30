package com.forecast;

public class Main {

    public static void main(String[] args) {

        double presentValue = 10000;
        double growthRate = 0.10;
        int years = 5;

        double futureValue =
                ForeCast.predictValue(
                        presentValue,
                        growthRate,
                        years);

        System.out.println("Present Value: ₹" + presentValue);
        System.out.println("Growth Rate: " + (growthRate * 100) + "%");
        System.out.println("Years: " + years);
        System.out.println("Future Value: ₹" + futureValue);
    }
}