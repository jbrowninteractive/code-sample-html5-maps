
debug = false

Equity = {}

class Logger

   constructor: ->
        parent = new File($.fileName).parent
        time   = new Date().toString()
        path   = "#{parent.path}/exports/logs/#{time}.log"
        @file  = new File path
        @file.open "w"

    log: =>
        for arg in arguments
            $.writeln arg if debug
            @file.writeln arg

logger = new Logger()
log    = logger.log

compile = =>

    parent = new File($.fileName).parent
    folder = new Folder "#{parent}/src"
    files  = folder.getFiles "*.js"

    # include libs
    eval "#include #{parent}/lib/json2/json2.js"
    eval "#include #{parent}/lib/hex2rgb/hex2rgb.js"
    eval "#include #{parent}/lib/encoder/Encoder.js"

    # include coffee files
    for file in files
        eval "#include #{parent}/src/#{file.name}"

compile()

main = new Equity.Main()
main.init()
