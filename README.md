# mqsi_commands_bash_completions
Bash completions for most common IBM mqsi* commands - completes the broker name for the first parameter and the execution groups after the `-e` paramter. For commands that work with running execution groups only, only those groups are displayed.



This works with IIB 10.0.* and bash 4.4.*

## Usage ##

In your .bash_profile :
    
    source /path/to/mqsi_completions.sh
       

## Limitations ##

- Depends on the MQSI_WORKPATH environment variable
- The brokers are read from `$MQSI_WORKPATH/components`
- The execution groups are read from `$MQSI_WORKPATH/components/{broker}/repository/brokeraaeg.dat` database
- The _running_ execution groups group names are read with `ps`

