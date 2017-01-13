class Equity.PropertyList extends Array

    constructor: ->

        @paths = File.openDialog "Choose Your File(s)", ["*.ai"], true

        return @ unless @paths

        for path in @paths
            path  = path.toString()
            parts = path.split "/"
            file  = parts[parts.length-1]
            parts = file.split "."
            continue if parts.length isnt 2
            id    = parts[0]
            type  = parts[1]
            continue if type isnt "ai"
            @push new Equity.Property(id, path)

        compare = (a, b) ->
            return a.id - b.id
        @sort compare
