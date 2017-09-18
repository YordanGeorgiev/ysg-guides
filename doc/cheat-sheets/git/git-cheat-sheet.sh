#file: git-cheat-sheet.sh

# how-to remove all the files from staging
git reset HEAD -- .


# who has done what in the current branch
git log --format='%h %ai %an %m%m %s'

# how-to list which files were added to the 6804322 commit
git diff-tree --no-commit-id --name-only -r 6804322


# who has done what on a specific file
git log --format='%h %ai %an %m%m %s' --follow some/file

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

#how-to delete a local branch
git branch -D branch_to_delete

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
# how-to show which files have been commited 
git diff-tree --no-commit-id --name-only -r $git_obj


# how-to check all the branches 
git branch -a

# chekout as specific branch
git fetch --all
git checkout feature/feature_name

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
# how-to link Stash commits to jira issues 
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



#eof file: git-cheat-sheet.sh