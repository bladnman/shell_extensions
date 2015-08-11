#Shell Extensions
A `.profile` can get out of hand, this little environment is here to help that situation. From one command file you can pick and choose what kind of shell you want

##Install
First, you need to clone this GIT repo locally.

```
> git clone ...
```

Then you need to tell your command system to execute this subsystem. Basically you need to tell your `.profile` to run this stuff. The issue here is that many people run their profiles differently. I use a `.bashrc` to run most things so that jobs have the same tools I have mostly. So these instructions assume that:

```
# in .bashrc - assuming 'shell_extensions'
# is where you cloned to

if [ -f ~/shell_extensions/install ]; then
   . ~/shell_extensions/install
fi
```

##Configure
Finally, it's time to pick and choose the extensions you want. The `install` file is very self-explanitory, so I'd go edit that.


##Extend
To extend just follow the simple pattern of creating a new file and linking it in in the `install` file and resist the urge to simply add to one that's already there. It will keep things much cleaner and you saner in the future as you get more and more choosy about which items run when.


##Overview
Below are descriptions about the main parts of the system as a default. Your list should end up much much bigger, though.

###bash_git_prompt
A very clean shell prompt that will show you GIT status indicators and repo name.

###Standard Aliases
Some of the standard alias settings used for a shell
