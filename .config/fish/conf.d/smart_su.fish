function su
    if test (count $argv) -eq 0
        if test (pwd) = ~
            # goto /root if user is at their home dir
            command su - root
        else
            # otherwise, stay where the user was
            command su $argv
        end
    else
        # more args, probably user not switching to root or they're just
        # running su --help or something like that
        command su $argv
    end
end

