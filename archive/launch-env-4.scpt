on run argList
set x to argList
set {a, b, c, d, e} to x
set argIP to {a, b, c, d} as list
set argENV to e as text
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