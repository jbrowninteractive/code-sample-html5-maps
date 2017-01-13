
# node Build.coffee

fileSystem   = require "fs"
childProcess = require "child_process"
processList  = []


init = =>
    addProcess "../", "Start.coffee"
    for file in getFiles()
        addProcess "../src", file
    startWatching()

startWatching = =>
    setInterval =>
        checkNewFiles()
        checkDeletedFiles()
    ,500

addProcess = (output, file) =>
    command = "coffee -b -o #{output} -wc ../coffee/#{file}"
    process = childProcess.exec command
    processList.push command:command, output:output, file:file, process:process

getFiles = =>
    a = []
    files = fileSystem.readdirSync "../coffee"
    for file in files
        if file is "Start.coffee"
            continue
        parts = file.split "."
        type  = parts[parts.length-1]
        if type isnt "coffee"
            continue
        a.push file
    return a

checkNewFiles = =>
    for file in getFiles()
        if file is "Start.coffee"
            continue
        if not inProcessList file
            addProcess "../src", file

checkDeletedFiles = =>
    for item in processList
        if item.file is "Start.coffee"
            continue
        if not inFileList item
            item.process.kill()
            index = processList.indexOf item
            processList.splice index, 1
            break

inFileList = (item) =>
    for file in getFiles()
        if file is item.file
            return true

inProcessList = (file) =>
    for item in processList
        if item.file is file
            return true

init()
