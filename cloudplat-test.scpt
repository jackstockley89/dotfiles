tell application "iTerm"
    tell current window
        create tab with default profile
    end tell
    tell current session of current window
        split vertically with default profile
    end tell
    tell first session of current tab of current window
        write text "scc -p test"
    end tell
    tell second session of current tab of current window
        write text "cd repo"
    end tell
end tell