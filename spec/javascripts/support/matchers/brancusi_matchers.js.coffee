beforeEach ->
  @addMatchers {
    
    toHaveDependency: (property, opts = {}) ->
      dependency = @actual?.dependencies?[property]
      return false unless dependency?
      
      if opts.type?
        type = _.first(dependency)
        return false unless type == opts.type
      
      true
      
  }