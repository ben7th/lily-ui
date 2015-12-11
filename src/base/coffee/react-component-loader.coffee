jQuery =>
  for dom in jQuery('[data-react-class]')
    component_name = dom.getAttribute('data-react-class')
    constructor = @[component_name] || eval.call(@, component_name)
    props = {a: 1}
    ReactDOM.render React.createElement(constructor, props), dom
