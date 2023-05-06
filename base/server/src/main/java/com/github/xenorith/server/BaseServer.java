package com.github.xenorith.server;

import io.grpc.Server;

public class BaseServer extends AbstractServer {

    public BaseServer(Server server) {
        super(server);
    }

    @Override
    public void PrintName() {
        System.out.println("My name is BaseServer");
    }
}
