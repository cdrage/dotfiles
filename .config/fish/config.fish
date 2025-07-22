# ~/.config/fish/config.fish

# Only run if interactive to avoid slowing down non-interactive shells (e.g. scripts)
if status is-interactive
    for file in ~/.cli.fish ~/.extra.fish
        if test -f $file
            source $file
        end
    end
end
