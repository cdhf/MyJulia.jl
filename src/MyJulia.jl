module MyJulia

export mycheatsheet, mycompile, myshowtable, myedit, mygermancsv, myvlscatter

using Reexport

@reexport using CSV, DataFrames, ElectronDisplay, PlotlyJS, VegaLite, Query

using PackageCompiler: create_sysimage
using Pkg: instantiate

function mycompile()
    instantiate()
    image_file = normpath(joinpath(@__DIR__, "..", "MyJuliaImage.dll"))
    packages = [:Revise, :CSV, :DataFrames, :ElectronDisplay, :PlotlyJS, :VegaLite, :TableView, :Blink, :Query]
    if Sys.iswindows()
        packages = [:Revise, :CSV, :DataFrames, :ElectronDisplay, :PlotlyJS, :VegaLite, :TableView, :Query]
    end
    @info "compiling $packages"
    precompile_script = joinpath(@__DIR__, "precompile_script.jl")
    create_sysimage(packages, sysimage_path = image_file, precompile_execution_file = precompile_script)
end

using Blink, TableView

function myshowtable(df)
    w = Window()
    body!(w, showtable(df))
end

using InteractiveUtils: edit

function myedit()
    edit(@__FILE__)
end

using Markdown

function mycheatsheet()
    my_cheatsheet = @md_str """# Cheatsheet
    ## CSV
    CSV.read(filename :: String, delim :: Char, decimal :: Char, skipto :: Int, footerskip)

    Lade CSV File mit delim als Feldseparator, decimal als Decimalseparator. Die ersten (skipto) und die letzten (footerskip) Zeilen werden übersprungen.
    """
    electrondisplay(my_cheatsheet)
end

function mygermancsv(filename, skipto = 0, footerskip = 0)
    CSV.read(filename, decimal = ',', skipto = skipto, footerskip = footerskip)
end

function myvlscatter(df, x, y, title = "")
    electrondisplay(df |> @vlplot(:point, x=x, y=y, title=title))
end

function myvlscatter(arr :: AbstractArray{T, 2}, title="") where T
    if size(arr, 1) == 2
        df = DataFrame(x = arr[1, :], y = arr[2, :])
        myvlscatter(df, :x, :y, title)
    elseif size(arr, 2) == 2
        df = DataFrame(x = arr[:, 1], y = arr[:, 2])
        myvlscatter(df, :x, :y, title)
    else
        error("invalid shape")
    end
end

end # module
