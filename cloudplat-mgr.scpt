tell application "iTerm"
    tell current window
        create tab with default profile
    end tell
    tell current session of current window
        split vertically with default profile
    end tell
    tell first session of current tab of current window
        set name to "cloud-platform manager"
        write text "scc -p manager"
        write text "clear"
    end tell
    tell second session of current tab of current window
        set name to "cloud-platform manager"
        write text "scc -p manager"
        write text "cd repo"
        write text "clear"
    end tell
end tell