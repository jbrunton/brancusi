namespace "brancusi"

class Brancusi.Renderer extends Brancusi.ApplicationModule
  
  @dependency region_manager: 'RegionManager'
  
  constructor: ->
    super('renderer')
    @default_bindings = {}
  
  # Renders a region with the given data/template bindings, then recursively renders any child regions.
  #
  # @param region [Element] the document region to render.
  # @param bindings [Object] an object specifying the binding mappings.
  #
  render_region: (region, bindings) ->
    region_name = @region_manager.region_name(region)
    binding = bindings?[region_name]
    
    template = binding?.template || region_name
    context = binding?.context
    
    @render_template(template, context, region)
    
    for child in @region_manager.children(region)
      @render_region($(child), bindings)
  
  
  # Renders a page with the given template and data model.
  #
  # @param template [String] the name of the template to render the 'content' region.
  # @param data [Object] the data model for the 'content' region.
  # @param bindings [Object] any further data bindings (e.g. for other regions).
  #
  render_page: (template, context, bindings = {}) ->
    bindings = _.defaults bindings, @default_bindings,
      content: { template: template, context: context }
    
    master_region = @region_manager.find('master')
    @render_region(master_region, bindings)
    