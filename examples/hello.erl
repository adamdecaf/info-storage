%% #!/usr/bin/erl
%% -on_load(main/0).
-module(hello).
-export([hello_world/0]).

hello_world() ->
    io:fwrite("hello, world\n").
