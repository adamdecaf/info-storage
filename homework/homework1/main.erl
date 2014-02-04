-module(main).
-export([main/0]).
-on_load(main/0).

main() ->
    io:fwrite("hello, world\n").
