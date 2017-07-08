module.exports =
class ScaffoldModelView

  constructor: (generator) ->
    @generator = generator
    div = document.createElement('div')

    div2 = document.createElement('div')
    div2.classList.add('col-6')

    label = document.createElement('label')
    label.textContent = "Model Namespace"
    label.for = "model-namespace"
    div2.appendChild(label)

    input = document.createElement('input')
    input.id = "namespace"
    input.classList.add('form-control')
    div2.appendChild(input)
    input.addEventListener('change', () => this.createQuery());

    div.appendChild(div2)

    div2 = document.createElement('div')
    div2.classList.add('col-6')

    label = document.createElement('label')
    label.textContent = "Model Name"
    label.for = "model-name"
    div2.appendChild(label)

    input = document.createElement('input')
    input.id = "model-name"
    input.classList.add('form-control')
    div2.appendChild(input)
    input.addEventListener('change', () => this.createQuery());

    div.appendChild(div2)


    field = document.createElement('fieldset')
    # field.classList
    field.id="cont-fields"
    # legend = document.createElement('legend')
    # legend.textContent = "Field"
    # field.appendChild(legend)

    div2 = document.createElement('div')
    div2.classList.add('div-form','labels')
    label = document.createElement('label')
    label.textContent = "Name"
    label.for = "field-name"
    div2.appendChild(label)

    label = document.createElement('label')
    label.textContent = "Type"
    label.for = "select-generator-type"
    div2.appendChild(label)

    label = document.createElement('label')
    label.textContent = "Limit"
    label.for = "field-limit"
    div2.appendChild(label)

    label = document.createElement('label')
    label.textContent = "Index"
    label.for = "field-index"
    div2.appendChild(label)
    field.appendChild(div2)

    div2 = this.divField(true)
    field.appendChild(div2)

    div.appendChild(field)

    button  = document.createElement('button')
    button.textContent = "Generate"
    button.classList.add('btn','btn-primary','generate')
    button.addEventListener('click', () => this.generateButtonClick());
    div.appendChild(button)

    h3  = document.createElement('h3')
    strong  = document.createElement('strong')
    strong.textContent = "Query: "
    span  = document.createElement('span')
    span.id = "query"
    h3.appendChild(strong)
    h3.appendChild(span)
    div.appendChild(h3)

    @element = div
    div

  divField: () ->
    div = document.createElement('div')
    div.classList.add('div-form','field')

    input = document.createElement('input')
    input.id = "field-name"
    input.classList.add('name','form-control')
    div.appendChild(input)
    input.addEventListener('change', () => this.createQuery());

    select = document.createElement('select')
    select.classList.add('type','form-control')
    arr_fields = ['string','digest','text','integer','primary_key','decimal','float','boolean','binary','date','time','datetime','references','references{polymorphic}']
    for i,f of arr_fields
      option = document.createElement('option')
      option.value = f
      option.textContent = f
      select.appendChild(option)
    div.appendChild(select)
    select.addEventListener('change', () => this.createQuery());

    input = document.createElement('input')
    input.id = "field-limit"
    input.classList.add('limit','form-control')
    input.addEventListener('change', () => this.createQuery());
    div.appendChild(input)

    select = document.createElement('select')
    select.classList.add('index','form-control')
    arr_fields = ['','index','uniq']
    for i,f of arr_fields
      option = document.createElement('option')
      option.value = f
      option.textContent = f
      select.appendChild(option)
    div.appendChild(select)
    select.addEventListener('change', () => this.createQuery());


    button  = document.createElement('button')
    button.textContent = "+"
    button.classList.add('btn','btn-primary','more')
    button.addEventListener('click', (e) =>
      this.buttonMoreClick(e.target)
      );
    div.appendChild(button)

    button  = document.createElement('button')
    button.textContent = "X"
    button.classList.add('btn','btn-primary','erase','hide')
    button.addEventListener('click', (e) =>
       this.buttonEraseClick(e.target)
       );
    div.appendChild(button)

    return div

  buttonMoreClick: (elm) ->
    div = this.divField()
    elm.classList.add('hide')
    elm.parentNode.querySelector('.erase').classList.remove('hide')
    field = document.querySelector('#cont-fields')
    field.appendChild(div)

  buttonEraseClick: (elm) ->
    div = elm.parentNode
    div.parentNode.removeChild(div);

  createQuery: () ->
    model =   document.querySelector('#model-name').value
    model = model.charAt(0).toUpperCase() + model.slice(1);
    namespace =   document.querySelector('#namespace').value
    before_string = atom.config.get('visual-rails-generator.beforeString')
    command  = ""
    if before_string.length > 0
      command  += before_string
    command += " rails g "
    command += document.querySelector('#select-generator-type').value + ' '
    if namespace.size>0
      command += namespace + '/'
    command += model + ' '
    document.querySelectorAll('.field').forEach (elm,i) ->
      input_limit = elm.querySelector('.limit')
      field = elm.querySelector('.name').value
      tipo  = elm.querySelector('select.type').value
      limit = input_limit.value
      index = elm.querySelector('select.index').value

      if tipo not in ["integer","string","text"]
        input_limit.disabled = true
        input_limit.classList.add('disabled')
      else
        input_limit.disabled = false
        input_limit.classList.remove('disabled')

      if field.length > 0
        command += field + ':'
        command += tipo
        if limit.length > 0 and tipo in ["integer","string","text"]
          command += '{' + limit + "}"
        if limit.length > 0
          command += ':' + index

        command += " "
    h3 = document.querySelector('#query')
    h3.textContent = command
    command

  generateButtonClick: () ->
    command = this.createQuery()
    before_command = atom.config.get('visual-rails-generator.beforeCommand')
    @generator.terminal.run([before_command,command])


  destroy: ->
    @element.remove()

  getElement: ->
    @element
