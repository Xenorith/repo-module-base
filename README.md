# repo-module-base
The base repository to demonstrate using git submodules for cross repository dependencies

## Prerequisites
- Java 8+
- Maven 3.6+
- Jekyll 4+ (for building documentation)
- Golang 1.18+ (for building tarball)

## Operational workflow

### Developing on existing code
- Modify existing java code
- Build with `mvn clean install`
- Start server with `bin/cli.sh startServer`
- Run client with `bin/cli.sh runClient`
- Stop server with `bin/cli.sh stopServer`
- Build tarball with `scripts/build-tarball.sh`

### Adding a new java module
- Add module to `pom.xml` for maven to recognize
- (as needed) Add new CLI commands by adding a new file in `bin/cmd/yourModule.sh` and add an additional line in `bin/cli.sh` to source the file.
- Update `scripts/tarball-profile.yml` with the location of the new module's jar as well as any additional complementary files

## Repo components

## Java protobuf/grpc module
Java files are under the `base/` directory.
The `base/proto/` directory defines a simple [grpc](https://grpc.io/) service using [protobuf](https://protobuf.dev/).
When building the java code through maven, java files are generated from the protobuf files.
The `base/server/` and `base/client/` directories define a simple server and client to demonstrate the use of grpc by importing the generated files.

## Documentation
Documentation is tracked in the `docs/` directory.
See its [README](docs/README.md).

## CLI
A CLI is provided as a shell script, accessible through the entrypoint script at `bin/cli.sh`.
Read more about its implementation in its [README](cli/README.md).

## Tarball generation
A tarball consisting of the necessary built files to independently run the project can be built by running the script at `scripts/build-tarball.sh`.
The code is written in golang and the script will build and run the go code internally.
Read about how to customize the tarball in its [README](scripts/README.md).
