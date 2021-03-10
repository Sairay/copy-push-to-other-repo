#!/bin/sh -l
##########################
set -e  # if a command fails it stops the execution
set -u  # script fails if trying to access to an undefined variable
#############################

SOURCE_DIRECTORY="$1"
USERNAME="$2"
TARGET_REPO_NAME="$3"
TARGET_BRANCH="$4"
USEREMAIL="$5"


mkdir targetrepo
echo "Cloning target git repo..."
# clone destination repo
echo "git clone --branch $TARGET_BRANCH https://$API_ACCESS_TOKIN@github.com/$USERNAME/$TARGET_REPO_NAME.git targetrepo"
git clone --branch "$TARGET_BRANCH" "https://$API_ACCESS_TOKIN@github.com/$USERNAME/$TARGET_REPO_NAME.git" targetrepo
ls -la targetrepo

echo "Copying files of from source"
cp -ra "$SOURCE_DIRECTORY"/. targetrepo
cd targetrepo

echo "Check files are existed..."
ls -la

echo "commit and push"
git status
git config --local user.email "$USEREMAIL"
git config --local user.name "$USERNAME"
git config --local push.default matching

git add .
git status
git commit --message "add files...."

git push "https://$USERNAME:$API_ACCESS_TOKIN@github.com/$USERNAME/$TARGET_REPO_NAME.git"

cd ..
rm -rf targetrepo