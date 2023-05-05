# Extensible CLI commands
Extensible CLI where subcommands can be defined by separate files to properly separate the declaration and definition of commands from the command execution.
This allows an executable script to define an arbitrary set of commands or source a separate bash script that defines a set of similar commands.
Modularization is possible where different entrypoint scripts can define or source commands as needed.

As a comparison, in a straightforward script that strictly defines each subcommand, one would likely define a case statement for each command.
The usage help string would need to be directly appended to describe each command.
This approach requires the developer to be aware of and edit multiple areas of the script to fully append the new subcommand.

The utility shell file `cmd/command.sh` defines the utilities needed to achieve modularization.
The primary pattern is the use of arrays and associative arrays to define the parameters unique to each command permutation.
In this example, we consider two parts:
- the command to execute
- the usage help string to print when encountering unexpected user inputs

A developer could define a new subcommand by defining a function to run when the command is invoked and registering the command by calling `appendCommand` with the expected arguments.
The two shell files `cmd/client.sh` and `cmd/server.sh` defines commands specific to the client and server.
The entrypoint script `cli.sh` sources the two shell files to collect their commands and runs the main function defined by the utility file.

As new modules are introduced, one would need to:
- create a self-contained shell file to define and register new commands
- add a single line in the entrypoint script to source the new file

If one were to be more ambitious, the entrypoint script to source every file in a designated folder to avoid editing the entrypoint script per new file.
A bit too volatile and potentially dangerous for my tastes, but to each his or her own.
