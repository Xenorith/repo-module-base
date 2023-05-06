package com.github.xenorith.client;

import com.github.xenorith.grpc.HelloRequest;
import com.github.xenorith.grpc.HelloResponse;
import com.github.xenorith.grpc.HelloServiceGrpc;
import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;

public class BaseClient extends AbstractClient {

    public BaseClient(String host, int port) {
        super(host, port);
    }

    @Override
    public void PrintName() {
        System.out.println("My name is BaseClient");
    }

    public void Hello(String firstName, String lastName) {
        ManagedChannel channel = ManagedChannelBuilder.forAddress(mHost, mPort)
                .usePlaintext()
                .build();

        HelloServiceGrpc.HelloServiceBlockingStub stub = HelloServiceGrpc.newBlockingStub(channel);

        HelloResponse helloResponse = stub.hello(HelloRequest.newBuilder()
                .setFirstName(firstName)
                .setLastName(lastName)
                .build());

        System.out.println(helloResponse);

        channel.shutdown();
    }
}
