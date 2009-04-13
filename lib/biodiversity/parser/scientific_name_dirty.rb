module ScientificNameDirty
  include Treetop::Runtime

  def root
    @root || :composite_scientific_name
  end

  include ScientificName

  def _nt_composite_scientific_name
    start_index = index
    if node_cache[:composite_scientific_name].has_key?(index)
      cached = node_cache[:composite_scientific_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    r0 = super

    node_cache[:composite_scientific_name][start_index] = r0

    return r0
  end

end

class ScientificNameDirtyParser < Treetop::Runtime::CompiledParser
  include ScientificNameDirty
end
