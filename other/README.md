# Often used github commands

## Retrieve actual version
$ git pull

## Upload files
* $ git add file1.m file2.m
* $ git commit -m "Update text"
* $ git push -u origin master

Avoid git add .  -> commitments you don't want because all files are added,
even the one that you don't want to add
e.g. matlab autosave files like file1.asv or temporary files like file1.m~.
>> git add *
>> git add .

## Rename & remove files or directories
Do not rename files on your local computer without using
the appropriate github command in the bash!

### Rename
>> git mv filename1.m filename2.m
>> git mv foldername1/ foldername2/

###
>> git mv foldername1/ subfolder/foldername1/

If this does not work:
Move the content from foldername1/ into subfolder/foldername1/
>> git mv foldername1/* subfolder/foldername1/

## Remove files & directories
Do not remove files on local computer without using
the appropriate github command in the bash!

### Files
>> git rm file1.m file2.m

The option -f forces the removal.
E.g. >> git rm -f file1.m
The option * removes all files.
E.g. >> git rm *

### Non-empty directories
If you wish to erase a directory WITH its containing files
use the following command
>> git rm -r <directory name>

### Empty directories
Empty directories do not need to be deleted in git.
As soon as they are empty, the do not appear anymore in
the online repository. However, their local version still
exist on the computer and still need to be removed.
This can be done by
>> rm -d <directory name>
(Without "git" at the beginning; -d means that a directory
is deleted)


## Get entire project directory
git clone git@github.com:ypopoff/stock_market_12.git

## Create new branch



