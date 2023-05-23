tell application "iTerm"
    tell current window
        create tab with default profile
    end tell
    tell current session of current window
        split vertically with default profile
    end tell
    tell first session of current tab of current window
        set name to "cloud-platform test"
        write text "scc -p test"
    end tell
    tell second session of current tab of current window
        set name to "cloud-platform test"
        write text "cd repo"
        write text "scc -p test"
    end tell
end tell