package com.github.xenorith.client;

import com.github.xenorith.grpc.HelloRequest;
import com.github.xenorith.grpc.HelloResponse;
import com.github.xenorith.grpc.HelloServiceGrpc;
import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;

public final class MyClient {
    public static void main(String[] args) {
    ManagedChannel channel = ManagedChannelBuilder.forAddress("localhost", 8000)
        .usePlaintext()
        .build();

    HelloServiceGrpc.HelloServiceBlockingStub stub = HelloServiceGrpc.newBlockingStub(channel);

    HelloResponse helloResponse = stub.hello(HelloRequest.newBuilder()
        .setFirstName("foo")
        .setLastName("bar")
        .build());

    System.out.println(helloResponse);

    channel.shutdown();
    }
}
