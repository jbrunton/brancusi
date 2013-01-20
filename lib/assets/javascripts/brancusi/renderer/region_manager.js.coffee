namespace "Brancusi"

class Brancusi.RegionManager
  
  # Looks up and returns a region by name.
  #
  # @param region_name [String] the name of the region.
  # @return [Array] the jQuery array of matching elements.
  #
  find: (region_name) ->
    $("[data-region='#{region_name}']")
  

  # Returns the child regions in the given document element.
  # 
  # @param el [Element] the element to search within.
  # @return [Array] a jQuery array of matching elements.
  #
  children: (el) ->
    $(el).find("[data-region]")


  # Returns the name of the given region element.
  #
  # @param region [Element] the region.
  # @return [String] the name of the region.
  #
  region_name: (region) ->
    $(region).data("region")
    