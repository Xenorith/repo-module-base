# Tarball generation via golang

The `build.tarball.sh` script builds the go code in `src/github.com/xenorith/build` and runs the resulting binary.
At a high level, the script runs the following steps:
- Reads a profile file to determine which files to copy into the tarball
- Builds the java code via maven
- Creates a temporary directory and copies the designated files from the repository into the temporary directory
- Create a tarball from the temporary directory and delete the directory

The profile file is essential to allow further customization, such as additional jars if there are new java modules added.
