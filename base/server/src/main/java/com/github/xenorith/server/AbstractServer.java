package com.github.xenorith.server;

import io.grpc.Server;
import java.io.IOException;
import java.lang.InterruptedException;

public abstract class AbstractServer {
    private Server mServer;

    public AbstractServer(Server server) {
        mServer = server;
    }

    public abstract void PrintName();

    public void StartAndWait() throws IOException, InterruptedException {
        mServer.start();
        mServer.awaitTermination();
    }
}
