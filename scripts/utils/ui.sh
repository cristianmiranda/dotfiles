#!/bin/bash

# Text decoration
export BOLD='\e[1m'
export UNDERLINE='\e[4m'
export NORMAL='\e[22m'

# Backgrounds
export BG_BLUE='\e[104m'
export BG_GRAY='\e[47m'
export BG_RED='\e[41m'

# Colors
export RED='\033[0;31m'
export CYAN='\033[0;36m'
export WHITE='\e[97m'
export BLACK='\e[30m'
export BLUE='\e[34m'
export YELLOW='\e[33m'

export NC='\033[0m' # No Color

function banner() {
    string="         $1          "
    
    separator=""
    for (( c=1; c<=${#string}; c++ )); do
        separator+=" "
    done
    
    echo -e "${BG_BLUE}${BLACK}${separator}${NC}"
    echo -e "${BG_BLUE}${BLACK}${string}${NC}"
    echo -e "${BG_BLUE}${BLACK}${separator}${NC}"
}

function separator() {
    separator=""
    for (( c=1; c<=$1; c++ )); do
        separator+=" "
    done

    echo -e "${BG_BLUE}${BLACK}${separator}${NC}"
}

function info() {
    echo -e "${BLUE}${1}${NC}"
}

function info_1() {
    echo -e "${CYAN}${BOLD}${1}${NC}${2}"
}

function warning() {
    echo -e "${YELLOW}${1}${NC}"
}

function error() {
    echo -e "${RED}${1}${NC}"
}

function br() {
    echo ""
}

function ask() {
    echo -ne "${CYAN} >> $1 [y/n]: ${NC}"
    read -r $2
}

function ask_2() {
    echo -ne "${CYAN} >> $1: ${NC}"
    read -r $2
}

function ask_caution() {
    echo -ne "${RED} >> $1 [y/n]: ${NC}"
    read -r $2
}