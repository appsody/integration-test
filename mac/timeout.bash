#!/bin/bash
function timeout() { 
    perl -e 'alarm shift; exec @ARGV' "$@"
}