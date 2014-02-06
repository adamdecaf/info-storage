%% Homework #1
%% Adam Shannon
%% CS 3150

%% Requirements
%% 1) Handle n acsii input files
%% 2) Generate a single inverted index output file.
%% 3) --help flag support and if no files are given, or if flags are malformed.
%% 4) Script to compile and run program (single script, so it's easier).

-module(main).
-export([main/1]).

%% a process that handles and spawns indexer processes for one file at a time.
spawn_worker_manager() ->
    receive
        {'make_inverted_index', FileName} ->
            io:format("Making Inverted Index for file: ~w\n", [FileName]),
            IndexCollector = spawn(fun() -> spawn_index_collector() end),
            spawn(fun() -> spawn_file_parser() end) ! {'parse_file', FileName, IndexCollector},
            spawn_worker_manager()
    end.

%% a shared collector that builds up the indexes to send off when it gets a
%% 'index_generation_completed' message.
spawn_index_collector() ->
    receive
        _ ->
            io:format("Index Collector")
    end.

%% 1) a process that will attempt to read in a file
%% 2) cleans the lines, filter out bad characters, etc..
%% 3) group by distinct terms and collects a group of documents
%% 4) send file dict back to the collector, kill self.
spawn_file_parser() ->
    receive
        {'parse_file', FileName, IndexCollector} ->
            Lines = read_file_lines(FileName),
            LineCount = length(Lines),
            %io:format("Read ~s from ~w\n", [Lines, FileName]),
            io:format("Read ~w lines from ~w\n", [LineCount, FileName]),
            Tokens = lists:flatmap(fun(Line) -> string:tokens(Line, " ") end, Lines),
            TokensCount = length(Tokens),
            io:format("Read ~w tokens from ~w\n", [TokensCount, FileName]),
            %% Strip bad tokens
            FilteredTokens = lists:filter(fun(T) -> is_valid_token(T) end, Tokens),
            FilteredTokenList = lists:map(fun(T) -> string:concat(T, "\n") end, FilteredTokens),
            io:format("Filtered down to ~s tokens", [FilteredTokenList]),
            %% turn it into an array of tokens, not an array of lines.
            %% strip out bad characters.
            spawn_file_parser()
    end.

%% utility function for seeing if token is valid
is_valid_token(Token) ->
    Length = string:len(Token) > 0,
    case re:run(Token, "^([a-zA-Z0-9]{1,})$") of
        {match, _} when Length -> true;
        _ -> false
    end.

%% Start the program:
%% 1) Read files in from command line.
%% 2) Spawn a woker manager, send the files to be indexed there.
main(Args) ->
    WorkerManager = spawn(fun() -> spawn_worker_manager() end),
    Procs = lists:foreach(fun(F) -> WorkerManager ! {'make_inverted_index', F} end, Args),
    io:format("~w\n", [Procs]).

%% utility functions for reading a file
read_file_lines(FileName) ->
    case file:open(FileName, [read]) of
        {ok, Reader} ->
            try get_all_lines(Reader)
              after file:close(Reader)
              end;
        {_, Error} ->
            io:format("We got some weird error.. ~w\n", [Error]),
            {failure, Error};
        _ ->
            {failure, "Wow, we really got some weird error.\n"}
    end.

get_all_lines(Reader) ->
    case io:get_line(Reader, "") of
        eof  -> [];
        Line ->
            %%io:format("~s\n", [Line]),
            [Line] ++ get_all_lines(Reader)
    end.
