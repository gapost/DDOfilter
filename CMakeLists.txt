cmake_minimum_required(VERSION 3.5)

project(DDOfilter LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(ddo 
   ./src/ddo.cpp 
   ./src/DDO.h
)