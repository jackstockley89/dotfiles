tell application "iTerm"
    tell current window
        create tab with default profile
    end tell
    tell current session of current window
        split vertically with default profile
    end tell
    tell first session of current tab of current window
        set name to "cloud-platform live"
        write text "scc -p live"
        write text "clear"
    end tell
    tell second session of current tab of current window
        set name to "cloud-platform live"
        write text "scc -p live"
        write text "cd repo"
        write text "clear"
    end tell
end tell