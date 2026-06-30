package com.forecast;

public class ForeCast {

    public static double predictValue(double amount,
                                      double growthRate,
                                      int years) {

        if (years == 0) {
            return amount;
        }

        return predictValue(amount,
                            growthRate,
                            years - 1)
                            * (1 + growthRate);
    }
}