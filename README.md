# Overview
This is a custom terminal emulator build using [GNU Readline Library](http://cnswww.cns.cwru.edu/php/chet/readline/readline.html). Code is written in Perl, but ideally you can use any language whis has support for above GNU library.

# Getting Started
Use the help command to get the list of featurs.
```
>> help
```

# Featues
## Variables
This allows a macro like feature where you can set name to any arbitary string and use the name as a subtitute for string in command line.
### Example
```
>> set proj_dir /home/john/projects/
```
this will set 'proj_dir' to '/home/john/projects/', now we can use this variable name 'proj_dir' in command line as a subtitute for '/home/john/projects/'
```
>> ls $proj_dir
```
Note '$' prefix indicate that its variable name and will be expanded if variable with similar name exist.