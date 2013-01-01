factory 'container', (mappings) ->
  container = new brancusi.Container
  for name, klass of mappings
      container.register_class name, klass
  container
