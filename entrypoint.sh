#!/bin/sh -l
##########################
set -e  # if a command fails it stops the execution
set -u  # script fails if trying to access to an undefined variable
#############################

SOURCE_DIRECTORY="$1"
USERNAME="$2"
TARGET_REPO_NAME="$3"
TARGET_BRANCH="$4"


mkdir targetrepo
echo "Cloning target git repo..."
# clone destination repo
git clone --branch "$TARGET_BRANCH" "https://$API_ACCESS_TOKIN@github.com/$USERNAME/$TARGET_REPO_NAME.git" targetrepo
ls -la targetrepo

echo "Copying files of from source"
cp -ra "$SOURCE_DIRECTORY"/. targetrepo
cd targetrepo

echo "Check files are existed..."
ls -la

echo "commit and push"
git status
git add .
git status

#to avoid committing without any changes
git diff-index --quiet HEAD || git commit --message "add files...."

git push origin --set-upstream "$TARGET_BRANCH"