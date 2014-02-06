#!/bin/bash

erl -compile main;
erl -noshell -s main main $@ -s init stop;
