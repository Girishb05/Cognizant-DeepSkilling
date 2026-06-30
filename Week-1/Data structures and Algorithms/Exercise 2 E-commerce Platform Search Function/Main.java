package com.search;

public class Main {

    public static void main(String[] args) {

        Product[] products = {
                new Product(101, "Laptop", "Electronics"),
                new Product(102, "Mobile", "Electronics"),
                new Product(103, "Shoes", "Fashion"),
                new Product(104, "Watch", "Accessories"),
                new Product(105, "Headphones", "Electronics")
        };

        System.out.println("Linear Search:");

        Product p1 = LinearSearch.search(products, 104);

        if (p1 != null)
            p1.display();
        else
            System.out.println("Product not found");


        System.out.println("\nBinary Search:");

        Product p2 = BinarySearch.search(products, 104);

        if (p2 != null)
            p2.display();
        else
            System.out.println("Product not found");
    }
}