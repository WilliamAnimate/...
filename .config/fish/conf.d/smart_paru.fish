# see smart_su.fish to understand this
# (cause shell scripting is harder than malbodge)
function paru
    if test (count $argv) -eq 0
        command paru
    else
        # TODO: account for --help lmao
        command paru --removemake $argv
    end
end

