on run argList
set argList to argList as list
repeat with ipList in argList
    tell application "iTerm"
        tell current window
            create tab with profile "LAAOps"
        end tell
        tell current tab of current window
            set _new_session to last item of sessions
        end tell
        tell _new_session
            select
            set name to ipList
            write text "ssh " & ipList & " -i .ssh/staging-general.pem"
        end tell
    end tell
end repeat
end run