on run argList
set x to argList
set {a, b, c} to x
set argIP to {a, b} as list
set argENV to c as text
repeat with ipList in argIP
    tell application "iTerm"
        tell current window
            create tab with profile "LAAOps"
        end tell
        tell current tab of current window
            set _new_session to last item of sessions
        end tell
        tell _new_session
            select
            set name to argENV & " - " & ipList
            write text "ssh " & ipList & " -i .ssh/" & argENV & "-general.pem"
        end tell
    end tell
end repeat
end run