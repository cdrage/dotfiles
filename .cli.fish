##########
# EXPORT #
##########

set -x EDITOR nvim

# HIDPI
set -x GDK_SCALE 2
set -x GDK_DPI_SCALE 1
set -x QT_DEVICE_PIXEL_RATIO 2

# UTF-8
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x LANGUAGE en_US.UTF-8

# History (Fish doesn't use HIST* vars, use fish_history)
set -U fish_history universal
# fish ignores HISTIGNORE / HISTCONTROL

# Syncthing
set -x SPATH $HOME/syncthing

# Go
set -x GOPATH $SPATH/dev/go
set -x GOROOT (brew --prefix golang)/libexec
set -x PATH $PATH $GOPATH/bin

################
# COLOR STUFF  #
################

set -g RED "\033[0;31m"
set -g BLUE "\033[0;36m"
set -g NC "\033[0m"

function red
    echo -e "$RED$argv$NC"
end

function blue
    echo -e "$BLUE$argv$NC"
end

function bold
    echo -e "\033[1m$argv\033[0m"
end

function italic
    echo -e "\033[3m$argv\033[0m"
end

function underline
    echo -e "\033[4m$argv\033[0m"
end

##############
# ALIASES    #
##############

abbr .. "cd .."
abbr ... "cd ../.."
abbr .... "cd ../../.."
abbr ..... "cd ../../../.."
abbr ~ "cd ~"
abbr -- - "cd -"

abbr g "git"
abbr d "gogo"
abbr k "kubectl"
abbr p "pnpm"

set -l colorflag "--color"
abbr l "ls -lF $colorflag"
abbr la "ls -laF $colorflag"
abbr lsd "ls -lF $colorflag | grep --color=never '^d'"
abbr lsc "ls -l $colorflag | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\"%0o \",k);print}'"
abbr ls "command ls $colorflag"

set -x LS_COLORS 'no=00:fi=00:di=01;34:...'

abbr vim nvim
abbr vi nvim
abbr oldvim "/usr/bin/vim"

abbr sudo "sudo "
abbr week "date +%V"
abbr pubip "dig +short myip.opendns.com @resolver1.opendns.com"
abbr hosts "sudo vim /etc/hosts"
abbr untar "tar xvf"
abbr download-audio 'yt-dlp -x -f bestaudio --prefer-free-formats -i --output "%(title)s.%(ext)s"'
abbr rsync-copy "rsync -avz --progress"

#############
# FUNCTIONS #
#############

function shout
    echo -e "\n!!!!!!!!!!!!!!!!!!!!\n$argv\n!!!!!!!!!!!!!!!!!!!!\n"
end

function pass-gen-http
    if test (count $argv) -lt 2
        echo "plz supply username and pass"
        return 1
    end
    set -l user $argv[1]
    set -l pass (htpasswd -bnBC 10 "" $argv[2] | tr -d ':')
    echo "$user:$pass"
end

function sed-replace
    if test (count $argv) -lt 3
        find . -type f \( -name "*.*" ! -path "*/.git/*" ! -path "*/vendor/*" \) -print0 | xargs -0 sed -i "" "s/$argv[1]/$argv[2]/g"
    else
        find $argv[3] -type f \( -name "*.*" ! -path "*/.git/*" ! -path "*/vendor/*" \) -print0 | xargs -0 sed -i "" "s/$argv[1]/$argv[2]/g"
    end
end

function ask
    set -l prompt ""
    set -l default ""
    while true
        switch "$argv[2]"
            case "Y"
                set prompt "Y/n"
                set default "Y"
            case "N"
                set prompt "y/N"
                set default "N"
            case "*"
                set prompt "y/n"
        end
        echo ""
        echo -n (set_color blue)"$argv[1] [$prompt] "(set_color normal)
        read -l REPLY
        if test -z "$REPLY"
            set REPLY $default
        end
        switch "$REPLY"
            case "Y" "y"
                return 0
            case "N" "n"
                return 1
        end
    end
end

function twitch
    set -l result $argv[1]
    set -l quality (count $argv) -ge 2 ? $argv[2] : "high"
    set -x QT_AUTO_SCREEN_SCALE_FACTOR 1
    set -x QT_SCALE_FACTOR 0.6
    streamlink --twitch-disable-ads twitch.tv/$result $quality
end

function digga
    dig +nocmd "$argv[1]" any +multiline +noall +answer
end

function xkcd
    sort -R /usr/share/dict/words | head -n 4 | awk '{ sub(".", toupper(substr($0,1,1))); printf "%s", $0 }'
    echo
end

function gogo
    if string match -q '*/'* $argv[1]
        set -l devpath (find $SPATH/dev -maxdepth 3 -type d -path "*$argv[1]" | head -n1)
        set -l gopath (find $GOPATH/src -maxdepth 5 -type d -path "*$argv[1]" | head -n1)
    else
        set -l devpath (find $SPATH/dev -maxdepth 3 -type d -iname "$argv[1]" | head -n1)
        set -l gopath (find $GOPATH/src -maxdepth 5 -type d -iname "$argv[1]" | head -n1)
    end
    if test -n "$devpath"
        cd $devpath
    else if test -n "$gopath"
        cd $gopath
    else
        echo "$argv[1] dir not found"
        return 1
    end
end

function worldtime
    set -l zones UTC US/Pacific America/Toronto Europe/Amsterdam Asia/Kolkata
    set -l names "UTC" "PST" "EST" "Ams" "India"
    for i in (seq (count $zones))
        echo -n "$names[$i]  "
        env TZ=":$zones[$i]" date "+%d %H:%M"
    end
end

function check-domain
    if whois $argv[1] | grep -Eq '^No match|^NOT FOUND|^Not fo|AVAILABLE|^No Data Fou|has not been regi|No entri'
        echo "$argv[1] : available"
    end
end


##################
# FUNCTIONS: GIT #
##################

function git-delete-all-remote-branches-except-main
    if not ask "This will delete ALL branches except main, continue?"
        return
    end
    for line in (git branch -r | grep origin/ | grep -v 'master$' | grep -v HEAD | cut -d/ -f2)
        git push origin :$line
    end
end

function git-sign
    git commit --no-verify --amend --no-edit -s
end

function git-clean
    git reset --hard
    git clean -d -f
end

function git-add
    if test (count $argv) -lt 1
        echo "Supply a message yo"
        return 1
    end
end

function git-lazy
    if test (count $argv) -lt 1
        echo "Supply a commit message yo"
        return 1
    end
    git add .
    git commit -m "$argv[1]" -s --no-verify
    git-push
end

function git-lazy-pr
    git add .
    git-commit-template
    git-push
    git-pr $argv[1]
end

function git-commit-template
    set FILE .github/PULL_REQUEST_TEMPLATE.md
    if test -f "$FILE"
        set CONTENT (echo "ADD TITLE HERE\n" ; cat $FILE)
        git commit --no-verify -m "$CONTENT"
        git commit --no-verify --amend -s
    else
        git commit --no-verify -s
    end
end

function git-push
    set BRANCH (git symbolic-ref --short HEAD ^/dev/null)
    if test -z "$BRANCH"
        echo "Unable to get branch name, is this even a git repo?"
        return 1
    end
    echo "Branch: $BRANCH"
    if test "$argv[1]" = "-f"
        git push -f origin $BRANCH
    else
        git push origin $BRANCH
    end
end

function git-checkout
    if test -z "$argv[1]"
        echo "Must provide branch name"
        return 1
    end
    set BASE (count $argv) -ge 2 ? $argv[2] : "main"
    echo "Checking out from $BASE"
    git checkout $BASE
    git checkout -b $argv[1]
end

function git-update
    set LAST_COMMIT_MSG (git show -s --format=%B -1 | cat)
    git add .
    git commit --no-verify -m 'update'
    git reset --soft HEAD~2
    git commit --no-verify -m "$LAST_COMMIT_MSG"
end

function git-set-upstream-remote
    echo "Previous remote:"
    git remote -v
    set NAME (basename (pwd))
    set UPSTREAM_REPO (git config --get remote.origin.url | sed 's|.*github.com[:/]||' | sed 's/.git$//')
    git remote remove origin
    git remote add origin git@github.com:$GITHUB_USER/$NAME.git
    git remote add upstream git@github.com:$UPSTREAM_REPO.git
    git remote set-url --push upstream no_push
    echo "Remote git's set"
    git remote -v
end

function git-set-remote
    echo "Previous remote:"
    git remote -v
    set NAME (basename (pwd))
    git remote remove origin
    git remote add origin git@github.com:$GITHUB_USER/$NAME.git
    echo "Remote git's set"
    git remote -v
end

function git-combine-commit
    if test -z "$argv[1]"
        echo "Supply the last N commit you want to combine :)"
        return 1
    end
    set LAST_COMMIT_MSG (git show -s --format=%B -1 | cat)
    git reset --soft HEAD~$argv[1]
    git commit --no-verify -m "$LAST_COMMIT_MSG"
end

function git-sync-upstream
    set MAIN (count $argv) -ge 1 ? $argv[1] : "main"
    set UPSTREAM_REPO (git config --get remote.upstream.url | sed 's|.*github.com[:/]||' | sed 's/.git$//')
    if test -z "$UPSTREAM_REPO"
        echo "Set a remote upstream via: git remote add upstream git@github.com:username/repo.git"
        return 1
    end
    set BRANCH (git symbolic-ref --short HEAD)
    echo "\nSyncing $MAIN\n"
    git checkout $MAIN
    git fetch upstream
    git merge upstream/$MAIN
    echo "\nGoing back to original working branch\n"
    git checkout $BRANCH
    echo "\nSync completed\n"
end

function git-revert-file
    if test (count $argv) -ne 1
        echo "Usage: git_revert_file <file_path>"
        return 1
    end
    set file_path $argv[1]
    if not git ls-files --error-unmatch "$file_path" >/dev/null 2>&1
        echo "File does not exist in the current commit."
        return 1
    end
    set parent_commit (git rev-parse HEAD^)
    git checkout "$parent_commit" -- "$file_path"
    echo "Successfully reverted changes to $file_path in the current commit."
end

function git-patch-commit
    if test -z "$argv[1]"
        echo "Supply the commit yo. ex. https://github.com/foo/bar/commit/9b997db51837dd"
        return 1
    end
    curl -L -s "$argv[1].patch" | git am
end

function git-pull
    set BRANCH (git symbolic-ref --short HEAD)
    git pull origin $BRANCH
end

function git-pull-pr
    if test -z "$argv[1]"
        echo "Supply the PR yo. ex. https://github.com/project/repo/pull/9 or just 9"
        return 1
    end
    gh pr checkout $argv[1]
end

function git-pr
    set UPSTREAM_BRANCH (count $argv) -ge 1 ? $argv[1] : "main"
    set BRANCH (git symbolic-ref --short HEAD)
    set ORIGIN_REPO (git config --get remote.origin.url | sed 's|git@github.com:||;s|.git$||')
    set UPSTREAM_REPO (git config --get remote.upstream.url | sed 's|git@github.com:||;s|.git$||')
    set PR (git --no-pager log -1 --pretty=%s%n%n%b)
    echo "$PR" > /tmp/pr.tmp
    set TITLE (git --no-pager log -1 --format=%s)
    gh pr create --title "$TITLE" --body-file /tmp/pr.tmp -H $GH_USER:$BRANCH -R $UPSTREAM_REPO
end

function git-delete-merged
    git branch -r --merged | grep -v main | sed 's/origin\//:/' | xargs -n 1 git push origin
end

function git-last-worked
    git branch --sort="-committerdate" --format="%(color:green)%(committerdate:relative)%(color:reset) %(refname:short)"
end


#####################
# FUNCTIONS: PODMAN #
#####################

function jrl
    podman run -it --rm --network=none -v $SPATH/enc/txt.enc:/tmp/txt.enc -v /etc/localtime:/etc/localtime:ro cdrage/jrl
end

function creds
    podman run -it --rm --network=none -v $SPATH/enc/creds.enc:/tmp/txt.enc -v /etc/localtime:/etc/localtime:ro cdrage/jrl
end

#########################
# FUNCTIONS: KUBERNETES #
#########################

function k8s_rerun_job
    kubectl get job $argv[1] -o json | jq 'del(.spec.selector)' | jq 'del(.spec.template.metadata.labels)' | kubectl replace --force -f -
end

function k8s_del_terminating_namespace
    echo "run kubectl proxy before"
    set NAMESPACE $argv[1]
    kubectl get namespace $NAMESPACE -o json | jq '.spec = {"finalizers":[]}' > temp.json
    curl -k -H "Content-Type: application/json" -X PUT --data-binary @temp.json 127.0.0.1:8001/api/v1/namespaces/$NAMESPACE/finalize
    rm temp.json
end

function k8s_del_terminating_pods
    for p in (kubectl get pods | grep Terminating | awk '{print $1}')
        kubectl delete pod $p --grace-period=0 --force
    end
end

####################
# FUNCTIONS: MACOS #
####################

function remove_quarantine
    xattr -d com.apple.quarantine $argv[1]
end

###################
# DOTFILES BACKUP #
###################

function backup
    shout "Backing up all dotfiles"
    for file in ~/.cli.fish ~/.extra.fish
        cp $file $SPATH/dev/linux/dotfiles/
    end
    mkdir -p $SPATH/dev/linux/dotfiles/.config/fish
    cp -r ~/.config/fish/config.fish $SPATH/dev/linux/dotfiles/.config/fish/
    cp -r ~/.config/nvim $SPATH/dev/linux/dotfiles/.config/
end

####################
# INSTALL (MAC M1) #
####################

function install_copy
    cp -r .cli.fish .extra.fish ~/
    mkdir -p ~/.config/fish
    cp -r .config/fish/config.fish ~/.config/fish/
    mkdir -p ~/.config/nvim
    cp -r .config/nvim ~/.config/
    shout "RESTART YOUR TERMINAL"
    shout "Run install_sudo after"
end

function install_sudo
    echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
    shout "Run install_essential after"
end

function install_essential
    brew install neovim git curl python3 hub tig
    shout "Run install_config_files after"
end

function install_config_files
    cp -r .config/nvim/ ~/.config/nvim
    curl -fLo (echo "$XDG_DATA_HOME"/nvim/site/autoload/plug.vim) --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    pip3 install neovim
    python3 -m pip install --user --upgrade pynvim
    cp -r $SPATH/etc/keys/ssh/* ~/.ssh/
    chmod 400 ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
    ssh-add
end

##############
# VM TESTING #
##############

function arm_raw_test
    set -x DISK_IMAGE disk.raw
    qemu-system-aarch64 -m 8G -M virt -accel hvf -cpu host -smp 4 -serial mon:stdio -nographic \
        -netdev user,id=mynet0,hostfwd=tcp::2222-:22,hostfwd=tcp::8080-:80,hostfwd=tcp::6443-:6443 \
        -device e1000,netdev=mynet0 \
        -drive file=/opt/homebrew/share/qemu/edk2-aarch64-code.fd,format=raw,if=pflash,readonly=on \
        -drive file=$DISK_IMAGE,if=virtio,cache=writethrough,format=raw
end

function x86_raw_test
    set -x DISK_IMAGE disk.raw
    qemu-system-x86_64 -m 8G -cpu Broadwell-v4 -nographic \
        -netdev user,id=mynet0,hostfwd=tcp::2222-:22,hostfwd=tcp::8080-:80,hostfwd=tcp::6443-:6443 \
        -device e1000,netdev=mynet0 \
        -snapshot $DISK_IMAGE
end

##################
# Podman Desktop #
##################

function pd-renderer-watch
    npx vitest -c packages/renderer/vite.config.js watch packages/renderer --passWithNoTests
end

function pd-main-watch
    npx vitest watch -r packages/main
end
