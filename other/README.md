# Often used github commands

## Retrieve actual version
<code> git pull </code>

## Upload files
<p> <code> git add file1.m file2.m </code> </p>
<p> <code> git commit -m "Update text" </code> </p>
<p> <code> git push -u origin master </code> </p>

Avoid git add .  -> commitments you don't want because all files are added,
even the one that you don't want to add
e.g. matlab autosave files like file1.asv or temporary files like file1.m~.
<p> <code> git add * </code> </p>
<p> <code> git add . </code> </p>

## Rename & remove files or directories
Do not rename files on your local computer without using
the appropriate github command in the bash!

### Rename
<p> <code> git mv filename1.m filename2.m </code> </p>
<p> <code> git mv foldername1/ foldername2/ </code> </p>

### Move
<p> <code> git mv foldername1/ subfolder/foldername1/ </code> </p>

If this does not work:
Move the content from foldername1/ into subfolder/foldername1/
<p> <code> git mv foldername1/* subfolder/foldername1/ </code> </p>

## Remove files & directories
Do not remove files on local computer without using
the appropriate github command in the bash!

### Files
<p> <code> git rm file1.m file2.m </code> </p>

The option -f forces the removal.
E.g. <p> <code> git rm -f file1.m </code> </p>
The option * removes all files.
E.g. <p> <code> git rm * </code> </p>

### Non-empty directories
If you wish to erase a directory WITH its containing files
use the following command
<p> <code> git rm -r <directory name> </code> </p>

### Empty directories
Empty directories do not need to be deleted in git.
As soon as they are empty, the do not appear anymore in
the online repository. However, their local version still
exist on the computer and still need to be removed.
This can be done by
<p> <code> rm -d <directory name> </code> </p>
(Without "git" at the beginning; -d means that a directory
is deleted)

## Get entire project directory
<p> <code> git clone git@github.com:ypopoff/stock_market_12.git </code> </p>

## Create new branch

## Create directory
Directories do not need to be created on the online version,
because they are automatically generated.
Therefore, you only have to create the directory on your local
computer with the following command
<p> <code> mkdir foldername </code> </p>



