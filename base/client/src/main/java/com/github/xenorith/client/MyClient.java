package com.github.xenorith.client;

public final class MyClient {
    public static void main(String[] args) {
        BaseClient baseClient = new BaseClient("localhost", 8000);
        baseClient.PrintName();
        baseClient.Hello("foo", "bar");
    }
}
