
class Equity.Folders

    constructor: ->
        new Folder("#{main.path}/exports/data/svg").create()
        new Folder("#{main.path}/exports/data/json").create()
        new Folder("#{main.path}/exports/data/xml").create()
        new Folder("#{main.path}/exports/images/web").create()
        new Folder("#{main.path}/exports/images/pdf").create()
        new Folder("#{main.path}/exports/logs").create()

