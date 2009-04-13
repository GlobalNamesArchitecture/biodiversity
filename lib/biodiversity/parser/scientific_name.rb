# encoding: UTF-8
module ScientificName
  include Treetop::Runtime

  def root
    @root || :composite_scientific_name
  end

  module CompositeScientificName0
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def hybrid_separator
      elements[2]
    end

    def space
      elements[3]
    end

    def b
      elements[4]
    end

    def space
      elements[5]
    end
  end

  module CompositeScientificName1
    def value
      a.value + " × " + b.value
    end
    def canonical
      a.canonical + " × " + b.canonical
    end
    def details
      {:hybrid => {:scientific_name1 => a.details, :scientific_name2 => b.details}}
    end
  end

  module CompositeScientificName2
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def hybrid_separator
      elements[2]
    end

    def space
      elements[3]
    end

  end

  module CompositeScientificName3
    def value
      a.value + " × ?"
    end
    
    def canonical
      a.canonical
    end
    
    def details
      {:hybrid => {:scientific_name1 => a.details, :scientific_name2 => "?"}}
    end
  end

  def _nt_composite_scientific_name
    start_index = index
    if node_cache[:composite_scientific_name].has_key?(index)
      cached = node_cache[:composite_scientific_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_scientific_name
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_hybrid_separator
        s1 << r4
        if r4
          r5 = _nt_space
          s1 << r5
          if r5
            r6 = _nt_scientific_name
            s1 << r6
            if r6
              r7 = _nt_space
              s1 << r7
            end
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(CompositeScientificName0)
      r1.extend(CompositeScientificName1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i8, s8 = index, []
      r9 = _nt_scientific_name
      s8 << r9
      if r9
        r10 = _nt_space
        s8 << r10
        if r10
          r11 = _nt_hybrid_separator
          s8 << r11
          if r11
            r12 = _nt_space
            s8 << r12
            if r12
              if input.index(Regexp.new('[\\?]'), index) == index
                r14 = instantiate_node(SyntaxNode,input, index...(index + 1))
                @index += 1
              else
                r14 = nil
              end
              if r14
                r13 = r14
              else
                r13 = instantiate_node(SyntaxNode,input, index...index)
              end
              s8 << r13
            end
          end
        end
      end
      if s8.last
        r8 = instantiate_node(SyntaxNode,input, i8...index, s8)
        r8.extend(CompositeScientificName2)
        r8.extend(CompositeScientificName3)
      else
        self.index = i8
        r8 = nil
      end
      if r8
        r0 = r8
      else
        r15 = _nt_scientific_name
        if r15
          r0 = r15
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:composite_scientific_name][start_index] = r0

    return r0
  end

  module ScientificName0
    def space
      elements[0]
    end

    def a
      elements[1]
    end

    def space
      elements[2]
    end

    def b
      elements[3]
    end

    def space
      elements[4]
    end

    def c
      elements[5]
    end

    def space
      elements[6]
    end
  end

  module ScientificName1
    def value
      a.value + " " + b.value + " " + c.value
    end
    def canonical
      a.canonical
    end
    def details
      a.details.merge(b.details).merge(c.details)
    end
  end

  module ScientificName2
    def space
      elements[0]
    end

    def a
      elements[1]
    end

    def space
      elements[2]
    end

    def b
      elements[3]
    end

    def space
      elements[4]
    end
  end

  module ScientificName3
    def value
      a.value + " " + b.value
    end
    def canonical
      a.canonical
    end
    def details
      a.details.merge(b.details)
    end
  end

  module ScientificName4
    def space
      elements[0]
    end

    def a
      elements[1]
    end

    def space
      elements[2]
    end

    def b
      elements[3]
    end

    def space
      elements[4]
    end
  end

  module ScientificName5
    def value
      a.value + " " + b.value
    end
    
    def canonical
      a.canonical
    end
    
    def details
      a.details.merge(b.details).merge({:is_valid => false})
    end
  end

  def _nt_scientific_name
    start_index = index
    if node_cache[:scientific_name].has_key?(index)
      cached = node_cache[:scientific_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_name_part_authors_mix
    if r1
      r0 = r1
    else
      i2, s2 = index, []
      r3 = _nt_space
      s2 << r3
      if r3
        r4 = _nt_name_part
        s2 << r4
        if r4
          r5 = _nt_space
          s2 << r5
          if r5
            r6 = _nt_authors_part
            s2 << r6
            if r6
              r7 = _nt_space
              s2 << r7
              if r7
                r8 = _nt_status_part
                s2 << r8
                if r8
                  r9 = _nt_space
                  s2 << r9
                end
              end
            end
          end
        end
      end
      if s2.last
        r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
        r2.extend(ScientificName0)
        r2.extend(ScientificName1)
      else
        self.index = i2
        r2 = nil
      end
      if r2
        r0 = r2
      else
        i10, s10 = index, []
        r11 = _nt_space
        s10 << r11
        if r11
          r12 = _nt_name_part
          s10 << r12
          if r12
            r13 = _nt_space
            s10 << r13
            if r13
              r14 = _nt_authors_part
              s10 << r14
              if r14
                r15 = _nt_space
                s10 << r15
              end
            end
          end
        end
        if s10.last
          r10 = instantiate_node(SyntaxNode,input, i10...index, s10)
          r10.extend(ScientificName2)
          r10.extend(ScientificName3)
        else
          self.index = i10
          r10 = nil
        end
        if r10
          r0 = r10
        else
          i16, s16 = index, []
          r17 = _nt_space
          s16 << r17
          if r17
            r18 = _nt_name_part
            s16 << r18
            if r18
              r19 = _nt_space
              s16 << r19
              if r19
                r20 = _nt_year
                s16 << r20
                if r20
                  r21 = _nt_space
                  s16 << r21
                end
              end
            end
          end
          if s16.last
            r16 = instantiate_node(SyntaxNode,input, i16...index, s16)
            r16.extend(ScientificName4)
            r16.extend(ScientificName5)
          else
            self.index = i16
            r16 = nil
          end
          if r16
            r0 = r16
          else
            r22 = _nt_name_part
            if r22
              r0 = r22
            else
              self.index = i0
              r0 = nil
            end
          end
        end
      end
    end

    node_cache[:scientific_name][start_index] = r0

    return r0
  end

  module StatusPart0
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

  module StatusPart1
    def value
      a.value + " " + b.value
    end
    def details
      {:status => value}
    end
  end

  def _nt_status_part
    start_index = index
    if node_cache[:status_part].has_key?(index)
      cached = node_cache[:status_part][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_status_word
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_status_part
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(StatusPart0)
      r1.extend(StatusPart1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = _nt_status_word
      if r5
        r0 = r5
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:status_part][start_index] = r0

    return r0
  end

  module StatusWord0
    def latin_word
      elements[0]
    end

  end

  module StatusWord1
    def value
      text_value.strip
    end
    def details
      {:status => value}
    end
  end

  def _nt_status_word
    start_index = index
    if node_cache[:status_word].has_key?(index)
      cached = node_cache[:status_word][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_latin_word
    s1 << r2
    if r2
      if input.index(Regexp.new('[\\.]'), index) == index
        r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r3 = nil
      end
      s1 << r3
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(StatusWord0)
      r1.extend(StatusWord1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r4 = _nt_latin_word
      if r4
        r0 = r4
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:status_word][start_index] = r0

    return r0
  end

  module NamePartAuthorsMix0
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

    def space
      elements[5]
    end

    def d
      elements[6]
    end
  end

  module NamePartAuthorsMix1
    def value
      a.value + " " + b.value + " " + c.value + " " + d.value
    end
    def canonical
      a.canonical + " " + c.canonical
    end
    def details
      a.details.merge(c.details).merge({:species_authors=>b.details, :subspecies_authors => d.details})
    end
  end

  module NamePartAuthorsMix2
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

  module NamePartAuthorsMix3
    def value 
      a.value + " " + b.value + " " + c.value
    end
    def canonical
      a.canonical + " " + c.canonical
    end
    def details
      a.details.merge(c.details).merge({:species_authors=>b.details})
    end
  end

  def _nt_name_part_authors_mix
    start_index = index
    if node_cache[:name_part_authors_mix].has_key?(index)
      cached = node_cache[:name_part_authors_mix][index]
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
        r4 = _nt_authors_part
        s1 << r4
        if r4
          r5 = _nt_space
          s1 << r5
          if r5
            r6 = _nt_subspecies_name
            s1 << r6
            if r6
              r7 = _nt_space
              s1 << r7
              if r7
                r8 = _nt_authors_part
                s1 << r8
              end
            end
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(NamePartAuthorsMix0)
      r1.extend(NamePartAuthorsMix1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i9, s9 = index, []
      r10 = _nt_species_name
      s9 << r10
      if r10
        r11 = _nt_space
        s9 << r11
        if r11
          r12 = _nt_authors_part
          s9 << r12
          if r12
            r13 = _nt_space
            s9 << r13
            if r13
              r14 = _nt_subspecies_name
              s9 << r14
            end
          end
        end
      end
      if s9.last
        r9 = instantiate_node(SyntaxNode,input, i9...index, s9)
        r9.extend(NamePartAuthorsMix2)
        r9.extend(NamePartAuthorsMix3)
      else
        self.index = i9
        r9 = nil
      end
      if r9
        r0 = r9
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:name_part_authors_mix][start_index] = r0

    return r0
  end

  module AuthorsPart0
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

  module AuthorsPart1
    def value 
      a.value + " " + b.value
    end
  
    def details
      a.details.merge(b.details)
    end
  end

  module AuthorsPart2
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def ex_sep
      elements[2]
    end

    def space
      elements[3]
    end

    def b
      elements[4]
    end
  end

  module AuthorsPart3
    def value 
      a.value + " ex " + b.value
    end
    
    def details
      {:revised_name_authors => {:revised_authors => a.details[:authors], :authors => b.details[:authors]}}
    end
  end

  module AuthorsPart4
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

  module AuthorsPart5
    def value
      a.value + " " + b.value
    end
    def details
      a.details.merge(b.details)
    end
  end

  def _nt_authors_part
    start_index = index
    if node_cache[:authors_part].has_key?(index)
      cached = node_cache[:authors_part][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_original_authors_revised_name
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_authors_revised_name
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(AuthorsPart0)
      r1.extend(AuthorsPart1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i5, s5 = index, []
      r6 = _nt_simple_authors_part
      s5 << r6
      if r6
        r7 = _nt_space
        s5 << r7
        if r7
          r8 = _nt_ex_sep
          s5 << r8
          if r8
            r9 = _nt_space
            s5 << r9
            if r9
              r10 = _nt_simple_authors_part
              s5 << r10
            end
          end
        end
      end
      if s5.last
        r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
        r5.extend(AuthorsPart2)
        r5.extend(AuthorsPart3)
      else
        self.index = i5
        r5 = nil
      end
      if r5
        r0 = r5
      else
        i11, s11 = index, []
        r12 = _nt_original_authors_revised_name
        s11 << r12
        if r12
          r13 = _nt_space
          s11 << r13
          if r13
            r14 = _nt_authors_names_full
            s11 << r14
          end
        end
        if s11.last
          r11 = instantiate_node(SyntaxNode,input, i11...index, s11)
          r11.extend(AuthorsPart4)
          r11.extend(AuthorsPart5)
        else
          self.index = i11
          r11 = nil
        end
        if r11
          r0 = r11
        else
          r15 = _nt_authors_revised_name
          if r15
            r0 = r15
          else
            r16 = _nt_original_authors_revised_name
            if r16
              r0 = r16
            else
              r17 = _nt_simple_authors_part
              if r17
                r0 = r17
              else
                self.index = i0
                r0 = nil
              end
            end
          end
        end
      end
    end

    node_cache[:authors_part][start_index] = r0

    return r0
  end

  module SimpleAuthorsPart0
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

  module SimpleAuthorsPart1
    def value
      a.value + " " + b.value
    end
    def details
      a.details.merge(b.details)
    end
  end

  def _nt_simple_authors_part
    start_index = index
    if node_cache[:simple_authors_part].has_key?(index)
      cached = node_cache[:simple_authors_part][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_original_authors_names_full
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_authors_names_full
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(SimpleAuthorsPart0)
      r1.extend(SimpleAuthorsPart1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = _nt_original_authors_names_full
      if r5
        r0 = r5
      else
        r6 = _nt_authors_names_full
        if r6
          r0 = r6
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:simple_authors_part][start_index] = r0

    return r0
  end

  module OriginalAuthorsNamesFull0
    def space
      elements[1]
    end

    def a
      elements[2]
    end

    def space
      elements[3]
    end

    def space
      elements[5]
    end

    def space
      elements[7]
    end

    def b
      elements[8]
    end
  end

  module OriginalAuthorsNamesFull1
    def value
      "(" + a.value + " " + b.value + ")"
    end
    def details
      {:orig_authors => a.details[:authors], :year => b.details[:year]}
    end
  end

  module OriginalAuthorsNamesFull2
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

  module OriginalAuthorsNamesFull3
    def value
      "(" + a.value + ")"
    end
    def details
      {:orig_authors => a.details[:authors]}
    end
  end

  def _nt_original_authors_names_full
    start_index = index
    if node_cache[:original_authors_names_full].has_key?(index)
      cached = node_cache[:original_authors_names_full][index]
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
        r4 = _nt_authors_names
        s1 << r4
        if r4
          r5 = _nt_space
          s1 << r5
          if r5
            if input.index(")", index) == index
              r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(")")
              r6 = nil
            end
            s1 << r6
            if r6
              r7 = _nt_space
              s1 << r7
              if r7
                if input.index(Regexp.new('[,]'), index) == index
                  r9 = instantiate_node(SyntaxNode,input, index...(index + 1))
                  @index += 1
                else
                  r9 = nil
                end
                if r9
                  r8 = r9
                else
                  r8 = instantiate_node(SyntaxNode,input, index...index)
                end
                s1 << r8
                if r8
                  r10 = _nt_space
                  s1 << r10
                  if r10
                    r11 = _nt_year
                    s1 << r11
                  end
                end
              end
            end
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(OriginalAuthorsNamesFull0)
      r1.extend(OriginalAuthorsNamesFull1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i12, s12 = index, []
      if input.index("(", index) == index
        r13 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("(")
        r13 = nil
      end
      s12 << r13
      if r13
        r14 = _nt_space
        s12 << r14
        if r14
          r15 = _nt_authors_names_full
          s12 << r15
          if r15
            r16 = _nt_space
            s12 << r16
            if r16
              if input.index(")", index) == index
                r17 = instantiate_node(SyntaxNode,input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure(")")
                r17 = nil
              end
              s12 << r17
            end
          end
        end
      end
      if s12.last
        r12 = instantiate_node(SyntaxNode,input, i12...index, s12)
        r12.extend(OriginalAuthorsNamesFull2)
        r12.extend(OriginalAuthorsNamesFull3)
      else
        self.index = i12
        r12 = nil
      end
      if r12
        r0 = r12
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:original_authors_names_full][start_index] = r0

    return r0
  end

  module OriginalAuthorsRevisedName0
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

  module OriginalAuthorsRevisedName1
    def value
      "(" + a.value + ")"
    end
    
    def details
      {:original_revised_name_authors => a.details[:revised_name_authors]}
    end
  end

  def _nt_original_authors_revised_name
    start_index = index
    if node_cache[:original_authors_revised_name].has_key?(index)
      cached = node_cache[:original_authors_revised_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("(", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("(")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        r3 = _nt_authors_revised_name
        s0 << r3
        if r3
          r4 = _nt_space
          s0 << r4
          if r4
            if input.index(")", index) == index
              r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(")")
              r5 = nil
            end
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(OriginalAuthorsRevisedName0)
      r0.extend(OriginalAuthorsRevisedName1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:original_authors_revised_name][start_index] = r0

    return r0
  end

  module AuthorsRevisedName0
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def ex_sep
      elements[2]
    end

    def space
      elements[3]
    end

    def b
      elements[4]
    end
  end

  module AuthorsRevisedName1
    def value
      a.value + " ex " + b.value
    end
    def details
      {:revised_name_authors =>{:revised_authors => a.details[:authors], :authors => b.details[:authors]}}
    end
  end

  def _nt_authors_revised_name
    start_index = index
    if node_cache[:authors_revised_name].has_key?(index)
      cached = node_cache[:authors_revised_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_authors_names_full
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        r3 = _nt_ex_sep
        s0 << r3
        if r3
          r4 = _nt_space
          s0 << r4
          if r4
            r5 = _nt_authors_names_full
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(AuthorsRevisedName0)
      r0.extend(AuthorsRevisedName1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:authors_revised_name][start_index] = r0

    return r0
  end

  module AuthorsNamesFull0
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def space
      elements[3]
    end

    def b
      elements[4]
    end
  end

  module AuthorsNamesFull1
    def value 
      a.value + " " + b.value
    end
    def details
      {:authors => {:names => a.details[:authors][:names]}.merge(b.details)}
    end
  end

  def _nt_authors_names_full
    start_index = index
    if node_cache[:authors_names_full].has_key?(index)
      cached = node_cache[:authors_names_full][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_authors_names
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        if input.index(Regexp.new('[,]'), index) == index
          r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          r5 = nil
        end
        if r5
          r4 = r5
        else
          r4 = instantiate_node(SyntaxNode,input, index...index)
        end
        s1 << r4
        if r4
          r6 = _nt_space
          s1 << r6
          if r6
            r7 = _nt_year
            s1 << r7
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(AuthorsNamesFull0)
      r1.extend(AuthorsNamesFull1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r8 = _nt_authors_names
      if r8
        r0 = r8
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:authors_names_full][start_index] = r0

    return r0
  end

  def _nt_ex_sep
    start_index = index
    if node_cache[:ex_sep].has_key?(index)
      cached = node_cache[:ex_sep][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index("ex", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 2))
      @index += 2
    else
      terminal_parse_failure("ex")
      r1 = nil
    end
    if r1
      r0 = r1
    else
      if input.index("in", index) == index
        r2 = instantiate_node(SyntaxNode,input, index...(index + 2))
        @index += 2
      else
        terminal_parse_failure("in")
        r2 = nil
      end
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:ex_sep][start_index] = r0

    return r0
  end

  module AuthorsNames0
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def sep
      elements[2]
    end

    def space
      elements[3]
    end

    def b
      elements[4]
    end
  end

  module AuthorsNames1
    def value
      sep.apply(a,b)
    end
    
    def details
      sep.details(a,b)
    end
  end

  def _nt_authors_names
    start_index = index
    if node_cache[:authors_names].has_key?(index)
      cached = node_cache[:authors_names][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_author_name
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_author_name_separator
        s1 << r4
        if r4
          r5 = _nt_space
          s1 << r5
          if r5
            r6 = _nt_authors_names
            s1 << r6
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(AuthorsNames0)
      r1.extend(AuthorsNames1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r7 = _nt_author_name
      if r7
        r0 = r7
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:authors_names][start_index] = r0

    return r0
  end

  module AuthorNameSeparator0
    def apply(a,b)
      sep = text_value.strip
      sep = " et" if ["&","and","et"].include? sep
      a.value + sep + " " + b.value
    end

    def details(a,b)
      {:authors => {:names => a.details[:authors][:names] + b.details[:authors][:names]}}
    end
  end

  def _nt_author_name_separator
    start_index = index
    if node_cache[:author_name_separator].has_key?(index)
      cached = node_cache[:author_name_separator][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index("&", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("&")
      r1 = nil
    end
    if r1
      r0 = r1
      r0.extend(AuthorNameSeparator0)
    else
      if input.index(",", index) == index
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(",")
        r2 = nil
      end
      if r2
        r0 = r2
        r0.extend(AuthorNameSeparator0)
      else
        if input.index("and", index) == index
          r3 = instantiate_node(SyntaxNode,input, index...(index + 3))
          @index += 3
        else
          terminal_parse_failure("and")
          r3 = nil
        end
        if r3
          r0 = r3
          r0.extend(AuthorNameSeparator0)
        else
          if input.index("et", index) == index
            r4 = instantiate_node(SyntaxNode,input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure("et")
            r4 = nil
          end
          if r4
            r0 = r4
            r0.extend(AuthorNameSeparator0)
          else
            self.index = i0
            r0 = nil
          end
        end
      end
    end

    node_cache[:author_name_separator][start_index] = r0

    return r0
  end

  module AuthorName0
    def space
      elements[0]
    end

    def a
      elements[1]
    end

    def space
      elements[2]
    end

    def b
      elements[3]
    end

    def space
      elements[4]
    end
  end

  module AuthorName1
    def value
      a.value + " " + b.value
    end

    def details
      {:authors => {:names => [value]}}
    end
  end

  def _nt_author_name
    start_index = index
    if node_cache[:author_name].has_key?(index)
      cached = node_cache[:author_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_space
    s1 << r2
    if r2
      r3 = _nt_author_word
      s1 << r3
      if r3
        r4 = _nt_space
        s1 << r4
        if r4
          r5 = _nt_author_name
          s1 << r5
          if r5
            r6 = _nt_space
            s1 << r6
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(AuthorName0)
      r1.extend(AuthorName1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r7 = _nt_author_word
      if r7
        r0 = r7
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:author_name][start_index] = r0

    return r0
  end

  module AuthorWord0
    def value
      text_value.strip
    end
    def details
      {:authors => {:names => [value]}}
    end
  end

  module AuthorWord1
  end

  module AuthorWord2
    def value
      text_value.gsub(/\s+/, " ").strip
    end
    def details
      {:authors => {:names => [value]}}
    end
  end

  def _nt_author_word
    start_index = index
    if node_cache[:author_word].has_key?(index)
      cached = node_cache[:author_word][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index("A S. Xu", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 7))
      @index += 7
    else
      terminal_parse_failure("A S. Xu")
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i2 = index
      if input.index("anon.", index) == index
        r3 = instantiate_node(SyntaxNode,input, index...(index + 5))
        @index += 5
      else
        terminal_parse_failure("anon.")
        r3 = nil
      end
      if r3
        r2 = r3
        r2.extend(AuthorWord0)
      else
        if input.index("f.", index) == index
          r4 = instantiate_node(SyntaxNode,input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure("f.")
          r4 = nil
        end
        if r4
          r2 = r4
          r2.extend(AuthorWord0)
        else
          if input.index("bis", index) == index
            r5 = instantiate_node(SyntaxNode,input, index...(index + 3))
            @index += 3
          else
            terminal_parse_failure("bis")
            r5 = nil
          end
          if r5
            r2 = r5
            r2.extend(AuthorWord0)
          else
            if input.index("arg.", index) == index
              r6 = instantiate_node(SyntaxNode,input, index...(index + 4))
              @index += 4
            else
              terminal_parse_failure("arg.")
              r6 = nil
            end
            if r6
              r2 = r6
              r2.extend(AuthorWord0)
            else
              if input.index("da", index) == index
                r7 = instantiate_node(SyntaxNode,input, index...(index + 2))
                @index += 2
              else
                terminal_parse_failure("da")
                r7 = nil
              end
              if r7
                r2 = r7
                r2.extend(AuthorWord0)
              else
                if input.index("der", index) == index
                  r8 = instantiate_node(SyntaxNode,input, index...(index + 3))
                  @index += 3
                else
                  terminal_parse_failure("der")
                  r8 = nil
                end
                if r8
                  r2 = r8
                  r2.extend(AuthorWord0)
                else
                  if input.index("den", index) == index
                    r9 = instantiate_node(SyntaxNode,input, index...(index + 3))
                    @index += 3
                  else
                    terminal_parse_failure("den")
                    r9 = nil
                  end
                  if r9
                    r2 = r9
                    r2.extend(AuthorWord0)
                  else
                    if input.index("de", index) == index
                      r10 = instantiate_node(SyntaxNode,input, index...(index + 2))
                      @index += 2
                    else
                      terminal_parse_failure("de")
                      r10 = nil
                    end
                    if r10
                      r2 = r10
                      r2.extend(AuthorWord0)
                    else
                      if input.index("du", index) == index
                        r11 = instantiate_node(SyntaxNode,input, index...(index + 2))
                        @index += 2
                      else
                        terminal_parse_failure("du")
                        r11 = nil
                      end
                      if r11
                        r2 = r11
                        r2.extend(AuthorWord0)
                      else
                        if input.index("la", index) == index
                          r12 = instantiate_node(SyntaxNode,input, index...(index + 2))
                          @index += 2
                        else
                          terminal_parse_failure("la")
                          r12 = nil
                        end
                        if r12
                          r2 = r12
                          r2.extend(AuthorWord0)
                        else
                          if input.index("ter", index) == index
                            r13 = instantiate_node(SyntaxNode,input, index...(index + 3))
                            @index += 3
                          else
                            terminal_parse_failure("ter")
                            r13 = nil
                          end
                          if r13
                            r2 = r13
                            r2.extend(AuthorWord0)
                          else
                            if input.index("van", index) == index
                              r14 = instantiate_node(SyntaxNode,input, index...(index + 3))
                              @index += 3
                            else
                              terminal_parse_failure("van")
                              r14 = nil
                            end
                            if r14
                              r2 = r14
                              r2.extend(AuthorWord0)
                            else
                              if input.index("et al.\{\?\}", index) == index
                                r15 = instantiate_node(SyntaxNode,input, index...(index + 9))
                                @index += 9
                              else
                                terminal_parse_failure("et al.\{\?\}")
                                r15 = nil
                              end
                              if r15
                                r2 = r15
                                r2.extend(AuthorWord0)
                              else
                                if input.index("et al.", index) == index
                                  r16 = instantiate_node(SyntaxNode,input, index...(index + 6))
                                  @index += 6
                                else
                                  terminal_parse_failure("et al.")
                                  r16 = nil
                                end
                                if r16
                                  r2 = r16
                                  r2.extend(AuthorWord0)
                                else
                                  self.index = i2
                                  r2 = nil
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
      if r2
        r0 = r2
      else
        i17, s17 = index, []
        i18 = index
        if input.index("Å", index) == index
          r19 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("Å")
          r19 = nil
        end
        if r19
          r18 = r19
        else
          if input.index("Ö", index) == index
            r20 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("Ö")
            r20 = nil
          end
          if r20
            r18 = r20
          else
            if input.index("Á", index) == index
              r21 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure("Á")
              r21 = nil
            end
            if r21
              r18 = r21
            else
              if input.index("Ø", index) == index
                r22 = instantiate_node(SyntaxNode,input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure("Ø")
                r22 = nil
              end
              if r22
                r18 = r22
              else
                if input.index("Ô", index) == index
                  r23 = instantiate_node(SyntaxNode,input, index...(index + 1))
                  @index += 1
                else
                  terminal_parse_failure("Ô")
                  r23 = nil
                end
                if r23
                  r18 = r23
                else
                  if input.index("Š", index) == index
                    r24 = instantiate_node(SyntaxNode,input, index...(index + 1))
                    @index += 1
                  else
                    terminal_parse_failure("Š")
                    r24 = nil
                  end
                  if r24
                    r18 = r24
                  else
                    if input.index("Ś", index) == index
                      r25 = instantiate_node(SyntaxNode,input, index...(index + 1))
                      @index += 1
                    else
                      terminal_parse_failure("Ś")
                      r25 = nil
                    end
                    if r25
                      r18 = r25
                    else
                      if input.index("Č", index) == index
                        r26 = instantiate_node(SyntaxNode,input, index...(index + 1))
                        @index += 1
                      else
                        terminal_parse_failure("Č")
                        r26 = nil
                      end
                      if r26
                        r18 = r26
                      else
                        if input.index("Ķ", index) == index
                          r27 = instantiate_node(SyntaxNode,input, index...(index + 1))
                          @index += 1
                        else
                          terminal_parse_failure("Ķ")
                          r27 = nil
                        end
                        if r27
                          r18 = r27
                        else
                          if input.index("Ł", index) == index
                            r28 = instantiate_node(SyntaxNode,input, index...(index + 1))
                            @index += 1
                          else
                            terminal_parse_failure("Ł")
                            r28 = nil
                          end
                          if r28
                            r18 = r28
                          else
                            if input.index("É", index) == index
                              r29 = instantiate_node(SyntaxNode,input, index...(index + 1))
                              @index += 1
                            else
                              terminal_parse_failure("É")
                              r29 = nil
                            end
                            if r29
                              r18 = r29
                            else
                              if input.index("Ž", index) == index
                                r30 = instantiate_node(SyntaxNode,input, index...(index + 1))
                                @index += 1
                              else
                                terminal_parse_failure("Ž")
                                r30 = nil
                              end
                              if r30
                                r18 = r30
                              else
                                if input.index(Regexp.new('[A-Z]'), index) == index
                                  r31 = instantiate_node(SyntaxNode,input, index...(index + 1))
                                  @index += 1
                                else
                                  r31 = nil
                                end
                                if r31
                                  r18 = r31
                                else
                                  self.index = i18
                                  r18 = nil
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
        s17 << r18
        if r18
          s32, i32 = [], index
          loop do
            if input.index(Regexp.new('[^0-9()\\s&,]'), index) == index
              r33 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              r33 = nil
            end
            if r33
              s32 << r33
            else
              break
            end
          end
          if s32.empty?
            self.index = i32
            r32 = nil
          else
            r32 = instantiate_node(SyntaxNode,input, i32...index, s32)
          end
          s17 << r32
        end
        if s17.last
          r17 = instantiate_node(SyntaxNode,input, i17...index, s17)
          r17.extend(AuthorWord1)
          r17.extend(AuthorWord2)
        else
          self.index = i17
          r17 = nil
        end
        if r17
          r0 = r17
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:author_word][start_index] = r0

    return r0
  end

  module NamePart0
    def space
      elements[0]
    end

    def a
      elements[1]
    end

    def space
      elements[2]
    end

    def b
      elements[3]
    end

    def space_hard
      elements[4]
    end

    def c
      elements[5]
    end
  end

  module NamePart1
    def value
      a.value + " " + b.value + " " + c.value
    end
    def canonical
      a.canonical
    end
    def details
      a.details.merge(b.details).merge(c.details)
    end
  end

  module NamePart2
    def space
      elements[0]
    end

    def a
      elements[1]
    end

    def space
      elements[2]
    end

    def b
      elements[3]
    end
  end

  module NamePart3
    def value
      a.value + b.value
    end
    def canonical
      a.canonical + b.canonical
    end
    
    def details
      a.details.merge(b.details)
    end
  end

  module NamePart4
    def space
      elements[0]
    end

    def a
      elements[1]
    end

    def space
      elements[2]
    end

    def b
      elements[3]
    end

  end

  module NamePart5
    def value
      a.value + " " + b.value
    end
    
    def canonical
      value
    end
    
    def details
      a.details.merge({:subspecies => {:rank => "n/a", :value =>b.value}})
    end
  end

  def _nt_name_part
    start_index = index
    if node_cache[:name_part].has_key?(index)
      cached = node_cache[:name_part][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_space
    s1 << r2
    if r2
      r3 = _nt_species_name
      s1 << r3
      if r3
        r4 = _nt_space
        s1 << r4
        if r4
          r5 = _nt_rank
          s1 << r5
          if r5
            r6 = _nt_space_hard
            s1 << r6
            if r6
              r7 = _nt_editorials_full
              s1 << r7
            end
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(NamePart0)
      r1.extend(NamePart1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i8, s8 = index, []
      r9 = _nt_space
      s8 << r9
      if r9
        r10 = _nt_species_name
        s8 << r10
        if r10
          r11 = _nt_space
          s8 << r11
          if r11
            r12 = _nt_subspecies_names
            s8 << r12
          end
        end
      end
      if s8.last
        r8 = instantiate_node(SyntaxNode,input, i8...index, s8)
        r8.extend(NamePart2)
        r8.extend(NamePart3)
      else
        self.index = i8
        r8 = nil
      end
      if r8
        r0 = r8
      else
        i13, s13 = index, []
        r14 = _nt_space
        s13 << r14
        if r14
          r15 = _nt_species_name
          s13 << r15
          if r15
            r16 = _nt_space
            s13 << r16
            if r16
              r17 = _nt_latin_word
              s13 << r17
              if r17
                i18 = index
                if input.index(Regexp.new('[\\.]'), index) == index
                  r19 = instantiate_node(SyntaxNode,input, index...(index + 1))
                  @index += 1
                else
                  r19 = nil
                end
                if r19
                  r18 = nil
                else
                  self.index = i18
                  r18 = instantiate_node(SyntaxNode,input, index...index)
                end
                s13 << r18
              end
            end
          end
        end
        if s13.last
          r13 = instantiate_node(SyntaxNode,input, i13...index, s13)
          r13.extend(NamePart4)
          r13.extend(NamePart5)
        else
          self.index = i13
          r13 = nil
        end
        if r13
          r0 = r13
        else
          r20 = _nt_species_name
          if r20
            r0 = r20
          else
            r21 = _nt_cap_latin_word
            if r21
              r0 = r21
            else
              self.index = i0
              r0 = nil
            end
          end
        end
      end
    end

    node_cache[:name_part][start_index] = r0

    return r0
  end

  module SubspeciesNames0
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

  module SubspeciesNames1
    def value
      a.value + b.value
    end
    
    def canonical
      a.canonical + b.canonical
    end
    
    def details
      c = a.details[:subspecies] + b.details_subspecies
      a.details.merge({:subspecies => c, :is_valid => false})
    end
  end

  def _nt_subspecies_names
    start_index = index
    if node_cache[:subspecies_names].has_key?(index)
      cached = node_cache[:subspecies_names][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_subspecies_name
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_subspecies_names
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(SubspeciesNames0)
      r1.extend(SubspeciesNames1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = _nt_subspecies_name
      if r5
        r0 = r5
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:subspecies_names][start_index] = r0

    return r0
  end

  module SubspeciesName0
    def sel
      elements[0]
    end

    def space_hard
      elements[1]
    end

    def a
      elements[2]
    end
  end

  module SubspeciesName1
    def value 
      sel.apply(a)
    end
    def canonical
      sel.canonical(a)
    end
    def details
      sel.details(a)
    end
    def details_subspecies
      details[:subspecies]
    end
  end

  def _nt_subspecies_name
    start_index = index
    if node_cache[:subspecies_name].has_key?(index)
      cached = node_cache[:subspecies_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_rank
    s0 << r1
    if r1
      r2 = _nt_space_hard
      s0 << r2
      if r2
        r3 = _nt_latin_word
        s0 << r3
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(SubspeciesName0)
      r0.extend(SubspeciesName1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:subspecies_name][start_index] = r0

    return r0
  end

  module EditorialsFull0
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

  module EditorialsFull1
    def value
      "(" + a.value + ")"
    end
    def details
      {:editorial_markup => value, :is_valid => false}
    end
  end

  def _nt_editorials_full
    start_index = index
    if node_cache[:editorials_full].has_key?(index)
      cached = node_cache[:editorials_full][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("(", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("(")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        r3 = _nt_editorials
        s0 << r3
        if r3
          r4 = _nt_space
          s0 << r4
          if r4
            if input.index(")", index) == index
              r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(")")
              r5 = nil
            end
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(EditorialsFull0)
      r0.extend(EditorialsFull1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:editorials_full][start_index] = r0

    return r0
  end

  module Editorials0
    def space
      elements[0]
    end

    def a
      elements[1]
    end

    def space
      elements[2]
    end

    def space
      elements[4]
    end

    def b
      elements[5]
    end
  end

  module Editorials1
    def value
      a.value + b.value
    end
    def details
      {:editorial_markup => value, :is_valid => false}
    end
  end

  def _nt_editorials
    start_index = index
    if node_cache[:editorials].has_key?(index)
      cached = node_cache[:editorials][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_space
    s1 << r2
    if r2
      r3 = _nt_rank
      s1 << r3
      if r3
        r4 = _nt_space
        s1 << r4
        if r4
          if input.index(Regexp.new('[&]'), index) == index
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
          s1 << r5
          if r5
            r7 = _nt_space
            s1 << r7
            if r7
              r8 = _nt_editorials
              s1 << r8
            end
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Editorials0)
      r1.extend(Editorials1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r9 = _nt_rank
      if r9
        r0 = r9
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:editorials][start_index] = r0

    return r0
  end

  module Rank0
    def value
      text_value.strip
    end
    def apply(a)
      " " + text_value + " " + a.value
    end
    def canonical(a)
      " " + a.value
    end
    def details(a = nil)
      {:subspecies => [{:rank => text_value, :value => (a.value rescue nil)}]}
    end
  end

  def _nt_rank
    start_index = index
    if node_cache[:rank].has_key?(index)
      cached = node_cache[:rank][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index("f.sp.", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 5))
      @index += 5
    else
      terminal_parse_failure("f.sp.")
      r1 = nil
    end
    if r1
      r0 = r1
      r0.extend(Rank0)
    else
      if input.index("f.", index) == index
        r2 = instantiate_node(SyntaxNode,input, index...(index + 2))
        @index += 2
      else
        terminal_parse_failure("f.")
        r2 = nil
      end
      if r2
        r0 = r2
        r0.extend(Rank0)
      else
        if input.index("B", index) == index
          r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("B")
          r3 = nil
        end
        if r3
          r0 = r3
          r0.extend(Rank0)
        else
          if input.index("ssp.", index) == index
            r4 = instantiate_node(SyntaxNode,input, index...(index + 4))
            @index += 4
          else
            terminal_parse_failure("ssp.")
            r4 = nil
          end
          if r4
            r0 = r4
            r0.extend(Rank0)
          else
            if input.index("mut.", index) == index
              r5 = instantiate_node(SyntaxNode,input, index...(index + 4))
              @index += 4
            else
              terminal_parse_failure("mut.")
              r5 = nil
            end
            if r5
              r0 = r5
              r0.extend(Rank0)
            else
              if input.index("pseudovar.", index) == index
                r6 = instantiate_node(SyntaxNode,input, index...(index + 10))
                @index += 10
              else
                terminal_parse_failure("pseudovar.")
                r6 = nil
              end
              if r6
                r0 = r6
                r0.extend(Rank0)
              else
                if input.index("sect.", index) == index
                  r7 = instantiate_node(SyntaxNode,input, index...(index + 5))
                  @index += 5
                else
                  terminal_parse_failure("sect.")
                  r7 = nil
                end
                if r7
                  r0 = r7
                  r0.extend(Rank0)
                else
                  if input.index("ser.", index) == index
                    r8 = instantiate_node(SyntaxNode,input, index...(index + 4))
                    @index += 4
                  else
                    terminal_parse_failure("ser.")
                    r8 = nil
                  end
                  if r8
                    r0 = r8
                    r0.extend(Rank0)
                  else
                    if input.index("var.", index) == index
                      r9 = instantiate_node(SyntaxNode,input, index...(index + 4))
                      @index += 4
                    else
                      terminal_parse_failure("var.")
                      r9 = nil
                    end
                    if r9
                      r0 = r9
                      r0.extend(Rank0)
                    else
                      if input.index("subvar.", index) == index
                        r10 = instantiate_node(SyntaxNode,input, index...(index + 7))
                        @index += 7
                      else
                        terminal_parse_failure("subvar.")
                        r10 = nil
                      end
                      if r10
                        r0 = r10
                        r0.extend(Rank0)
                      else
                        if input.index("[var.]", index) == index
                          r11 = instantiate_node(SyntaxNode,input, index...(index + 6))
                          @index += 6
                        else
                          terminal_parse_failure("[var.]")
                          r11 = nil
                        end
                        if r11
                          r0 = r11
                          r0.extend(Rank0)
                        else
                          if input.index("subsp.", index) == index
                            r12 = instantiate_node(SyntaxNode,input, index...(index + 6))
                            @index += 6
                          else
                            terminal_parse_failure("subsp.")
                            r12 = nil
                          end
                          if r12
                            r0 = r12
                            r0.extend(Rank0)
                          else
                            if input.index("subf.", index) == index
                              r13 = instantiate_node(SyntaxNode,input, index...(index + 5))
                              @index += 5
                            else
                              terminal_parse_failure("subf.")
                              r13 = nil
                            end
                            if r13
                              r0 = r13
                              r0.extend(Rank0)
                            else
                              if input.index("race", index) == index
                                r14 = instantiate_node(SyntaxNode,input, index...(index + 4))
                                @index += 4
                              else
                                terminal_parse_failure("race")
                                r14 = nil
                              end
                              if r14
                                r0 = r14
                                r0.extend(Rank0)
                              else
                                if input.index("α", index) == index
                                  r15 = instantiate_node(SyntaxNode,input, index...(index + 1))
                                  @index += 1
                                else
                                  terminal_parse_failure("α")
                                  r15 = nil
                                end
                                if r15
                                  r0 = r15
                                  r0.extend(Rank0)
                                else
                                  if input.index("ββ", index) == index
                                    r16 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                    @index += 2
                                  else
                                    terminal_parse_failure("ββ")
                                    r16 = nil
                                  end
                                  if r16
                                    r0 = r16
                                    r0.extend(Rank0)
                                  else
                                    if input.index("β", index) == index
                                      r17 = instantiate_node(SyntaxNode,input, index...(index + 1))
                                      @index += 1
                                    else
                                      terminal_parse_failure("β")
                                      r17 = nil
                                    end
                                    if r17
                                      r0 = r17
                                      r0.extend(Rank0)
                                    else
                                      if input.index("γ", index) == index
                                        r18 = instantiate_node(SyntaxNode,input, index...(index + 1))
                                        @index += 1
                                      else
                                        terminal_parse_failure("γ")
                                        r18 = nil
                                      end
                                      if r18
                                        r0 = r18
                                        r0.extend(Rank0)
                                      else
                                        if input.index("δ", index) == index
                                          r19 = instantiate_node(SyntaxNode,input, index...(index + 1))
                                          @index += 1
                                        else
                                          terminal_parse_failure("δ")
                                          r19 = nil
                                        end
                                        if r19
                                          r0 = r19
                                          r0.extend(Rank0)
                                        else
                                          if input.index("ε", index) == index
                                            r20 = instantiate_node(SyntaxNode,input, index...(index + 1))
                                            @index += 1
                                          else
                                            terminal_parse_failure("ε")
                                            r20 = nil
                                          end
                                          if r20
                                            r0 = r20
                                            r0.extend(Rank0)
                                          else
                                            if input.index("φ", index) == index
                                              r21 = instantiate_node(SyntaxNode,input, index...(index + 1))
                                              @index += 1
                                            else
                                              terminal_parse_failure("φ")
                                              r21 = nil
                                            end
                                            if r21
                                              r0 = r21
                                              r0.extend(Rank0)
                                            else
                                              if input.index("θ", index) == index
                                                r22 = instantiate_node(SyntaxNode,input, index...(index + 1))
                                                @index += 1
                                              else
                                                terminal_parse_failure("θ")
                                                r22 = nil
                                              end
                                              if r22
                                                r0 = r22
                                                r0.extend(Rank0)
                                              else
                                                if input.index("μ", index) == index
                                                  r23 = instantiate_node(SyntaxNode,input, index...(index + 1))
                                                  @index += 1
                                                else
                                                  terminal_parse_failure("μ")
                                                  r23 = nil
                                                end
                                                if r23
                                                  r0 = r23
                                                  r0.extend(Rank0)
                                                else
                                                  if input.index("a.", index) == index
                                                    r24 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                                    @index += 2
                                                  else
                                                    terminal_parse_failure("a.")
                                                    r24 = nil
                                                  end
                                                  if r24
                                                    r0 = r24
                                                    r0.extend(Rank0)
                                                  else
                                                    if input.index("b.", index) == index
                                                      r25 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                                      @index += 2
                                                    else
                                                      terminal_parse_failure("b.")
                                                      r25 = nil
                                                    end
                                                    if r25
                                                      r0 = r25
                                                      r0.extend(Rank0)
                                                    else
                                                      if input.index("c.", index) == index
                                                        r26 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                                        @index += 2
                                                      else
                                                        terminal_parse_failure("c.")
                                                        r26 = nil
                                                      end
                                                      if r26
                                                        r0 = r26
                                                        r0.extend(Rank0)
                                                      else
                                                        if input.index("d.", index) == index
                                                          r27 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                                          @index += 2
                                                        else
                                                          terminal_parse_failure("d.")
                                                          r27 = nil
                                                        end
                                                        if r27
                                                          r0 = r27
                                                          r0.extend(Rank0)
                                                        else
                                                          if input.index("e.", index) == index
                                                            r28 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                                            @index += 2
                                                          else
                                                            terminal_parse_failure("e.")
                                                            r28 = nil
                                                          end
                                                          if r28
                                                            r0 = r28
                                                            r0.extend(Rank0)
                                                          else
                                                            if input.index("g.", index) == index
                                                              r29 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                                              @index += 2
                                                            else
                                                              terminal_parse_failure("g.")
                                                              r29 = nil
                                                            end
                                                            if r29
                                                              r0 = r29
                                                              r0.extend(Rank0)
                                                            else
                                                              if input.index("k.", index) == index
                                                                r30 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                                                @index += 2
                                                              else
                                                                terminal_parse_failure("k.")
                                                                r30 = nil
                                                              end
                                                              if r30
                                                                r0 = r30
                                                                r0.extend(Rank0)
                                                              else
                                                                if input.index("****", index) == index
                                                                  r31 = instantiate_node(SyntaxNode,input, index...(index + 4))
                                                                  @index += 4
                                                                else
                                                                  terminal_parse_failure("****")
                                                                  r31 = nil
                                                                end
                                                                if r31
                                                                  r0 = r31
                                                                  r0.extend(Rank0)
                                                                else
                                                                  if input.index("**", index) == index
                                                                    r32 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                                                    @index += 2
                                                                  else
                                                                    terminal_parse_failure("**")
                                                                    r32 = nil
                                                                  end
                                                                  if r32
                                                                    r0 = r32
                                                                    r0.extend(Rank0)
                                                                  else
                                                                    if input.index("*", index) == index
                                                                      r33 = instantiate_node(SyntaxNode,input, index...(index + 1))
                                                                      @index += 1
                                                                    else
                                                                      terminal_parse_failure("*")
                                                                      r33 = nil
                                                                    end
                                                                    if r33
                                                                      r0 = r33
                                                                      r0.extend(Rank0)
                                                                    else
                                                                      self.index = i0
                                                                      r0 = nil
                                                                    end
                                                                  end
                                                                end
                                                              end
                                                            end
                                                          end
                                                        end
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end

    node_cache[:rank][start_index] = r0

    return r0
  end

  module SpeciesName0
    def hybrid_separator
      elements[0]
    end

    def space_hard
      elements[1]
    end

    def a
      elements[2]
    end

    def space_hard
      elements[3]
    end

    def b
      elements[4]
    end
  end

  module SpeciesName1
    def value
      "× " + a.value + " " + b.value
    end
    def canonical
      a.value + " " + b.value
    end
    def details
      {:genus => a.value, :species => b.value, :cross => 'before'}
    end
  end

  module SpeciesName2
    def hybrid_separator
      elements[0]
    end

    def space_hard
      elements[1]
    end

    def a
      elements[2]
    end
  end

  module SpeciesName3
    def value
      "× " + a.value
    end
    def canonical
      a.value
    end
    def details
      {:uninomial => a.value, :cross => 'before'}
    end
  end

  module SpeciesName4
    def a
      elements[0]
    end

    def space_hard
      elements[1]
    end

    def hybrid_separator
      elements[2]
    end

    def space_hard
      elements[3]
    end

    def b
      elements[4]
    end
  end

  module SpeciesName5
    def value
      a.value + " × " + b.value
    end
    def canonical
      a.value + " " + b.value
    end
    def details
      {:genus => a.value, :species => b.value, :cross => 'inside'}
    end
  end

  module SpeciesName6
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

  module SpeciesName7
    def value
      a.value + " " + b.value + " " + c.value
    end
    def canonical
      a.value + " " + c.value
    end
    def details
      {:genus => a.value, :subgenus => b.details, :species => c.value}
    end
  end

  module SpeciesName8
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

  module SpeciesName9
    def value
      a.value + " " + b.value 
    end
    def canonical
      value
    end
    
    def details
      {:genus => a.value, :species => b.value}
    end
  end

  def _nt_species_name
    start_index = index
    if node_cache[:species_name].has_key?(index)
      cached = node_cache[:species_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_hybrid_separator
    s1 << r2
    if r2
      r3 = _nt_space_hard
      s1 << r3
      if r3
        r4 = _nt_cap_latin_word
        s1 << r4
        if r4
          r5 = _nt_space_hard
          s1 << r5
          if r5
            r6 = _nt_latin_word
            s1 << r6
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(SpeciesName0)
      r1.extend(SpeciesName1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i7, s7 = index, []
      r8 = _nt_hybrid_separator
      s7 << r8
      if r8
        r9 = _nt_space_hard
        s7 << r9
        if r9
          r10 = _nt_cap_latin_word
          s7 << r10
        end
      end
      if s7.last
        r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
        r7.extend(SpeciesName2)
        r7.extend(SpeciesName3)
      else
        self.index = i7
        r7 = nil
      end
      if r7
        r0 = r7
      else
        i11, s11 = index, []
        r12 = _nt_cap_latin_word
        s11 << r12
        if r12
          r13 = _nt_space_hard
          s11 << r13
          if r13
            r14 = _nt_hybrid_separator
            s11 << r14
            if r14
              r15 = _nt_space_hard
              s11 << r15
              if r15
                r16 = _nt_latin_word
                s11 << r16
              end
            end
          end
        end
        if s11.last
          r11 = instantiate_node(SyntaxNode,input, i11...index, s11)
          r11.extend(SpeciesName4)
          r11.extend(SpeciesName5)
        else
          self.index = i11
          r11 = nil
        end
        if r11
          r0 = r11
        else
          i17, s17 = index, []
          r18 = _nt_cap_latin_word
          s17 << r18
          if r18
            r19 = _nt_space
            s17 << r19
            if r19
              r20 = _nt_subgenus
              s17 << r20
              if r20
                r21 = _nt_space
                s17 << r21
                if r21
                  r22 = _nt_latin_word
                  s17 << r22
                end
              end
            end
          end
          if s17.last
            r17 = instantiate_node(SyntaxNode,input, i17...index, s17)
            r17.extend(SpeciesName6)
            r17.extend(SpeciesName7)
          else
            self.index = i17
            r17 = nil
          end
          if r17
            r0 = r17
          else
            i23, s23 = index, []
            r24 = _nt_cap_latin_word
            s23 << r24
            if r24
              r25 = _nt_space_hard
              s23 << r25
              if r25
                r26 = _nt_latin_word
                s23 << r26
              end
            end
            if s23.last
              r23 = instantiate_node(SyntaxNode,input, i23...index, s23)
              r23.extend(SpeciesName8)
              r23.extend(SpeciesName9)
            else
              self.index = i23
              r23 = nil
            end
            if r23
              r0 = r23
            else
              self.index = i0
              r0 = nil
            end
          end
        end
      end
    end

    node_cache[:species_name][start_index] = r0

    return r0
  end

  module Subgenus0
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

  module Subgenus1
    def value
      "(" + a.value + ")"
    end
    def details
      a.value
    end
  end

  def _nt_subgenus
    start_index = index
    if node_cache[:subgenus].has_key?(index)
      cached = node_cache[:subgenus][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("(", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("(")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        r3 = _nt_cap_latin_word
        s0 << r3
        if r3
          r4 = _nt_space
          s0 << r4
          if r4
            if input.index(")", index) == index
              r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(")")
              r5 = nil
            end
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Subgenus0)
      r0.extend(Subgenus1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:subgenus][start_index] = r0

    return r0
  end

  module CapLatinWord0
    def a
      elements[0]
    end

    def b
      elements[1]
    end
  end

  module CapLatinWord1
    def value
      a.text_value + b.value
    end
    
    def canonical 
      value
    end
    
    def details 
      {:uninomial => value}
    end
  end

  def _nt_cap_latin_word
    start_index = index
    if node_cache[:cap_latin_word].has_key?(index)
      cached = node_cache[:cap_latin_word][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(Regexp.new('[A-Z]'), index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_latin_word
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(CapLatinWord0)
      r0.extend(CapLatinWord1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:cap_latin_word][start_index] = r0

    return r0
  end

  module LatinWord0
    def a
      elements[0]
    end

    def b
      elements[1]
    end
  end

  module LatinWord1
    def value
      a.text_value + b.value
    end
    def details
      {}
    end
  end

  module LatinWord2
    def a
      elements[0]
    end

    def b
      elements[1]
    end
  end

  module LatinWord3
    def value
      a.value + b.value
    end
    def details
      {}
    end
  end

  def _nt_latin_word
    start_index = index
    if node_cache[:latin_word].has_key?(index)
      cached = node_cache[:latin_word][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if input.index(Regexp.new('[a-zë]'), index) == index
      r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      r2 = nil
    end
    s1 << r2
    if r2
      r3 = _nt_full_name_letters
      s1 << r3
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(LatinWord0)
      r1.extend(LatinWord1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i4, s4 = index, []
      r5 = _nt_digraph
      s4 << r5
      if r5
        r6 = _nt_full_name_letters
        s4 << r6
      end
      if s4.last
        r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
        r4.extend(LatinWord2)
        r4.extend(LatinWord3)
      else
        self.index = i4
        r4 = nil
      end
      if r4
        r0 = r4
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:latin_word][start_index] = r0

    return r0
  end

  module FullNameLetters0
    def a
      elements[0]
    end

    def b
      elements[1]
    end
  end

  module FullNameLetters1
    def value
      a.value + b.value
    end
    def details
      {}
    end
  end

  module FullNameLetters2
    def a
      elements[0]
    end

    def b
      elements[1]
    end

    def c
      elements[2]
    end
  end

  module FullNameLetters3
    def value
      a.value + b.value + c.value
    end
    def details
      {}
    end
  end

  def _nt_full_name_letters
    start_index = index
    if node_cache[:full_name_letters].has_key?(index)
      cached = node_cache[:full_name_letters][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_digraph
    s1 << r2
    if r2
      r3 = _nt_full_name_letters
      s1 << r3
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(FullNameLetters0)
      r1.extend(FullNameLetters1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i4, s4 = index, []
      r5 = _nt_valid_name_letters
      s4 << r5
      if r5
        r6 = _nt_digraph
        s4 << r6
        if r6
          r7 = _nt_full_name_letters
          s4 << r7
        end
      end
      if s4.last
        r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
        r4.extend(FullNameLetters2)
        r4.extend(FullNameLetters3)
      else
        self.index = i4
        r4 = nil
      end
      if r4
        r0 = r4
      else
        r8 = _nt_valid_name_letters
        if r8
          r0 = r8
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:full_name_letters][start_index] = r0

    return r0
  end

  module ValidNameLetters0
    def value
      text_value
    end
    def details
      {}
    end
  end

  def _nt_valid_name_letters
    start_index = index
    if node_cache[:valid_name_letters].has_key?(index)
      cached = node_cache[:valid_name_letters][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      if input.index(Regexp.new('[a-z\\-ëüäöï]'), index) == index
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
      r0.extend(ValidNameLetters0)
    end

    node_cache[:valid_name_letters][start_index] = r0

    return r0
  end

  module Digraph0
    def value
      'ae'
    end
  end

  module Digraph1
    def value
      'oe'
    end
  end

  def _nt_digraph
    start_index = index
    if node_cache[:digraph].has_key?(index)
      cached = node_cache[:digraph][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index(Regexp.new('[æ]'), index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      r1.extend(Digraph0)
      @index += 1
    else
      r1 = nil
    end
    if r1
      r0 = r1
    else
      if input.index(Regexp.new('[œ]'), index) == index
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        r2.extend(Digraph1)
        @index += 1
      else
        r2 = nil
      end
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:digraph][start_index] = r0

    return r0
  end

  module HybridSeparator0
    def value
      "x"
    end
    def details
      {}
    end
  end

  def _nt_hybrid_separator
    start_index = index
    if node_cache[:hybrid_separator].has_key?(index)
      cached = node_cache[:hybrid_separator][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index("x", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("x")
      r1 = nil
    end
    if r1
      r0 = r1
      r0.extend(HybridSeparator0)
    else
      if input.index("X", index) == index
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("X")
        r2 = nil
      end
      if r2
        r0 = r2
        r0.extend(HybridSeparator0)
      else
        if input.index("×", index) == index
          r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("×")
          r3 = nil
        end
        if r3
          r0 = r3
          r0.extend(HybridSeparator0)
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:hybrid_separator][start_index] = r0

    return r0
  end

  module Year0
    def value
      text_value.strip
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
    r1 = _nt_year_with_character
    if r1
      r0 = r1
    else
      s2, i2 = [], index
      loop do
        if input.index(Regexp.new('[0-9\\?]'), index) == index
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
        r2.extend(Year0)
      end
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:year][start_index] = r0

    return r0
  end

  module YearWithCharacter0
    def a
      elements[0]
    end

  end

  module YearWithCharacter1
    def value
      a.text_value
    end
    def details
      {:year => value}
    end
  end

  def _nt_year_with_character
    start_index = index
    if node_cache[:year_with_character].has_key?(index)
      cached = node_cache[:year_with_character][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    s1, i1 = [], index
    loop do
      if input.index(Regexp.new('[0-9\\?]'), index) == index
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r2 = nil
      end
      if r2
        s1 << r2
      else
        break
      end
    end
    if s1.empty?
      self.index = i1
      r1 = nil
    else
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
    end
    s0 << r1
    if r1
      if input.index(Regexp.new('[a-zA-Z]'), index) == index
        r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r3 = nil
      end
      s0 << r3
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(YearWithCharacter0)
      r0.extend(YearWithCharacter1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:year_with_character][start_index] = r0

    return r0
  end

  module Space0
    def details
      {
      }
    end
  end

  def _nt_space
    start_index = index
    if node_cache[:space].has_key?(index)
      cached = node_cache[:space][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      if input.index(Regexp.new('[\\s]'), index) == index
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
    r0.extend(Space0)

    node_cache[:space][start_index] = r0

    return r0
  end

  module SpaceHard0
    def details
      {}
    end
  end

  def _nt_space_hard
    start_index = index
    if node_cache[:space_hard].has_key?(index)
      cached = node_cache[:space_hard][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      if input.index(Regexp.new('[\\s]'), index) == index
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
      r0.extend(SpaceHard0)
    end

    node_cache[:space_hard][start_index] = r0

    return r0
  end

end

class ScientificNameParser < Treetop::Runtime::CompiledParser
  include ScientificName
end
