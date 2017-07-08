# Template = require('./form.html')
ScaffoldModelView = require './scaffold_model_view'
module.exports =

class VisualRailsGeneratorView
  constructor: (serializedState,generator) ->

    @element = document.createElement('div')
    @element.classList.add('visual-rails-generator','native-key-bindings')

    # Create message element

    # field.appendChild(button)
    @scaffoldModelView= new ScaffoldModelView(generator)
    div = this.div_type()

    # div.appendChild(@scaffoldModelView.getElement())
    div.classList.add('message')


    @element.appendChild(div)

  div_type: () ->
    div = document.createElement('div')
    h1 = document.createElement('h1')
    # h1.textContent = __dirname
    h1.textContent = "Rails Generator"


    div.appendChild(h1)

    div2 = document.createElement('div')
    div2.classList.add('div-form')
    label = document.createElement('label')
    label.textContent = "Generator Type"
    label.for = "select-generator-type"
    label.classList.add('control-label')
    div2.appendChild(label)

    select = document.createElement('select')
    select.id= "select-generator-type"

    arr_fields = ['','scaffold','model','migration','controller']
    for i,f of arr_fields
      option = document.createElement('option')
      option.value = f
      option.textContent = f
      select.appendChild(option)

    select.classList.add('form-control')
    select.appendChild(option)
    select.addEventListener('change', () => this.selectChange());

    div2.appendChild(select)
    div.appendChild(div2)

    div2 = document.createElement('div')
    div2.id= "div-generator-type"
    div.appendChild(div2)

    div

  selectChange: () ->
    div = document.querySelector("#div-generator-type")
    select = document.querySelector("#select-generator-type")
    switch select.value
      when "scaffold"
         div.appendChild( @scaffoldModelView.getElement() )
      when "model"
         div.appendChild( @scaffoldModelView.getElement() )





  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
