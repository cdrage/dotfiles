# ~/.config/fish/config.fish

# Only run if interactive to avoid slowing down non-interactive shells (e.g. scripts)
if status is-interactive
    for file in ~/.cli.fish ~/.extra.fish
        if test -f $file
            source $file
        end
    end
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/cdrage/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/cdrage/Downloads/google-cloud-sdk/path.fish.inc'; end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/cdrage/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
fnm env | source

# opencode
fish_add_path /Users/cdrage/.opencode/bin
