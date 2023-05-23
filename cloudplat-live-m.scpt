tell application "iTerm"
    tell current window
        create tab with default profile
    end tell
    tell current session of current window
        split vertically with default profile
        split horizontally with default profile
    end tell
    tell first session of current tab of current window
        set name to "cloud-platform live monitoring - 1"
        write text "scc -p live"
        write text "clear"
    end tell
    tell second session of current tab of current window
        set name to "cloud-platform live monitoring - 2"
        write text "scc -p live"
        write text "clear"
    end tell
    tell third session of current tab of current window
        split horizontally with default profile
    end tell
    tell third session of current tab of current window
        set name to "cloud-platform live monitoring - 3"
        write text "scc -p live"
        write text "clear"
    end tell
    tell fourth session of current tab of current window
        set name to "cloud-platform live monitoring - 4"
        write text "scc -p live"
        write text "clear"
    end tell
end tell