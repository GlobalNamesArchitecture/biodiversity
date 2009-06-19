# encoding: UTF-8
module ScientificNameCanonical
  include Treetop::Runtime

  def root
    @root || :root
  end

  include ScientificNameClean

  include ScientificNameDirty

  def _nt_root
    start_index = index
    if node_cache[:root].has_key?(index)
      cached = node_cache[:root][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_multinomial_with_garbage
    if r1
      r0 = r1
    else
      r2 = _nt_uninomial_with_garbage
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:root][start_index] = r0

    return r0
  end

  module MultinomialWithGarbage0
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

    def space_hard
      elements[5]
    end

    def garbage
      elements[6]
    end
  end

  module MultinomialWithGarbage1
    def value
      a.value + " " + b.value + " " + c.value
    end
    
    def canonical
      a.canonical + " " + b.canonical + " " + c.canonical
    end
    
    def pos
      a.pos.merge(b.pos).merge(c.pos)
    end
    
    def details
      a.details.merge(b.details).merge(c.details)
    end
  end

  module MultinomialWithGarbage2
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def b
      elements[2]
    end

    def space_hard
      elements[3]
    end

    def garbage
      elements[4]
    end
  end

  module MultinomialWithGarbage3
    def value
      a.value + " " + b.value
    end
    
    def canonical
      a.canonical + " " + b.canonical
    end
    
    def pos
      a.pos.merge(b.pos)
    end
    
    def details
      a.details.merge(b.details)
    end
  end

  module MultinomialWithGarbage4
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def b
      elements[2]
    end

    def space_hard
      elements[3]
    end

    def garbage
      elements[4]
    end
  end

  module MultinomialWithGarbage5
    def value
      a.value + " " + b.value
    end
    
    def canonical
      a.canonical + " " + b.canonical
    end
    
    def pos
      a.pos.merge(b.pos)
    end
    
    def details
      a.details.merge(b.details)
    end
  end

  def _nt_multinomial_with_garbage
    start_index = index
    if node_cache[:multinomial_with_garbage].has_key?(index)
      cached = node_cache[:multinomial_with_garbage][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_genus
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_subgenus
        s1 << r4
        if r4
          r5 = _nt_space
          s1 << r5
          if r5
            r6 = _nt_species
            s1 << r6
            if r6
              r7 = _nt_space_hard
              s1 << r7
              if r7
                r8 = _nt_garbage
                s1 << r8
              end
            end
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(MultinomialWithGarbage0)
      r1.extend(MultinomialWithGarbage1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i9, s9 = index, []
      r10 = _nt_genus
      s9 << r10
      if r10
        r11 = _nt_space
        s9 << r11
        if r11
          r12 = _nt_subgenus
          s9 << r12
          if r12
            r13 = _nt_space_hard
            s9 << r13
            if r13
              r14 = _nt_garbage
              s9 << r14
            end
          end
        end
      end
      if s9.last
        r9 = instantiate_node(SyntaxNode,input, i9...index, s9)
        r9.extend(MultinomialWithGarbage2)
        r9.extend(MultinomialWithGarbage3)
      else
        self.index = i9
        r9 = nil
      end
      if r9
        r0 = r9
      else
        i15, s15 = index, []
        r16 = _nt_genus
        s15 << r16
        if r16
          r17 = _nt_space
          s15 << r17
          if r17
            r18 = _nt_species
            s15 << r18
            if r18
              r19 = _nt_space_hard
              s15 << r19
              if r19
                r20 = _nt_garbage
                s15 << r20
              end
            end
          end
        end
        if s15.last
          r15 = instantiate_node(SyntaxNode,input, i15...index, s15)
          r15.extend(MultinomialWithGarbage4)
          r15.extend(MultinomialWithGarbage5)
        else
          self.index = i15
          r15 = nil
        end
        if r15
          r0 = r15
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:multinomial_with_garbage][start_index] = r0

    return r0
  end

  module UninomialWithGarbage0
    def a
      elements[0]
    end

    def space_hard
      elements[1]
    end

    def b
      elements[2]
    end
  end

  module UninomialWithGarbage1
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
      {:uninomial => a.details[:uninomial]}
    end
  end

  def _nt_uninomial_with_garbage
    start_index = index
    if node_cache[:uninomial_with_garbage].has_key?(index)
      cached = node_cache[:uninomial_with_garbage][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_uninomial_epitheton
    s0 << r1
    if r1
      r2 = _nt_space_hard
      s0 << r2
      if r2
        r3 = _nt_garbage
        s0 << r3
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(UninomialWithGarbage0)
      r0.extend(UninomialWithGarbage1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:uninomial_with_garbage][start_index] = r0

    return r0
  end

end

class ScientificNameCanonicalParser < Treetop::Runtime::CompiledParser
  include ScientificNameCanonical
end
