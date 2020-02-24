#!/bin/bash

julia --startup-file=no -L ~\.julia\dev\MyJulia.jl\src\mystartup.jl --project=~\.julia\dev\MyJulia.jl -e "mycompile()"
