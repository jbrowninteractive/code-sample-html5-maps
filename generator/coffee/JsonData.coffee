
class Equity.JsonData

    constructor: (@property) ->
        @path = "#{main.path}/exports/data/json/#{@property.id}.json"
        @_export()

    _export: =>
        svg  = @_getSvg()
        json = JSON.stringify @_parseHotspotNodes(svg)
        file = new File @path
        file.open "w"
        file.write json
        file.close()

    _getSvg: =>
        file = new File "#{main.path}/exports/data/svg/#{@property.id}.svg"
        file.open "r"
        raw = file.read()
        svg = new XML raw
        file.close()
        return svg

    _parseHotspotNodes: (node) =>
        objects  = []
        children = node.elements()
        length   = children.length()
        for [0...length]
            child  = if length is 1 then node.child(_i) else children.child(_i)
            object = @_parseHotspot child
            if object then objects.push object
        return objects

    _parseHotspot: (node) =>
        id = @_parseUnitId node
        switch node.localName()
            when "polygon"
                pts    = @_formatPoints node.attribute("points").toString()
                object =
                    shape  : "poly"
                    id     : id
                    coords : pts
            when "rect"
                x      = Number node.attribute("x")
                y      = Number node.attribute("y")
                w      = Number node.attribute("width")
                h      = Number node.attribute("height")
                object =
                    shape  : "rect"
                    id     : id
                    coords : "#{x},#{y},#{x+w},#{y+h}"
            when "circle"
                x      = Number node.attribute("cx")
                y      = Number node.attribute("cy")
                r      = Number node.attribute("r")
                object =
                    shape  : "circle"
                    id     : id
                    coords : "#{x},#{y},#{r}"
            else
                error  = "Invalid Shape: [#{node.localName()}] "
                error += "used for unit #{id} in property #{@property.id}"
                main.errors.push error
        return object

    _parseUnitId: (node) =>
        raw   = @_formatUnicodeText node.attribute("id").toString()
        parts = raw.split "|"
        parts = parts.splice 1, parts.length-1
        return unless parts
        id    = parts.join "|"
        return id

    _formatPoints: (points) =>
        str   = ""
        parts = points.split " "
        for part in parts
            if part isnt ""
                part += ","
                str  += part
        if str[str.length-1] is ","
            str = str.substring 0, str.length-1
        return str

    _formatUnicodeText: (id) =>
        id = id.toLowerCase()
        for c of @chars
            exp = new RegExp(c,"g");
            id  = id.replace exp, @chars[c]
        return id

    chars :
        "_x20_" : " "
        "_x21_" : "!"
        "_x23_" : "#"
        "_x24_" : "$"
        "_x25_" : "%"
        "_x26_" : "&"
        "_x27_" : "'"
        "_x28_" : "("
        "_x29_" : ")"
        "_x2a_" : "*"
        "_x2b_" : "+"
        "_x2c_" : ","
        "_x2d_" : "-"
        "_x2e_" : "."
        "_x2f_" : "/"
        "_x30_" : "0"
        "_x31_" : "1"
        "_x32_" : "2"
        "_x33_" : "3"
        "_x34_" : "4"
        "_x35_" : "5"
        "_x36_" : "6"
        "_x37_" : "7"
        "_x38_" : "8"
        "_x39_" : "9"
        "_x3a_" : ":"
        "_x3b_" : ";"
        "_x3c_" : "<"
        "_x3d_" : "="
        "_x3e_" : ">"
        "_x3f_" : "?"
        "_x40_" : "@"
        "_x41_" : "A"
        "_x42_" : "B"
        "_x43_" : "C"
        "_x44_" : "D"
        "_x45_" : "E"
        "_x46_" : "F"
        "_x47_" : "G"
        "_x48_" : "H"
        "_x49_" : "I"
        "_x4a_" : "J"
        "_x4b_" : "K"
        "_x4c_" : "L"
        "_x4d_" : "M"
        "_x4e_" : "N"
        "_x4f_" : "O"
        "_x50_" : "P"
        "_x51_" : "Q"
        "_x52_" : "R"
        "_x53_" : "S"
        "_x54_" : "T"
        "_x55_" : "U"
        "_x56_" : "V"
        "_x57_" : "W"
        "_x58_" : "X"
        "_x59_" : "Y"
        "_x5a_" : "Z"
        "_x5b_" : "["
        "_x5d_" : "]"
        "_x5e_" : "^"
        "_x5f_" : "_"
        "_x60_" : "`"
        "_x61_" : "a"
        "_x62_" : "b"
        "_x63_" : "c"
        "_x64_" : "d"
        "_x65_" : "e"
        "_x66_" : "f"
        "_x67_" : "g"
        "_x68_" : "h"
        "_x69_" : "i"
        "_x6a_" : "j"
        "_x6b_" : "k"
        "_x6c_" : "l"
        "_x6d_" : "m"
        "_x6e_" : "n"
        "_x6f_" : "o"
        "_x70_" : "p"
        "_x71_" : "q"
        "_x72_" : "r"
        "_x73_" : "s"
        "_x74_" : "t"
        "_x75_" : "u"
        "_x76_" : "v"
        "_x77_" : "w"
        "_x78_" : "x"
        "_x79_" : "y"
        "_x7a_" : "z"
        "_x7b_" : "{"
        "_x7c_" : "|"
        "_x7d_" : "}"
        "_x7e_" : "~"
