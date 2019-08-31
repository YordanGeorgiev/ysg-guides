#file: git-cheat-sheet.sh

# start :: how-to use different ssh identity files

# create the company identity file
ssh-keygen -t rsa -b 4096 -C "first.last@corp.com"
# save private key to ~/.ssh/id_rsa.corp, 
cat ~/.ssh/id_rsa.corp.pub # copy paste this string into your corp web ui security ssh keys

# create your private identify file
ssh-keygen -t rsa -b 4096 -C "me@gmail.com"
# save private key to ~/.ssh/id_rsa.me, note the public key ~/.ssh/id_rsa.me.pub
cat ~/.ssh/id_rsa.me.pub # copy paste this one into your githubs, private keys

# clone company internal repo as follows
GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.corp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" \
git clone git@git.in.corp.com:corp/project.git

export git_msg="my commit msg with my corporate identity"
git add --all ; git commit -m "$git_msg" --author "MeFirst MeLast <first.last@corp.com>"
GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.corp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" \
git push 

# clone public repo as follows
GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.corp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" \
git clone git@github.com:acoolprojectowner/coolproject.git

export git_msg="my commit msg with my personal identity"
git add --all ; git commit -m "$git_msg" --author "MeFirst MeLast <first.last@gmail.com>"
GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.me -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" \
git push 

# stop :: how-to use different ssh identity files



git log --graph --decorate --pretty=oneline --abbrev-commit develop origin/develop temp

# revert the <<commit-hash>> 
git revert <<hash>> 

# how-to rebase your feature branch into develop quickly 
# set your current branch , make a backup of it , caveat minute precision
curr_branch=$(git rev-parse --abbrev-ref HEAD); git branch "$curr_branch"--$(date "+%Y%m%d_%H%M"); git branch -a | grep $curr_branch | sort -nr

# squash all your changes at once 
git reset $(git merge-base develop $curr_branch)

# check the modified files to add 
git status

# add the modified files dir by dir, or file by file or all as shown
git add --all 

# check once again with the author time and commiter time 
git log --pretty --format='%h %ai %<(15)%an ::: %s'
git log --pretty --format='%h %cI %<(15)%an ::: %s'


# add the single message of your commit for the stuff you did 
git commit -m "<<MY-ISSUE-ID>>: add my very important feature"

# check once again this time with the commiter time only 
git log --pretty --format='%h %cI %<(15)%an ::: %s'

# make a backup once again , use seconds precision if you were too fast ... 
curr_branch=$(git rev-parse --abbrev-ref HEAD); git branch "$curr_branch"--$(date "+%Y%m%d_%H%M"); git branch -a | grep $curr_branch | sort -nr

# compare the old backup with the new backup , should not have any differences 
git diff <<old-backup>>..<<new-backup-branch>>


# you would have to git push force to your feature branch 
git push --force 


# who did what and when in the current branch, start digging for why by git show $commit_short_hash
git log --pretty --format='%h %cI %<(15)%an ::: %s'

# who did what and when on a specific part of a file ( lines 0 to 10)
git blame path/to/file -L 0,10 

# get the commit from which you wanto to change the history 
last_own_commit_hash=babba7c



# start eding the history
git rebase -i $last_own_commit_hash
# on the first opening of the file change ONLY the picks -> squash or whatever
# on the second opening of the commit msg file change the commit msg to add

# how-to remove a file added accidentally from the whole history
git filter-branch --tree-filter 'rm -f passwords.txt' HEAD

# how-to remove all the files from staging
git reset HEAD -- .

# how-to restore a
git reset HEAD --hard

# who has done what in the current branch
git log --format='%h %ai %an %m%m %s'

# how-to list which files were added to the 6804322 commit
git diff-tree --no-commit-id --name-only -r 6804322

# who has done what on a specific file
git log --format='%h %ai %an %m%m %s' --follow some/f

# how-to check all the current branches with less in colors
git branch -a --color=always | less -r

# how-to remove deleted files from git
git ls-files --deleted -z | xargs -0 git rm

#how-to delete a remote branch 
git push --force remote_name :branch_to_delete
git push origin --delete feature/feature_to_delete

# compare the a tmp branch and the master branch
git log --graph --decorate --pretty=oneline --abbrev-commit master origin/master tmp

# how-to reset the local repo branch to be just like the remote one
# you could skip those 2 lines if you do not want to save your local changes
git commit -a -m "Saving my work, just in case"
git branch my-saved-work

# overwrite you local master with the remote one - or another branch ... 
git fetch origin
git reset --hard origin/master

# how-to compare the same file contents in the 
git diff mybranch master -- path/to/file

git fetch --all
git fetch -p origin

# push my cool feature to  my repo fork
git push myrepofork feature/mycoolfeature

#how-to delete a branch locally and remotely
git branch -D branch_to_delete
git push -d origin branch_to_delete

# how-to list your existing tags
git tag
git push origin tag_name


# how-to tag a version 
export msg="a simple scala console project"
export version='v0.9.0.1'
export tag_msg=" $version -- "`date "+%Y-%m-%d %H:%M:%S"`" -- $msg"
git tag -a $version -m "$tag_msg"
#how-to check a version 
git show $version


# to check a specific commit 
git show $git_obj
# howo show which files have been commited 
git diff-tree --no-commit-id --name-only -r $git_obj


# how-to check all the branches 
git branch -a

# chekout as specific branch
git fetch --all
git checkout feature/feature_name

# how-to delete local branches deleted already on the remote
git fetch -p --all



git checkout develop -- `git ls-tree --name-only -r develop | egrep '*.zip'`

# how-to compare 2 brancches 
git diff branch1 branch2

git log
# git status in colors
git -c color.status=always status | less -REX

# before rebasing 
git pull --rebase

# remove the unneeded commits from the last 10 
git rebase -i HEAD~10




# how-to apply a commit from specific branch to the current branch
git cherry-pick $commit_sha_to_apply


# list all the remote branches
git branch --all 
git branch --remotes




#how-to install git on Ubuntu, RH and cygwin
apt-get install -y git
yum install -y git
setup-x86_64.exe -q -s http://cygwin.mirror.constant.com -P "inetutils,wget,open-ssh,curl,grep,egrep,git"

# pretend starting from different directory 
git -C ..
alias git="git -C $dir"


# to to the tmp dir 
cd /tmp 
ƒ
# set a pw run-time store in the cache 
git config --global credential.helper cache
git config --global core.editor "vim"
git config credential.helper 'cache --timeout=3600'
# configure the user name and e-mail for git 
git config --global user.name "YordanGeorgiev"
git config --global user.email "yordan.georgiev@gmail.com"
# configure push behaviour
git config --global push.default simple

# and verify
less ~/.gitconfig

# generate your ssh keys to authenticate yourself against github
ssh-keygen -t ecdsa -b 521
# paste the output as new key into the https://github.com/settings/keys section
cat ~/.ssh/id_ecdsa.pub


# add the remote 
# this one asks usually a pw
git remote add origin https://github.com/YordanGeorgiev/isg-pub.git

# this one does not ask for pw if you have ssh keys set up in github
git remote set-url origin git+ssh://git@github.com/YordanGeorgiev/aspark-starter

# initialize a new git repo
git init
# clone the existing repo from the Internet
git clone https://github.com/YordanGeorgiev/isg-pub.git
# move the .git dir to the 

# ups something went rong should redo 
git rm --cached -r .

# add the product version dir 
git add -v --all isg-pub.0.8.9.dev.ysg
# force remote repo rebuild 
git push --force -u origin master
git push -u origin master



# initialize
git init
# add remote origin
git remote add origin https://github.com/YordanGeorgiev/isg-pub.git
https://github.com/YordanGeorgiev/nzbackup-runner.git
# verify
git remote -v
git config --global user.name "YordanGeorgiev"
git config --global user.email "yordan.georgiev@gmail.com"

# make git remember your pass 
git config --global credential.helper cache
git config credential.helper 'cache --timeout=3600'
# stop make git remember your pass 

# get help 
# git --help

# simly add all the files from the current directory
git add --all 
git rm --cached -r <<dir_i_did_not_want_to_add>>

# dry run adding verbose a dir 
git add -v -n --all isg-pub.0.8.9.dev.ysg



#create the master branch 
git push --force -u origin master
git push -u origin master

git commit -m "Adding $component_name $component_version files recursively " 

git push



# to remove all the files
git rm *

# to force master branch re-creation
man git-branch

wget --no-check-certificate https://github.com/$MyGitUserName/nzbackup-runner/archive/master.zip
# how-to clone 
git_repo_url=https://yordan.georgiev@git.aktia.biz/scm/~yordan.georgiev/core-5971.git
git clone "$git_repo_url"

# add the reamde file for the new project 
touch README.md
git add README.md

git pull origin master

# how-to add all the files ( except those matching the $issue/.gitignore ) 
git add --all
git commit -m "vw_INTIME_GL-create-view.sql v1.0.3 - re-write start with GL accounts"
git push origin master


# well this is more of an jira git integration , but anyway 
# how-to link stash commits to jira issues 
git commit -m "$issue_id 0.4.1 foo bar"

git log --pretty=format:"%cr %cn %s" --author="Georgiev Yordan" -3

# create a srong key for encryption with github
ssh-keygen -t ecdsa -b 521

#how-to highlight a single line by http link from github
# obs the #L<<line-number>>
https://github.com/futurice/lp_calculator_ui/blob/master/app/index.html#L47


# how-to pass a one time config variable to git
git -c color.status=always status | less -REX

# how-to delete all the obsolete feature branches
while read -r f; do git push ygeo :$f ; \
done < <(git branch -a | grep -i 'ygeo/feature' | grep -v 'kiky'| \
perl -nl -e 's/remotes\/ygeo\///g;print')

alias glol='git log --graph --pretty="%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset""
     --abbrev-commit'

# how-to fix the file permissions to the state git thinks they should be
git diff -p \
| grep -E '^(diff|old mode|new mode)' \
| sed -e 's/^old/NEW/;s/^new/old/;s/^NEW/new/' \
| git apply


# check the following resources:
# https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging
# https://gist.github.com/JamesMGreene/cdd0ac49f90c987e45ac

# how-to configure a git proxy 
git config --global http.proxy $http_proxy
git config --global https.proxy $https_proxy


# save your current working copy into the git stash
git stash

# check what there is in the git stash 
git stash list

# how-to remove a stash item 
git stash drop stash@{0}

# how-to pick a git stash 
git stash pop stash@{2}

# how-to remove the whole stash 
git stash clear

# how-to merge a feature branch
git merge -X dev--feature-branch --no-ff

# how-to remove the file from git , but not from the file system
git rm --cached src/file/to/path

# how-to remove the file both from the file system and git
git rm src/file/to/file

curr_branch=$(git rev-parse --abbrev-ref HEAD); git branch "$curr_branch"--$(date "+%Y%m%d_%H%M"); git branch -a | grep $curr_branch

# how-to delete a file from the current git branch history
git filter-branch -f --tree-filter 'rm -f cnf/sec/passwd/proj-name.htpasswd' HEAD

# how-to revert the last n commits already pushed on the remote branch
git push origin +ee9260c2^:v1.0.0-RC
# where ee9260c2 is the commit hash of the DESIRED commit to be left as the current one


git rev-list --all | (
    while read revision; do
        git grep -F 'scalaVersion' $revision
    done
)

#eof file: git-cheat-sheet.sh

git push origin +ee9260c2^:v1.0.0-RC