module ScientificNameDirty
  include Treetop::Runtime

  def root
    @root || :composite_scientific_name
  end

  include ScientificNameClean

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
      a.text_value + " " + b.text_value
    end
    def pos
      {a.interval.begin => ['year', a.interval.end]}.merge(b.pos)
    end
    def details
      {:ambiguous_year => value}
    end
  end

  module Year2
    def a
      elements[0]
    end

    def page_number
      elements[1]
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
    s2, i2 = [], index
    loop do
      if input.index(Regexp.new('[\\d]'), index) == index
        r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r3 = nil
      end
      if r3
        s2 << r3
      else
        break
      end
    end
    if s2.empty?
      self.index = i2
      r2 = nil
    else
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
    end
    s1 << r2
    if r2
      r4 = _nt_space
      s1 << r4
      if r4
        r5 = _nt_approximate_year
        s1 << r5
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
      i6, s6 = index, []
      s7, i7 = [], index
      loop do
        if input.index(Regexp.new('[\\d]'), index) == index
          r8 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          r8 = nil
        end
        if r8
          s7 << r8
        else
          break
        end
      end
      if s7.empty?
        self.index = i7
        r7 = nil
      else
        r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
      end
      s6 << r7
      if r7
        r9 = _nt_page_number
        s6 << r9
      end
      if s6.last
        r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
        r6.extend(Year2)
        r6.extend(Year3)
      else
        self.index = i6
        r6 = nil
      end
      if r6
        r0 = r6
      else
        r10 = _nt_double_year
        if r10
          r0 = r10
        else
          r11 = _nt_approximate_year
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

    node_cache[:year][start_index] = r0

    return r0
  end

  module ApproximateYear0
  end

  module ApproximateYear1
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

  module ApproximateYear2

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
        i3, s3 = index, []
        if input.index(Regexp.new('[\\d]'), index) == index
          r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          r4 = nil
        end
        s3 << r4
        if r4
          if input.index(Regexp.new('[\\d]'), index) == index
            r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            r5 = nil
          end
          s3 << r5
          if r5
            if input.index(Regexp.new('[\\d]'), index) == index
              r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              r6 = nil
            end
            s3 << r6
            if r6
              s7, i7 = [], index
              loop do
                if input.index(Regexp.new('[\\d\\?]'), index) == index
                  r8 = instantiate_node(SyntaxNode,input, index...(index + 1))
                  @index += 1
                else
                  r8 = nil
                end
                if r8
                  s7 << r8
                else
                  break
                end
              end
              if s7.empty?
                self.index = i7
                r7 = nil
              else
                r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
              end
              s3 << r7
            end
          end
        end
        if s3.last
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
          r3.extend(ApproximateYear0)
        else
          self.index = i3
          r3 = nil
        end
        s0 << r3
        if r3
          r9 = _nt_space
          s0 << r9
          if r9
            s10, i10 = [], index
            loop do
              if input.index("]", index) == index
                r11 = instantiate_node(SyntaxNode,input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure("]")
                r11 = nil
              end
              if r11
                s10 << r11
              else
                break
              end
            end
            if s10.empty?
              self.index = i10
              r10 = nil
            else
              r10 = instantiate_node(SyntaxNode,input, i10...index, s10)
            end
            s0 << r10
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(ApproximateYear1)
      r0.extend(ApproximateYear2)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:approximate_year][start_index] = r0

    return r0
  end

  module DoubleYear0
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
    if input.index(Regexp.new('[0-9]'), index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        if input.index(Regexp.new('[0-9A-Za-z\\?\\-]'), index) == index
          r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      if s2.empty?
        self.index = i2
        r2 = nil
      else
        r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      end
      s0 << r2
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

end

class ScientificNameDirtyParser < Treetop::Runtime::CompiledParser
  include ScientificNameDirty
end

