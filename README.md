# repo-module-base
The base repository to demonstrate using git submodules for cross repository dependencies

## protobuf/grpc module
The `proto/` directory defines a simple [grpc](https://grpc.io/) service using [protobuf](https://protobuf.dev/).
When building the java code through maven, java files are generated from the protobuf files.
The `server/` and `client/` directories define a simple server and client to demonstrate the use of grpc by importing the generated files.

