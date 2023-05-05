package com.github.xenorith.server;

import com.github.xenorith.grpc.HelloRequest;
import com.github.xenorith.grpc.HelloResponse;
import com.github.xenorith.grpc.HelloServiceGrpc;
import io.grpc.stub.StreamObserver;

public final class HelloServiceImpl extends HelloServiceGrpc.HelloServiceImplBase {
    @Override
    public void hello(
            HelloRequest request, StreamObserver<HelloResponse> responseObserver) {
        String greeting = new StringBuilder()
                .append("Hello, ")
                .append(request.getFirstName())
                .append(" ")
                .append(request.getLastName())
                .toString();

        HelloResponse response = HelloResponse.newBuilder()
                .setResponse(greeting)
                .build();

        responseObserver.onNext(response);
        responseObserver.onCompleted();
    }
}
