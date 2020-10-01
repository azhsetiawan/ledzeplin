on run argv
    set appName to "Zeplin"

    set task to item 1 of argv

    if (count of argv) is greater than 1 then
        set user to item 2 of argv
        set pass to item 3 of argv
    end if

    if task = "switch" then
        switchAccount(appName, user, pass)
    else if task = "login" then
        logInAccount(appName, user, pass)
    else if task = "logout" then
        logOutAccount(appName)
    end if
end run

on runningApp(appName)
	tell application appName
		if it is not running then
			activate
        else
            reopen
            activate
		end if
	end tell
end runningApp

on knockKnock()
    tell application "System Events" to tell process "Zeplin"
        set theList to name of every UI element of group 1 of group 1 of front window
    end tell

    theList does not contain "Login"

end knockKnock

on whoIsThere()
    tell application "System Events" to tell process "Zeplin"
        tell group 1 of window 1
            click button 3
            delay 0.3
            tell group 1 of group 2 of pop over 1
                set nowUser to value of static text 1 of scroll area 1
            end tell
            delay 0.3
            click button 3
        end tell
    end tell

    return nowUser

end whoIsThere

on logIn(user, pass)

    set appUser to user
    set appPass to pass

    tell application "System Events" to tell process "Zeplin"
        -- copy password
        set the clipboard to appPass
        -- typing username
        keystroke appUser
        delay 0.3
        -- press tab
        key code 48
        delay 0.3
        -- paste password
        keystroke "v" using command down
        delay 0.3
        -- press enter
        key code 36
    end tell
end logIn

on logOut()
    tell application "System Events" to tell process "Zeplin"
        -- logout from menu bar item
        click menu item "Log Out" of menu "Zeplin" of menu bar item "Zeplin" of menu bar 1
    end tell

    return

end logOut

on switchAccount(appName, user, pass)

    runningApp(appName)
    delay 0.5

    set loggedIn to knockKnock()

    if loggedIn then
        set mich to whoIsThere()
        if user is mich then
            return ("Nice try! Can't switch to same account")
        else
            log ("Wait a second...")
            logOut()
            delay 0.3
            logIn(user, pass)
            return ("Voila! Magic!")
        end if
    else
        log ("Forgot to login? Let me help you...")
        logIn(user, pass)
        return ("Welcome back, " & user)
    end if
end switchAccount

on logInAccount(appName, user, pass)

    runningApp(appName)
    delay 0.5

    set loggedIn to knockKnock()

    if loggedIn then
        set mich to whoIsThere()
        log ("Already logged in as " & mich)
        if user is mich then
            return ("You need to calm down!")
        else
            return ("Don't worry, use switch to login as " & user)
        end if
    else
        logIn(user, pass)
        return ("Welcome back, " & user)
    end if
end logInAccount

on logOutAccount(appName)

    runningApp(appName)
    delay 0.5

    set loggedIn to knockKnock()

    if loggedIn then
        logOut()
        return ("Bye bye")
    else
        return ("Hey, you've already logged out!")     
    end if
end logOutAccount