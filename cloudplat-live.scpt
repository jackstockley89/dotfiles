tell application "iTerm"
    tell current window
        create tab with default profile
    end tell
    tell current session of current window
        split vertically with default profile
        split vertically with default profile
    end tell
    tell first session of current tab of current window
        write text "scc -p live"
    end tell
    tell second session of current tab of current window
        write text "cd repo"
    end tell
    tell third session of current tab of current window
        write text "scc -p manager"
    end tell
end tell