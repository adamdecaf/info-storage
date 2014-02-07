%% Homework #1
%% Adam Shannon
%% CS 3150

%% Requirements
%% 1) Handle n acsii input files
%% 2) Script to compile and run program (single script, so it's easier).
%% 3) --help flag support and if no files are given, or if flags are malformed.
%% 4) If files are bad, reject and display an error message and usage statement.
%% 5) Lowercase all terms.
%% 6) Generate a single inverted index output file, store in document.idx
%% 7) Comment out debugging lines.

-module(main).
-export([main/0, main/1]).

print_usage_info() ->
    io:format("== Usage Instructions\n"),
    io:format("$ ./run.sh FILE1 [FILE2 ...]\n").

%% a process that handles and spawns indexer processes for one file at a time.
spawn_worker_manager() ->
    receive
        {'make_inverted_index', FileName} ->
            %%io:format("Making Inverted Index for file: ~w\n", [FileName]),
            IndexCollector = spawn(fun() -> spawn_index_collector() end),
            Document = random:uniform(100000),
            spawn(fun() -> spawn_file_parser() end) ! {'parse_file', FileName, Document, IndexCollector},
            spawn_worker_manager()
    end.

%% a shared collector that builds up the indexes to send off when it gets a
%% 'index_generation_completed' message.
spawn_index_collector() ->
    receive
        {'document_token_records', TokenRecords} ->
            PartOfTheTokens = lists:sublist(TokenRecords, 10),
            io:format("Index Collector ~w\n", [PartOfTheTokens]),
            FileData = lists:foldl(fun({Token, Documents}, Acc) ->
                                           Line = string:concat(string:concat(Token, " -- "), io_lib:format("~w", Documents)),
                                           string:concat(string:concat(Line, "\n"), Acc) end, "", TokenRecords),
            file:write_file("document.idx", FileData, [append]),
            spawn_index_collector();
        Unhandled ->
            %%io:format("Got some other unhandled message: ~w", [Unhandled]),
            spawn_index_collector()
    end.

%% 1) a process that will attempt to read in a file
%% 2) cleans the lines, filter out bad characters, etc..
%% 3) group by distinct terms and collects a group of documents
%% 4) send file dict back to the collector, kill self.

spawn_file_parser() ->
    receive
        {'parse_file', FileName, Document, IndexCollector} ->
            FileData = string:concat(string:concat("Document: ", integer_to_list(Document)), "\n"),
            file:write_file("document.idx", FileData, [append]),

            Lines = read_file_lines(FileName),
            LineCount = length(Lines),
            %%io:format("Read ~w lines from ~w\n", [LineCount, FileName]),

            %% Flatten all the tokens we've gathered from the lines into one list.
            Tokens = lists:flatmap(fun(Line) -> string:tokens(Line, " ") end, Lines),
            TokensCount = length(Tokens),
            %%io:format("Read ~w tokens from ~w\n", [TokensCount, FileName]),

            %% Strip bad tokens
            %% Here, is_valid_token just takes strings that are made up of a-z (ignoring case) or numbers.
            %% todo: Expand to allow for certain symbols, but we'll need to filter those out.
            FilteredTokens = lists:filter(fun(T) -> is_valid_token(T) end, Tokens),
            FilteredTokenList = lists:map(fun(T) -> string:concat(string:to_lower(string:strip(T)), "\n") end, FilteredTokens),
            %% io:format("Filtered down to ~s tokens", [FilteredTokenList]), %% prints a lot of stuff.

            %% send these off to another pid that can handle building the index.
            TokenRecordGrouper = spawn(fun() -> spawn_token_record_grouper() end),
            TokenRecordGrouper ! {'create_token_records', FilteredTokenList, Document, IndexCollector},
            spawn_file_parser()
    end.

%% Get a series of terms for a document, group them into
%% records and then send that to the IndexCollector.
spawn_token_record_grouper() ->
    receive
        {'create_token_records', TokenList, Document, IndexCollector} ->
            io:format("Creating token_records for Document ~w\n", [Document]),
            %%TokenRecords = build_token_records(TokenList, Document, []),
            TokenRecords = lists:map(fun(T) -> {T, [Document]} end, TokenList),
            %%io:format("Done building ~w token records via recursion for Document ~w\n", [TokenRecords, Document]),
            IndexCollector ! {'document_token_records', TokenRecords},
            spawn_token_record_grouper()
    end.

%% This is just a recursive function to find the record if it exists
%% update it, or add a new instance of it.
%% build_token_records(TokenList, Document, Accum) ->
    %% Fold over the Tokens and see if they're in the document or not. accum results.


%% utility function for seeing if token is valid
is_valid_token(Token) ->
    Length = string:len(Token) > 0,
    case re:run(Token, "^([a-zA-Z0-9]{1,})$") of
        {match, _} when Length -> true;
        _ -> false
    end.

%% utility functions for reading a file
read_file_lines(FileName) ->
    case file:open(FileName, [read]) of
        {ok, Reader} ->
            try get_all_lines(Reader)
              after file:close(Reader)
              end;
        {_, Error} ->
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

%% Start the program:
%% 1) Read files in from command line.
%% 2) Spawn a woker manager, send the files to be indexed there.
main() ->
    print_usage_info().

main(Args) ->
    if length(Args) == 0 ->
            spawn(fun() -> print_usage_info() end);
       true ->
            file:write_file("document.idx", "", [write]),
            file:write_file("document.idx", "# INPUT DOCUMENT REFERENCE LEGEND\n", [append]),
            WorkerManager = spawn(fun() -> spawn_worker_manager() end),
            Procs = lists:foreach(fun(F) -> WorkerManager ! {'make_inverted_index', F} end, Args),
            io:format("~w\n", [Procs])
    end.
