def sendRaw(rawCmd)
    $irc.puts(rawCmd)
end

def nick(nick)
    sendRaw("NICK #{nick}")
    puts("[NICK Changed to #{nick} - #{@server}]")
end

def quit(quitMessage)
    sendRaw("QUIT :#{quitMessage}")
    puts("[QUIT - #{@server}]")
end

def part(chan)
    sendRaw("PART #{chan}")
    puts("[PARTED #{chan} - #{@server}]")
end

def join(chan)
    sendRaw("JOIN #{chan}")
    puts("JOINED #{chan} - #{@server}]")
end

def action(meMessage, dest)
    sendRaw("PRIVMSG #{dest} :\001ACTION #{meMessage}\001")
    puts("[ACTION #{dest} - #{meMessage} - #{@server}]")
end

def say(sayMessage, dest)
    sendRaw("PRIVMSG #{dest} :#{sayMessage}")
    puts("[SAY #{dest} - #{sayMessage} - #{@server}]")
end

def notice(noticeMsg, dest)
    sendRaw("NOTICE #{dest} :#{noticeMsg}")
    puts("[NOTICE #{dest} - #{noticeMsg} - #{@server}]")
end