VisualRailsGeneratorView = require './visual-rails-generator-view'
{CompositeDisposable} = require 'atom'
{Disposable} = require 'atom'

module.exports = VisualRailsGenerator =
  visualRailsGeneratorView: null
  modalPanel: null
  subscriptions: null
  terminal: null

  config: {
    beforeCommand: {
      type: 'string',
      title: 'Before command',
      default: '',
      description: 'This command is executed before the rails regenation command'
    },
    beforeString: {
      type: 'string',
      title: 'Before string',
      default: 'bundle exec',
      description: 'This string is added to the beginning of the regenation rails command'
    }

  }

  activate: (state) ->
    @visualRailsGeneratorView = new VisualRailsGeneratorView(state.visualRailsGeneratorViewState,this)
    # @modalPanel = atom.workspace.addModalPanel(item: @visualRailsGeneratorView.getElement(), visible: false)
    @modalPanel = atom.workspace.addBottomPanel(item: @visualRailsGeneratorView.getElement(), visible: false)



    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'visual-rails-generator:run': => @run()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @visualRailsGeneratorView.destroy()

  serialize: ->
    visualRailsGeneratorViewState: @visualRailsGeneratorView.serialize()

  consumeRunInTerminal: (service) ->
    @terminal= service
    # @visualRailsGeneratorView = new VisualRailsGeneratorView('initial',service)
    # service.run(['ls'])
    new Disposable -> stopUsingService(service)


  run: ->

    # path = atom.project.getPaths()[0]
    # atom.notifications.addInfo(path)
    # abre en atom
    # fs = require("fs");
    # f=  fs.readFileSync(path + "/Gemfile");
    # text= f.toString()
    # version = text.toString().match(/gem\s+('|")rails('|"), '(.*)'/)[3]
    # version = version.match(/\D+(\d+)\./)[1]
    # atom.notifications.addInfo('Raisl version ' + version)

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
