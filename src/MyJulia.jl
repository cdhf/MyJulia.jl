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

function myvlscatter(df, x, y)
    electrondisplay(df |> @vlplot(:point, x=x, y=y))
end

end # module
