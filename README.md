# Overview
This is a custom terminal emulator build using [GNU Readline Library](http://cnswww.cns.cwru.edu/php/chet/readline/readline.html). Code is written in Perl(cpan module [Term::ReadLine::Gnu](https://metacpan.org/pod/Term::ReadLine::Gnu) is used), but ideally you can use any language which has support for above GNU library.

# Getting Started
Use the help command to get the list of feature.
```
>> help
```

# Features
## Variables
This allows a macro like feature where you can set name to any arbitrary string and use the name as a substitute for string in command line.
### Example
```
>> set proj_dir /home/john/projects/
```
this will set 'proj_dir' to '/home/john/projects/', now we can use this variable name 'proj_dir' in command line as a substitute for '/home/john/projects/'
```
>> ls $proj_dir
```
Note '$' prefix indicate that its variable name and will be expanded if variable with similar name exist.

## Auto complete
This allows auto completing custom commands and variable names using '<tab>'.
### Example
* Auto complete commands
```
>> se<tab>
```
this will list all custom commands starting with prefix 'se'.
* Auto complete variables
```
>> ls $fo<tab>
```
this will list all custom variables starting with prefix 'fo'.
