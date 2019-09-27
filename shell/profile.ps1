$env:PRISMA_MANAGEMENT_API_SECRET = 'my-secret'
$PRISMA_MANAGEMENT_API_SECRET = 'my-secret'
$env:DOAT = $(yq .doat "$HOME\secrets\secrets.yml")
$env:DOFP = $(yq .dofp "$HOME\secrets\secrets.yml")
$env:KEY_ID = $(yq .key_id "$HOME\secrets\secrets.yml")
$DOAT = $(yq .doat "$HOME\secrets\secrets.yml")
$DOFP = $(yq .dofp "$HOME\secrets\secrets.yml")
$KEY_ID = $(yq .key_id "$HOME\secrets\secrets.yml")
& "C:\Program Files\Docker Toolbox\docker-machine.exe" env | Invoke-Expression
$env:HOME = $HOME

function Docker-Use {
    param([string]$name)
    & docker-machine env $name | Invoke-Expression
}

function Save-Profile {
    cp $profile $HOME\OneDrive\profiles\
}

function Push {
    param([string]$message)
    git add . -A
    git commit -m $message
    git push
}

function Commit {
    param([string]$message)
    git add . -A
    git commit -m $message
}

function Eggshell {
    param([string]$proj_name)
    mkdir $proj_name
    git clone git@gitlab.com:zwhitchcox/eggshell.git $proj_name
    cd $proj_name
    git remote rm origin
    git remote add origin git@gitlab.com:zwhitchcox/$proj_name.git
    git add . -A
    git commit -m "new project $proj_name"
    git push --set-upstream git@gitlab.com:zwhitchcox/$proj_name.git master
}
function EggshellPrisma {
    param([string]$proj_name, [string]$branch)
    mkdir $proj_name
    git clone --single-branch --branch $branch git@gitlab.com:zwhitchcox/eggshell-prisma.git $proj_name
    cd $proj_name
    git remote rm origin
    git remote add origin git@gitlab.com:zwhitchcox/$proj_name.git
    git add . -A
    git commit -m "new project $proj_name"
    git push --set-upstream git@gitlab.com:zwhitchcox/$proj_name.git master
}
$env:PRISMA_MANAGEMENT_API_SECRET = 'my-secret'