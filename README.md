# c-template

Template project for project using the C Programming Language.

### Project structure

* `src` Root directory for source code
* `src/test` application code
* `src/lib` library code
* `build` build files
* `main` executable
* `.gdb_init` default gdb command to run

### Make commands

1. Build application
```
make
```

2. Run application (`./main` also works fine)
```
make run
```

3. Create a debug build
```
make debug
```

4. Debug usign gdb
```
make gdb
``` 

5. Clean build files
```
make clean
``` 

6. Run valgrind
```
make valgrind
```