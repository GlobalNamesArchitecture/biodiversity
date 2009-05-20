# encoding: UTF-8
module ScientificNameCanonical
  include Treetop::Runtime

  def root
    @root || :composite_scientific_name
  end

  include ScientificNameClean

  include ScientificNameDirty

  def _nt_composite_scientific_name
    start_index = index
    if node_cache[:composite_scientific_name].has_key?(index)
      cached = node_cache[:composite_scientific_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    r0 = _nt_name_part_with_garbage

    node_cache[:composite_scientific_name][start_index] = r0

    return r0
  end

  module NamePartWithGarbage0
    def a
      elements[0]
    end

    def space
      elements[1]
    end

  end

  module NamePartWithGarbage1
    def value 
      a.value
    end
    def canonical
      a.canonical
    end
    def details
      a.details
    end
  end

  module NamePartWithGarbage2
    def a
      elements[0]
    end

    def space
      elements[1]
    end

  end

  module NamePartWithGarbage3
    def value 
      a.value
    end
    def canonical
      a.canonical
    end
    def details
      a.details
    end
  end

  def _nt_name_part_with_garbage
    start_index = index
    if node_cache[:name_part_with_garbage].has_key?(index)
      cached = node_cache[:name_part_with_garbage][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_species_name
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        s4, i4 = [], index
        loop do
          if input.index(Regexp.new('[^ш]'), index) == index
            r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            r5 = nil
          end
          if r5
            s4 << r5
          else
            break
          end
        end
        if s4.empty?
          self.index = i4
          r4 = nil
        else
          r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
        end
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(NamePartWithGarbage0)
      r1.extend(NamePartWithGarbage1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i6, s6 = index, []
      r7 = _nt_name_part
      s6 << r7
      if r7
        r8 = _nt_space
        s6 << r8
        if r8
          s9, i9 = [], index
          loop do
            if input.index(Regexp.new('[^ш]'), index) == index
              r10 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              r10 = nil
            end
            if r10
              s9 << r10
            else
              break
            end
          end
          if s9.empty?
            self.index = i9
            r9 = nil
          else
            r9 = instantiate_node(SyntaxNode,input, i9...index, s9)
          end
          s6 << r9
        end
      end
      if s6.last
        r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
        r6.extend(NamePartWithGarbage2)
        r6.extend(NamePartWithGarbage3)
      else
        self.index = i6
        r6 = nil
      end
      if r6
        r0 = r6
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:name_part_with_garbage][start_index] = r0

    return r0
  end

  def _nt_garbage
    start_index = index
    if node_cache[:garbage].has_key?(index)
      cached = node_cache[:garbage][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      if input.index(Regexp.new('[.]'), index) == index
        r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = instantiate_node(SyntaxNode,input, i0...index, s0)

    node_cache[:garbage][start_index] = r0

    return r0
  end

end

class ScientificNameCanonicalParser < Treetop::Runtime::CompiledParser
  include ScientificNameCanonical
end
