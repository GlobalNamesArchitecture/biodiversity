# encoding: UTF-8
module ScientificNameDirty
  include Treetop::Runtime

  def root
    @root || :root
  end

  include ScientificNameClean

  def _nt_root
    start_index = index
    if node_cache[:root].has_key?(index)
      cached = node_cache[:root][index]
      @index = cached.interval.end if cached
      return cached
    end

    r0 = super

    node_cache[:root][start_index] = r0

    return r0
  end

  module ScientificName50
    def a
      elements[0]
    end

    def space_hard
      elements[1]
    end

    def garbage
      elements[2]
    end
  end

  module ScientificName51
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
      a.details
    end
  end

  def _nt_scientific_name_5
    start_index = index
    if node_cache[:scientific_name_5].has_key?(index)
      cached = node_cache[:scientific_name_5][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_scientific_name_4
    s1 << r2
    if r2
      r3 = _nt_space_hard
      s1 << r3
      if r3
        r4 = _nt_garbage
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(ScientificName50)
      r1.extend(ScientificName51)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = super
      if r5
        r0 = r5
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:scientific_name_5][start_index] = r0

    return r0
  end

  module Infraspecies0
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def epitheton_authorship_inconsistencies
      elements[2]
    end

    def space
      elements[3]
    end

    def b
      elements[4]
    end
  end

  module Infraspecies1
    def value
      a.value + " " + b.value
    end

    def canonical
      a.canonical
    end

    def pos
      a.pos.merge(b.pos)
    end

    def details
      {:infraspecies => a.details[:infraspecies].merge(b.details)}
    end
  end

  def _nt_infraspecies
    start_index = index
    if node_cache[:infraspecies].has_key?(index)
      cached = node_cache[:infraspecies][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_infraspecies_epitheton
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_epitheton_authorship_inconsistencies
        s1 << r4
        if r4
          r5 = _nt_space
          s1 << r5
          if r5
            r6 = _nt_authorship
            s1 << r6
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Infraspecies0)
      r1.extend(Infraspecies1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r7 = super
      if r7
        r0 = r7
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:infraspecies][start_index] = r0

    return r0
  end

  module Species0
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

  module Species1
    def value
      a.value + " " + b.value
    end
  
    def canonical
      a.canonical
    end
  
    def pos
      a.pos.merge(b.pos)
    end
  
    def details
      {:species => a.details[:species].merge(b.details)}
    end
  end

  def _nt_species
    start_index = index
    if node_cache[:species].has_key?(index)
      cached = node_cache[:species][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_species_epitheton
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_year
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Species0)
      r1.extend(Species1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = super
      if r5
        r0 = r5
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:species][start_index] = r0

    return r0
  end

  module RightParen0
    def space
      elements[1]
    end

  end

  def _nt_right_paren
    start_index = index
    if node_cache[:right_paren].has_key?(index)
      cached = node_cache[:right_paren][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if input.index(")", index) == index
      r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure(")")
      r2 = nil
    end
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        if input.index(")", index) == index
          r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure(")")
          r4 = nil
        end
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(RightParen0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = super
      if r5
        r0 = r5
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:right_paren][start_index] = r0

    return r0
  end

  module LeftParen0
    def space
      elements[1]
    end

  end

  def _nt_left_paren
    start_index = index
    if node_cache[:left_paren].has_key?(index)
      cached = node_cache[:left_paren][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if input.index("(", index) == index
      r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("(")
      r2 = nil
    end
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        if input.index("(", index) == index
          r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("(")
          r4 = nil
        end
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(LeftParen0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = super
      if r5
        r0 = r5
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:left_paren][start_index] = r0

    return r0
  end

  module Year0
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

  module Year1
    def value
      a.value + " " + b.value
    end
    
    def pos
      a.pos.merge(b.pos)
    end
    
    def details
      {:year => a.value, :approximate_year => b.value}
    end
  end

  module Year2
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def page_number
      elements[2]
    end
  end

  module Year3
    def value
      a.text_value
    end
    
    def pos
      {a.interval.begin => ['year', a.interval.end]}
    end
    
    def details
      {:year => value}
    end
  end

  def _nt_year
    start_index = index
    if node_cache[:year].has_key?(index)
      cached = node_cache[:year][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_year_number
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_approximate_year
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Year0)
      r1.extend(Year1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i5, s5 = index, []
      r6 = _nt_year_number
      s5 << r6
      if r6
        r7 = _nt_space
        s5 << r7
        if r7
          r8 = _nt_page_number
          s5 << r8
        end
      end
      if s5.last
        r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
        r5.extend(Year2)
        r5.extend(Year3)
      else
        self.index = i5
        r5 = nil
      end
      if r5
        r0 = r5
      else
        r9 = _nt_year_number_with_dot
        if r9
          r0 = r9
        else
          r10 = _nt_approximate_year
          if r10
            r0 = r10
          else
            r11 = _nt_double_year
            if r11
              r0 = r11
            else
              r12 = super
              if r12
                r0 = r12
              else
                self.index = i0
                r0 = nil
              end
            end
          end
        end
      end
    end

    node_cache[:year][start_index] = r0

    return r0
  end

  module ApproximateYear0
    def space
      elements[1]
    end

    def a
      elements[2]
    end

    def space
      elements[3]
    end

  end

  module ApproximateYear1
    def value
     "(" + a.text_value + ")"
    end
    
    def pos
      {a.interval.begin => ['year', a.interval.end]}
    end
    
    def details
      {:approximate_year => value}
    end
  end

  def _nt_approximate_year
    start_index = index
    if node_cache[:approximate_year].has_key?(index)
      cached = node_cache[:approximate_year][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("[", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("[")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        r3 = _nt_year_number
        s0 << r3
        if r3
          r4 = _nt_space
          s0 << r4
          if r4
            s5, i5 = [], index
            loop do
              if input.index("]", index) == index
                r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure("]")
                r6 = nil
              end
              if r6
                s5 << r6
              else
                break
              end
            end
            if s5.empty?
              self.index = i5
              r5 = nil
            else
              r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
            end
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(ApproximateYear0)
      r0.extend(ApproximateYear1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:approximate_year][start_index] = r0

    return r0
  end

  module DoubleYear0
    def year_number
      elements[0]
    end

  end

  module DoubleYear1
    def value
      text_value
    end
    
    def pos
      {interval.begin => ['year', interval.end]}
    end
    
    def details
      {:year => value}
    end
  end

  def _nt_double_year
    start_index = index
    if node_cache[:double_year].has_key?(index)
      cached = node_cache[:double_year][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_year_number
    s0 << r1
    if r1
      if input.index("-", index) == index
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("-")
        r2 = nil
      end
      s0 << r2
      if r2
        s3, i3 = [], index
        loop do
          if input.index(Regexp.new('[0-9]'), index) == index
            r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            r4 = nil
          end
          if r4
            s3 << r4
          else
            break
          end
        end
        if s3.empty?
          self.index = i3
          r3 = nil
        else
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
        end
        s0 << r3
        if r3
          if input.index(Regexp.new('[A-Za-z]'), index) == index
            r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            r6 = nil
          end
          if r6
            r5 = r6
          else
            r5 = instantiate_node(SyntaxNode,input, index...index)
          end
          s0 << r5
          if r5
            if input.index(Regexp.new('[\\?]'), index) == index
              r8 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              r8 = nil
            end
            if r8
              r7 = r8
            else
              r7 = instantiate_node(SyntaxNode,input, index...index)
            end
            s0 << r7
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(DoubleYear0)
      r0.extend(DoubleYear1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:double_year][start_index] = r0

    return r0
  end

  module YearNumberWithDot0
    def a
      elements[0]
    end

  end

  module YearNumberWithDot1
    def value
      a.text_value
    end

    def pos
      {interval.begin => ['year', interval.end]}
    end

    def details
      {:year => value}
    end
  end

  def _nt_year_number_with_dot
    start_index = index
    if node_cache[:year_number_with_dot].has_key?(index)
      cached = node_cache[:year_number_with_dot][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_year_number
    s0 << r1
    if r1
      if input.index(".", index) == index
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(".")
        r2 = nil
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(YearNumberWithDot0)
      r0.extend(YearNumberWithDot1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:year_number_with_dot][start_index] = r0

    return r0
  end

  module PageNumber0
    def space
      elements[1]
    end

  end

  module PageNumber1
    def value
    end
  end

  def _nt_page_number
    start_index = index
    if node_cache[:page_number].has_key?(index)
      cached = node_cache[:page_number][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(":", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure(":")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        s3, i3 = [], index
        loop do
          if input.index(Regexp.new('[\\d]'), index) == index
            r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            r4 = nil
          end
          if r4
            s3 << r4
          else
            break
          end
        end
        if s3.empty?
          self.index = i3
          r3 = nil
        else
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
        end
        s0 << r3
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(PageNumber0)
      r0.extend(PageNumber1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:page_number][start_index] = r0

    return r0
  end

  def _nt_epitheton_authorship_inconsistencies
    start_index = index
    if node_cache[:epitheton_authorship_inconsistencies].has_key?(index)
      cached = node_cache[:epitheton_authorship_inconsistencies][index]
      @index = cached.interval.end if cached
      return cached
    end

    if input.index("corrig.", index) == index
      r0 = instantiate_node(SyntaxNode,input, index...(index + 7))
      @index += 7
    else
      terminal_parse_failure("corrig.")
      r0 = nil
    end

    node_cache[:epitheton_authorship_inconsistencies][start_index] = r0

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
      if input.index(Regexp.new('[^ш]'), index) == index
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
    if s0.empty?
      self.index = i0
      r0 = nil
    else
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
    end

    node_cache[:garbage][start_index] = r0

    return r0
  end

end

class ScientificNameDirtyParser < Treetop::Runtime::CompiledParser
  include ScientificNameDirty
end
