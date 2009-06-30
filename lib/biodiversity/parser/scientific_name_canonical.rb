# encoding: UTF-8
module ScientificNameCanonical
  include Treetop::Runtime

  def root
    @root || :root
  end

  include ScientificNameClean

  include ScientificNameDirty

  module Root0
    def hybrid
      false
    end

    def details
      [super]
    end
  end

  module Root1
    def hybrid
      false
    end
    
    def details
      [super]
    end
  end

  def _nt_root
    start_index = index
    if node_cache[:root].has_key?(index)
      cached = node_cache[:root][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_multinomial_with_garbage
    r1.extend(Root0)
    if r1
      r0 = r1
    else
      r2 = _nt_uninomial_with_garbage
      r2.extend(Root1)
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

    def garbage
      elements[5]
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

    def garbage
      elements[3]
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

    def garbage
      elements[3]
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
              r7 = _nt_garbage
              s1 << r7
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
      i8, s8 = index, []
      r9 = _nt_genus
      s8 << r9
      if r9
        r10 = _nt_space
        s8 << r10
        if r10
          r11 = _nt_subgenus
          s8 << r11
          if r11
            r12 = _nt_garbage
            s8 << r12
          end
        end
      end
      if s8.last
        r8 = instantiate_node(SyntaxNode,input, i8...index, s8)
        r8.extend(MultinomialWithGarbage2)
        r8.extend(MultinomialWithGarbage3)
      else
        self.index = i8
        r8 = nil
      end
      if r8
        r0 = r8
      else
        i13, s13 = index, []
        r14 = _nt_genus
        s13 << r14
        if r14
          r15 = _nt_space
          s13 << r15
          if r15
            r16 = _nt_species
            s13 << r16
            if r16
              r17 = _nt_garbage
              s13 << r17
            end
          end
        end
        if s13.last
          r13 = instantiate_node(SyntaxNode,input, i13...index, s13)
          r13.extend(MultinomialWithGarbage4)
          r13.extend(MultinomialWithGarbage5)
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

    node_cache[:multinomial_with_garbage][start_index] = r0

    return r0
  end

  module UninomialWithGarbage0
    def a
      elements[0]
    end

    def b
      elements[1]
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
      r2 = _nt_garbage
      s0 << r2
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

  module Garbage0
    def space
      elements[0]
    end

    def space
      elements[2]
    end

  end

  module Garbage1
    def space_hard
      elements[0]
    end

  end

  def _nt_garbage
    start_index = index
    if node_cache[:garbage].has_key?(index)
      cached = node_cache[:garbage][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_space
    s1 << r2
    if r2
      if input.index(Regexp.new('["\',.]'), index) == index
        r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r3 = nil
      end
      s1 << r3
      if r3
        r4 = _nt_space
        s1 << r4
        if r4
          s5, i5 = [], index
          loop do
            if input.index(Regexp.new('[^щ]'), index) == index
              r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              r6 = nil
            end
            if r6
              s5 << r6
            else
              break
            end
          end
          r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
          s1 << r5
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Garbage0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i7, s7 = index, []
      r8 = _nt_space_hard
      s7 << r8
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
        s7 << r9
      end
      if s7.last
        r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
        r7.extend(Garbage1)
      else
        self.index = i7
        r7 = nil
      end
      if r7
        r0 = r7
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:garbage][start_index] = r0

    return r0
  end

end

class ScientificNameCanonicalParser < Treetop::Runtime::CompiledParser
  include ScientificNameCanonical
end
