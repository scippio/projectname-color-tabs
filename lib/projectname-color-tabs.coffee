ProjectnameColorTabsView = require './projectname-color-tabs-view'
{CompositeDisposable} = require 'atom'

module.exports = ProjectnameColorTabs =
  projectnameColorTabsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @projectnameColorTabsView = new ProjectnameColorTabsView(state.projectnameColorTabsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @projectnameColorTabsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'projectname-color-tabs:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @projectnameColorTabsView.destroy()

  serialize: ->
    projectnameColorTabsViewState: @projectnameColorTabsView.serialize()

  toggle: ->
    console.log 'ProjectnameColorTabs was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
