for file in ~/.cli.fish ~/.extra.fish
    if test -f $file
        source $file
    end
end
