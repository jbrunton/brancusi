factory 'container', (mappings) ->
  container = new Brancusi.Container
  for name, klass of mappings
      container.register_class name, klass
  container
