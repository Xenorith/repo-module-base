package com.github.xenorith.server;

import io.grpc.Server;
import io.grpc.ServerBuilder;

public class MyServer {
    public static void main(String[] args) throws Exception  {
        Server server = ServerBuilder.forPort(8000).addService(new HelloServiceImpl()).build();
        server.start();
        server.awaitTermination();
    }
}
