package com.github.xenorith.client;

public abstract class AbstractClient {
    protected String mHost;
    protected int mPort;

    public AbstractClient(String host, int port) {
        mHost = host;
        mPort = port;
    }

    public abstract void PrintName();
}
