using PlotlyJS, VegaLite, DataFrames, ElectronDisplay

df = DataFrame(a = [1,2], b = [2.3, 4.5])

electrondisplay(df |> @vlplot(:point, x=:a, y=:b))
electrondisplay(plot(scatter(df, x=:a, y=:b, mode="markers")))

using Blink, TableView
w = Window()
body!(w, showtable(df))

using Query
q = @from i in df begin
    @where i.a > 1
    @select {i.a, b=i.b^2}
    @collect
    end
