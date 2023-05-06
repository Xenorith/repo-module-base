package com.github.xenorith.server;

import io.grpc.ServerBuilder;

public class MyServer {
    public static void main(String[] args) throws Exception  {
        BaseServer baseServer = new BaseServer(ServerBuilder.forPort(8000)
                .addService(new HelloServiceImpl())
                .build());
        baseServer.PrintName();
        baseServer.StartAndWait();
    }
}
