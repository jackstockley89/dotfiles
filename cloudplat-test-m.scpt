tell application "iTerm"
    tell current window
        create tab with default profile
    end tell
    tell current session of current window
        split vertically with default profile
        split horizontally with default profile
    end tell
    tell first session of current tab of current window
        set name to "cloud-platform test monitoring - 1"
        write text "scc -p test"
    end tell
    tell second session of current tab of current window
        set name to "cloud-platform test monitoring - 2"
        write text "scc -p test"
    end tell
    tell third session of current tab of current window
        split horizontally with default profile
    end tell
    tell third session of current tab of current window
        set name to "cloud-platform test monitoring - 3"
        write text "scc -p test"
    end tell
    tell fourth session of current tab of current window
        set name to "cloud-platform test monitoring - 4"
        write text "scc -p test"
    end tell
end tell