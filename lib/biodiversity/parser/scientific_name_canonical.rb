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

    def b
      elements[2]
    end

    def space
      elements[3]
    end

    def c
      elements[4]
    end
  end

  module NamePartWithGarbage1
    def value 
      a.value + " " + b.value
    end
    def canonical
      a.canonical + " " + b.value
    end
    
    def pos
      a.pos.merge({b.interval.begin => ['subspecies', b.interval.end]})
    end
    
    def details
      a.details.merge({:subspecies => {:rank => 'n/a', :value => b.value}}).merge(:name_part_verbatim => a.text_value, :auth_part_verbatim => c.text_value)
    end
  end

  module NamePartWithGarbage2
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def b
      elements[2]
    end
  end

  module NamePartWithGarbage3
    def value 
      a.value
    end
    def canonical
      a.canonical
    end
    
    def pos
      a.pos
    end
    
    def details
      a.details.merge(:name_part_verbatim => a.text_value, :auth_part_verbatim => b.text_value)
    end
  end

  module NamePartWithGarbage4
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def b
      elements[2]
    end
  end

  module NamePartWithGarbage5
    def value 
      a.value
    end
    def canonical
      a.canonical
    end
    
    def pos
      a.pos
    end
    
    def details
      a.details.merge(:name_part_verbatim => a.text_value, :auth_part_verbatim => b.text_value)
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
        r4 = _nt_latin_word
        s1 << r4
        if r4
          r5 = _nt_space
          s1 << r5
          if r5
            s6, i6 = [], index
            loop do
              if input.index(Regexp.new('[^ш]'), index) == index
                r7 = instantiate_node(SyntaxNode,input, index...(index + 1))
                @index += 1
              else
                r7 = nil
              end
              if r7
                s6 << r7
              else
                break
              end
            end
            if s6.empty?
              self.index = i6
              r6 = nil
            else
              r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
            end
            s1 << r6
          end
        end
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
      i8, s8 = index, []
      r9 = _nt_species_name
      s8 << r9
      if r9
        r10 = _nt_space
        s8 << r10
        if r10
          s11, i11 = [], index
          loop do
            if input.index(Regexp.new('[^ш]'), index) == index
              r12 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              r12 = nil
            end
            if r12
              s11 << r12
            else
              break
            end
          end
          if s11.empty?
            self.index = i11
            r11 = nil
          else
            r11 = instantiate_node(SyntaxNode,input, i11...index, s11)
          end
          s8 << r11
        end
      end
      if s8.last
        r8 = instantiate_node(SyntaxNode,input, i8...index, s8)
        r8.extend(NamePartWithGarbage2)
        r8.extend(NamePartWithGarbage3)
      else
        self.index = i8
        r8 = nil
      end
      if r8
        r0 = r8
      else
        i13, s13 = index, []
        r14 = _nt_name_part
        s13 << r14
        if r14
          r15 = _nt_space
          s13 << r15
          if r15
            s16, i16 = [], index
            loop do
              if input.index(Regexp.new('[^ш]'), index) == index
                r17 = instantiate_node(SyntaxNode,input, index...(index + 1))
                @index += 1
              else
                r17 = nil
              end
              if r17
                s16 << r17
              else
                break
              end
            end
            if s16.empty?
              self.index = i16
              r16 = nil
            else
              r16 = instantiate_node(SyntaxNode,input, i16...index, s16)
            end
            s13 << r16
          end
        end
        if s13.last
          r13 = instantiate_node(SyntaxNode,input, i13...index, s13)
          r13.extend(NamePartWithGarbage4)
          r13.extend(NamePartWithGarbage5)
        else
          self.index = i13
          r13 = nil
        end
        if r13
          r0 = r13
        else
          self.index = i0
          r0 = nil
        end
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
