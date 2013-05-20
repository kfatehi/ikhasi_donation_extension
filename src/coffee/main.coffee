MyExtension = ->
  kango.ui.browserButton.addEventListener kango.ui.browserButton.event.COMMAND, =>
    @._onCommand()

MyExtension:: = _onCommand: ->
  kango.browser.tabs.create url: "http://kangoextensions.com/"

extension = new MyExtension()