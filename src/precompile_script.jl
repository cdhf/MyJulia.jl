using DataFrames
df = DataFrame(a = [1,2], b = [2.3, 4.5])

using PlotlyJS, VegaLite, ElectronDisplay


electrondisplay(df |> @vlplot(:point, x=:a, y=:b))
electrondisplay(plot(scatter(df, x=:a, y=:b, mode="markers")))

if !Sys.iswindows()
    @info "compiling Blink, TableView"
    using Blink, TableView
    w = Window()
    body!(w, showtable(df))
else
    @warn "compiling Blink does not work on Windows currently, only including TableView"
    using TableView
    t = showtable(df)
end

using Query
q = @from i in df begin
    @where i.a > 1
    @select {i.a, b=i.b^2}
    @collect
    end
