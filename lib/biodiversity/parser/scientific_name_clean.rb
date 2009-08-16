# encoding: UTF-8
module ScientificNameClean
  include Treetop::Runtime

  def root
    @root || :root
  end

  module Root0
    def space
      elements[0]
    end

    def a
      elements[1]
    end

    def space
      elements[2]
    end
  end

  module Root1
    def value
      a.value.gsub(/\s{2,}/, ' ').strip
    end
    
    def canonical
      a.canonical.gsub(/\s{2,}/, ' ').strip
    end
    
    def pos
      a.pos
    end
    
    def hybrid
      a.hybrid
    end
    
    def details
      a.details.class == Array ? a.details : [a.details]
    end
  end

  def _nt_root
    start_index = index
    if node_cache[:root].has_key?(index)
      cached = node_cache[:root][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_space
    s0 << r1
    if r1
      r2 = _nt_scientific_name_5
      s0 << r2
      if r2
        r3 = _nt_space
        s0 << r3
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Root0)
      r0.extend(Root1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:root][start_index] = r0

    r0
  end

  module ScientificName50
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

  module ScientificName51
    def value
      a.value + " " + b.apply(c)
    end
  
    def canonical
      a.canonical
    end
    
    def pos
      a.pos.merge(c.pos)
    end
    
    def hybrid
      a.hybrid
    end
    
    def details
      a.details.merge(b.details(c))
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
    r2 = _nt_scientific_name_1
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_taxon_concept_rank
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
      r1.extend(ScientificName50)
      r1.extend(ScientificName51)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r7 = _nt_scientific_name_4
      if r7
        r0 = r7
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:scientific_name_5][start_index] = r0

    r0
  end

  module ScientificName40
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def hybrid_character
      elements[2]
    end

    def space
      elements[3]
    end

    def b
      elements[4]
    end
  end

  module ScientificName41
    def value
      a.value + " × " + b.value
    end
    
    def canonical
      a.canonical + " " + b.canonical
    end
    
    def pos
      a.pos.merge(b.pos)
    end
    
    def hybrid
      true
    end
    
    def details
      [a.details, b.details]
    end
  end

  module ScientificName42
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def hybrid_character
      elements[2]
    end

    def space
      elements[3]
    end

  end

  module ScientificName43
    def value
      a.value + " × ?"
    end
    
    def canonical
      a.canonical
    end
    
    def pos
      a.pos
    end
    
    def hybrid
      true
    end
    
    def details
      [a.details, "?"]
    end
  end

  def _nt_scientific_name_4
    start_index = index
    if node_cache[:scientific_name_4].has_key?(index)
      cached = node_cache[:scientific_name_4][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_scientific_name_1
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_hybrid_character
        s1 << r4
        if r4
          r5 = _nt_space
          s1 << r5
          if r5
            r6 = _nt_scientific_name_1
            s1 << r6
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(ScientificName40)
      r1.extend(ScientificName41)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i7, s7 = index, []
      r8 = _nt_scientific_name_1
      s7 << r8
      if r8
        r9 = _nt_space
        s7 << r9
        if r9
          r10 = _nt_hybrid_character
          s7 << r10
          if r10
            r11 = _nt_space
            s7 << r11
            if r11
              if has_terminal?('\G[\\?]', true, index)
                r13 = instantiate_node(SyntaxNode,input, index...(index + 1))
                @index += 1
              else
                r13 = nil
              end
              if r13
                r12 = r13
              else
                r12 = instantiate_node(SyntaxNode,input, index...index)
              end
              s7 << r12
            end
          end
        end
      end
      if s7.last
        r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
        r7.extend(ScientificName42)
        r7.extend(ScientificName43)
      else
        @index = i7
        r7 = nil
      end
      if r7
        r0 = r7
      else
        r14 = _nt_scientific_name_3
        if r14
          r0 = r14
        else
          @index = i0
          r0 = nil
        end
      end
    end

    node_cache[:scientific_name_4][start_index] = r0

    r0
  end

  module ScientificName30
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

  module ScientificName31
    def  value
      a.value + " " + b.value
    end
    
    def canonical
      b.canonical
    end
    
    def pos
      b.pos
    end
    
    def hybrid
      true
    end
    
    def details
      b.details
    end
  end

  def _nt_scientific_name_3
    start_index = index
    if node_cache[:scientific_name_3].has_key?(index)
      cached = node_cache[:scientific_name_3][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_hybrid_character
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_scientific_name_2
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(ScientificName30)
      r1.extend(ScientificName31)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = _nt_scientific_name_2
      if r5
        r0 = r5
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:scientific_name_3][start_index] = r0

    r0
  end

  module ScientificName20
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

  module ScientificName21
    def value
      a.value + " " + b.value
    end
    
    def canonical
      a.canonical
    end
    
    def pos
      a.pos
    end
    
    def hybrid
      a.hybrid rescue false
    end
    
    def details
      a.details.merge(b.details)
    end
  end

  def _nt_scientific_name_2
    start_index = index
    if node_cache[:scientific_name_2].has_key?(index)
      cached = node_cache[:scientific_name_2][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_scientific_name_1
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
      r1.extend(ScientificName20)
      r1.extend(ScientificName21)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = _nt_scientific_name_1
      if r5
        r0 = r5
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:scientific_name_2][start_index] = r0

    r0
  end

  def _nt_scientific_name_1
    start_index = index
    if node_cache[:scientific_name_1].has_key?(index)
      cached = node_cache[:scientific_name_1][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_multinomial_name
    if r1
      r0 = r1
    else
      r2 = _nt_uninomial_name
      if r2
        r0 = r2
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:scientific_name_1][start_index] = r0

    r0
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
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = _nt_status_word
      if r5
        r0 = r5
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:status_part][start_index] = r0

    r0
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

    i0, s0 = index, []
    r1 = _nt_latin_word
    s0 << r1
    if r1
      if has_terminal?('\G[\\.]', true, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r2 = nil
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(StatusWord0)
      r0.extend(StatusWord1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:status_word][start_index] = r0

    r0
  end

  module MultinomialName0
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

    def space
      elements[5]
    end

    def c
      elements[6]
    end

    def space_hard
      elements[7]
    end

    def d
      elements[8]
    end
  end

  module MultinomialName1
    def value
      a.value + " " + b.value + " " + c.value + " " + d.value
    end
  
    def canonical
      a.canonical + " " + b.canonical + " " + c.canonical + " " + d.canonical
    end
  
    def pos
      a.pos.merge(b.pos).merge(c.pos).merge(d.pos)
    end
    
    def hybrid
      c.hybrid rescue false
    end
  
    def details
      a.details.merge(b.details).merge(c.details).merge(d.details)
    end
  end

  module MultinomialName2
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

    def space
      elements[5]
    end

    def c
      elements[6]
    end
  end

  module MultinomialName3
    def value
      a.value + " " + b.value + " " + c.value
    end
    
    def canonical
      a.canonical + " " + c.canonical
    end
    
    def pos
      a.pos.merge(b.pos).merge(c.pos)
    end
    
    def hybrid
      c.hybrid rescue false
    end
    
    def details
      a.details.merge(b.details).merge(c.details)
    end
  end

  module MultinomialName4
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

    def space_hard
      elements[5]
    end

    def c
      elements[6]
    end
  end

  module MultinomialName5
    def value
      a.value + " " + b.value + " " + c.value 
    end

    def canonical
      a.canonical + " " + b.canonical + " " + c.canonical
    end
  
    def pos
      a.pos.merge(b.pos).merge(c.pos)
    end
    
    def hybrid
      b.hybrid rescue false
    end
  
    def details
      a.details.merge(b.details).merge(c.details)
    end
  end

  module MultinomialName6
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

  module MultinomialName7
    def value
      a.value + " " + b.value 
    end

    def canonical
      a.canonical + " " + b.canonical
    end
    
    def pos
      a.pos.merge(b.pos)
    end
    
    def hybrid
      b.hybrid rescue false
    end
    
    def details
      a.details.merge(b.details)
    end
  end

  def _nt_multinomial_name
    start_index = index
    if node_cache[:multinomial_name].has_key?(index)
      cached = node_cache[:multinomial_name][index]
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
            r7 = _nt_species_prefix
            if r7
              r6 = r7
            else
              r6 = instantiate_node(SyntaxNode,input, index...index)
            end
            s1 << r6
            if r6
              r8 = _nt_space
              s1 << r8
              if r8
                r9 = _nt_species
                s1 << r9
                if r9
                  r10 = _nt_space_hard
                  s1 << r10
                  if r10
                    r11 = _nt_infraspecies_mult
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
      r1.extend(MultinomialName0)
      r1.extend(MultinomialName1)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i12, s12 = index, []
      r13 = _nt_genus
      s12 << r13
      if r13
        r14 = _nt_space
        s12 << r14
        if r14
          r15 = _nt_subgenus
          s12 << r15
          if r15
            r16 = _nt_space
            s12 << r16
            if r16
              r18 = _nt_species_prefix
              if r18
                r17 = r18
              else
                r17 = instantiate_node(SyntaxNode,input, index...index)
              end
              s12 << r17
              if r17
                r19 = _nt_space
                s12 << r19
                if r19
                  r20 = _nt_species
                  s12 << r20
                end
              end
            end
          end
        end
      end
      if s12.last
        r12 = instantiate_node(SyntaxNode,input, i12...index, s12)
        r12.extend(MultinomialName2)
        r12.extend(MultinomialName3)
      else
        @index = i12
        r12 = nil
      end
      if r12
        r0 = r12
      else
        i21, s21 = index, []
        r22 = _nt_genus
        s21 << r22
        if r22
          r23 = _nt_space
          s21 << r23
          if r23
            r25 = _nt_species_prefix
            if r25
              r24 = r25
            else
              r24 = instantiate_node(SyntaxNode,input, index...index)
            end
            s21 << r24
            if r24
              r26 = _nt_space
              s21 << r26
              if r26
                r27 = _nt_species
                s21 << r27
                if r27
                  r28 = _nt_space_hard
                  s21 << r28
                  if r28
                    r29 = _nt_infraspecies_mult
                    s21 << r29
                  end
                end
              end
            end
          end
        end
        if s21.last
          r21 = instantiate_node(SyntaxNode,input, i21...index, s21)
          r21.extend(MultinomialName4)
          r21.extend(MultinomialName5)
        else
          @index = i21
          r21 = nil
        end
        if r21
          r0 = r21
        else
          i30, s30 = index, []
          r31 = _nt_genus
          s30 << r31
          if r31
            r32 = _nt_space
            s30 << r32
            if r32
              r34 = _nt_species_prefix
              if r34
                r33 = r34
              else
                r33 = instantiate_node(SyntaxNode,input, index...index)
              end
              s30 << r33
              if r33
                r35 = _nt_space
                s30 << r35
                if r35
                  r36 = _nt_species
                  s30 << r36
                end
              end
            end
          end
          if s30.last
            r30 = instantiate_node(SyntaxNode,input, i30...index, s30)
            r30.extend(MultinomialName6)
            r30.extend(MultinomialName7)
          else
            @index = i30
            r30 = nil
          end
          if r30
            r0 = r30
          else
            @index = i0
            r0 = nil
          end
        end
      end
    end

    node_cache[:multinomial_name][start_index] = r0

    r0
  end

  module InfraspeciesMult0
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

  module InfraspeciesMult1
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
      a_array =  a.details[:infraspecies].class == Array ? a.details[:infraspecies] : [a.details[:infraspecies]] 
      b_array = b.details[:infraspecies].class == Array ? b.details[:infraspecies] : [b.details[:infraspecies]]
      a.details.merge({:infraspecies => a_array + b_array})
    end
  end

  module InfraspeciesMult2
    def details
      {:infraspecies => [super[:infraspecies]]}
    end
  end

  def _nt_infraspecies_mult
    start_index = index
    if node_cache[:infraspecies_mult].has_key?(index)
      cached = node_cache[:infraspecies_mult][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_infraspecies
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_infraspecies_mult
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(InfraspeciesMult0)
      r1.extend(InfraspeciesMult1)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = _nt_infraspecies
      r5.extend(InfraspeciesMult2)
      if r5
        r0 = r5
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:infraspecies_mult][start_index] = r0

    r0
  end

  module Infraspecies0
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
        r4 = _nt_authorship
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Infraspecies0)
      r1.extend(Infraspecies1)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = _nt_infraspecies_epitheton
      if r5
        r0 = r5
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:infraspecies][start_index] = r0

    r0
  end

  module InfraspeciesEpitheton0
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

  module InfraspeciesEpitheton1
    def value 
      sel.apply(a)
    end
    def canonical
      sel.canonical(a)
    end
    
    def pos
      {a.interval.begin => ['infraspecies', a.interval.end]}
    end
  
    def details
      sel.details(a)
    end
  end

  module InfraspeciesEpitheton2
    def species_word
      elements[0]
    end

  end

  module InfraspeciesEpitheton3
    def value
      text_value
    end
    
    def canonical
      value
    end

    def pos
      {interval.begin => ['infraspecies', interval.end]}
    end

    def details
      {:infraspecies => {:epitheton => value, :rank => 'n/a'}}
    end
  end

  def _nt_infraspecies_epitheton
    start_index = index
    if node_cache[:infraspecies_epitheton].has_key?(index)
      cached = node_cache[:infraspecies_epitheton][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_rank
    s1 << r2
    if r2
      r3 = _nt_space_hard
      s1 << r3
      if r3
        r4 = _nt_species_word
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(InfraspeciesEpitheton0)
      r1.extend(InfraspeciesEpitheton1)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i5, s5 = index, []
      r6 = _nt_species_word
      s5 << r6
      if r6
        i7 = index
        if has_terminal?('\G[\\.]', true, index)
          r8 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          r8 = nil
        end
        if r8
          r7 = nil
        else
          @index = i7
          r7 = instantiate_node(SyntaxNode,input, index...index)
        end
        s5 << r7
      end
      if s5.last
        r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
        r5.extend(InfraspeciesEpitheton2)
        r5.extend(InfraspeciesEpitheton3)
      else
        @index = i5
        r5 = nil
      end
      if r5
        r0 = r5
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:infraspecies_epitheton][start_index] = r0

    r0
  end

  module TaxonConceptRank0
    def value
      "sec."
    end
    def apply(a)
      " " + value + " " + a.value
    end
    def details(a = nil)
      {:taxon_concept => a.details}
    end
  end

  def _nt_taxon_concept_rank
    start_index = index
    if node_cache[:taxon_concept_rank].has_key?(index)
      cached = node_cache[:taxon_concept_rank][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if has_terminal?("sec.", false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 4))
      @index += 4
    else
      terminal_parse_failure("sec.")
      r1 = nil
    end
    if r1
      r0 = r1
      r0.extend(TaxonConceptRank0)
    else
      if has_terminal?("sensu.", false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 6))
        @index += 6
      else
        terminal_parse_failure("sensu.")
        r2 = nil
      end
      if r2
        r0 = r2
        r0.extend(TaxonConceptRank0)
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:taxon_concept_rank][start_index] = r0

    r0
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
      {:infraspecies => {:epitheton => (a.value rescue nil), :rank => text_value}}
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
    i1 = index
    if has_terminal?("morph.", false, index)
      r2 = instantiate_node(SyntaxNode,input, index...(index + 6))
      @index += 6
    else
      terminal_parse_failure("morph.")
      r2 = nil
    end
    if r2
      r1 = r2
      r1.extend(Rank0)
    else
      if has_terminal?("f.sp.", false, index)
        r3 = instantiate_node(SyntaxNode,input, index...(index + 5))
        @index += 5
      else
        terminal_parse_failure("f.sp.")
        r3 = nil
      end
      if r3
        r1 = r3
        r1.extend(Rank0)
      else
        if has_terminal?("B", false, index)
          r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("B")
          r4 = nil
        end
        if r4
          r1 = r4
          r1.extend(Rank0)
        else
          if has_terminal?("ssp.", false, index)
            r5 = instantiate_node(SyntaxNode,input, index...(index + 4))
            @index += 4
          else
            terminal_parse_failure("ssp.")
            r5 = nil
          end
          if r5
            r1 = r5
            r1.extend(Rank0)
          else
            if has_terminal?("mut.", false, index)
              r6 = instantiate_node(SyntaxNode,input, index...(index + 4))
              @index += 4
            else
              terminal_parse_failure("mut.")
              r6 = nil
            end
            if r6
              r1 = r6
              r1.extend(Rank0)
            else
              if has_terminal?("nat", false, index)
                r7 = instantiate_node(SyntaxNode,input, index...(index + 3))
                @index += 3
              else
                terminal_parse_failure("nat")
                r7 = nil
              end
              if r7
                r1 = r7
                r1.extend(Rank0)
              else
                if has_terminal?("nothosubsp.", false, index)
                  r8 = instantiate_node(SyntaxNode,input, index...(index + 11))
                  @index += 11
                else
                  terminal_parse_failure("nothosubsp.")
                  r8 = nil
                end
                if r8
                  r1 = r8
                  r1.extend(Rank0)
                else
                  if has_terminal?("pseudovar.", false, index)
                    r9 = instantiate_node(SyntaxNode,input, index...(index + 10))
                    @index += 10
                  else
                    terminal_parse_failure("pseudovar.")
                    r9 = nil
                  end
                  if r9
                    r1 = r9
                    r1.extend(Rank0)
                  else
                    if has_terminal?("sect.", false, index)
                      r10 = instantiate_node(SyntaxNode,input, index...(index + 5))
                      @index += 5
                    else
                      terminal_parse_failure("sect.")
                      r10 = nil
                    end
                    if r10
                      r1 = r10
                      r1.extend(Rank0)
                    else
                      if has_terminal?("ser.", false, index)
                        r11 = instantiate_node(SyntaxNode,input, index...(index + 4))
                        @index += 4
                      else
                        terminal_parse_failure("ser.")
                        r11 = nil
                      end
                      if r11
                        r1 = r11
                        r1.extend(Rank0)
                      else
                        if has_terminal?("var.", false, index)
                          r12 = instantiate_node(SyntaxNode,input, index...(index + 4))
                          @index += 4
                        else
                          terminal_parse_failure("var.")
                          r12 = nil
                        end
                        if r12
                          r1 = r12
                          r1.extend(Rank0)
                        else
                          if has_terminal?("subvar.", false, index)
                            r13 = instantiate_node(SyntaxNode,input, index...(index + 7))
                            @index += 7
                          else
                            terminal_parse_failure("subvar.")
                            r13 = nil
                          end
                          if r13
                            r1 = r13
                            r1.extend(Rank0)
                          else
                            if has_terminal?("[var.]", false, index)
                              r14 = instantiate_node(SyntaxNode,input, index...(index + 6))
                              @index += 6
                            else
                              terminal_parse_failure("[var.]")
                              r14 = nil
                            end
                            if r14
                              r1 = r14
                              r1.extend(Rank0)
                            else
                              if has_terminal?("subsp.", false, index)
                                r15 = instantiate_node(SyntaxNode,input, index...(index + 6))
                                @index += 6
                              else
                                terminal_parse_failure("subsp.")
                                r15 = nil
                              end
                              if r15
                                r1 = r15
                                r1.extend(Rank0)
                              else
                                if has_terminal?("subf.", false, index)
                                  r16 = instantiate_node(SyntaxNode,input, index...(index + 5))
                                  @index += 5
                                else
                                  terminal_parse_failure("subf.")
                                  r16 = nil
                                end
                                if r16
                                  r1 = r16
                                  r1.extend(Rank0)
                                else
                                  if has_terminal?("race", false, index)
                                    r17 = instantiate_node(SyntaxNode,input, index...(index + 4))
                                    @index += 4
                                  else
                                    terminal_parse_failure("race")
                                    r17 = nil
                                  end
                                  if r17
                                    r1 = r17
                                    r1.extend(Rank0)
                                  else
                                    if has_terminal?("α", false, index)
                                      r18 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                      @index += 2
                                    else
                                      terminal_parse_failure("α")
                                      r18 = nil
                                    end
                                    if r18
                                      r1 = r18
                                      r1.extend(Rank0)
                                    else
                                      if has_terminal?("ββ", false, index)
                                        r19 = instantiate_node(SyntaxNode,input, index...(index + 4))
                                        @index += 4
                                      else
                                        terminal_parse_failure("ββ")
                                        r19 = nil
                                      end
                                      if r19
                                        r1 = r19
                                        r1.extend(Rank0)
                                      else
                                        if has_terminal?("β", false, index)
                                          r20 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                          @index += 2
                                        else
                                          terminal_parse_failure("β")
                                          r20 = nil
                                        end
                                        if r20
                                          r1 = r20
                                          r1.extend(Rank0)
                                        else
                                          if has_terminal?("γ", false, index)
                                            r21 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                            @index += 2
                                          else
                                            terminal_parse_failure("γ")
                                            r21 = nil
                                          end
                                          if r21
                                            r1 = r21
                                            r1.extend(Rank0)
                                          else
                                            if has_terminal?("δ", false, index)
                                              r22 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                              @index += 2
                                            else
                                              terminal_parse_failure("δ")
                                              r22 = nil
                                            end
                                            if r22
                                              r1 = r22
                                              r1.extend(Rank0)
                                            else
                                              if has_terminal?("ε", false, index)
                                                r23 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                                @index += 2
                                              else
                                                terminal_parse_failure("ε")
                                                r23 = nil
                                              end
                                              if r23
                                                r1 = r23
                                                r1.extend(Rank0)
                                              else
                                                if has_terminal?("φ", false, index)
                                                  r24 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                                  @index += 2
                                                else
                                                  terminal_parse_failure("φ")
                                                  r24 = nil
                                                end
                                                if r24
                                                  r1 = r24
                                                  r1.extend(Rank0)
                                                else
                                                  if has_terminal?("θ", false, index)
                                                    r25 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                                    @index += 2
                                                  else
                                                    terminal_parse_failure("θ")
                                                    r25 = nil
                                                  end
                                                  if r25
                                                    r1 = r25
                                                    r1.extend(Rank0)
                                                  else
                                                    if has_terminal?("μ", false, index)
                                                      r26 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                                      @index += 2
                                                    else
                                                      terminal_parse_failure("μ")
                                                      r26 = nil
                                                    end
                                                    if r26
                                                      r1 = r26
                                                      r1.extend(Rank0)
                                                    else
                                                      if has_terminal?("a.", false, index)
                                                        r27 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                                        @index += 2
                                                      else
                                                        terminal_parse_failure("a.")
                                                        r27 = nil
                                                      end
                                                      if r27
                                                        r1 = r27
                                                        r1.extend(Rank0)
                                                      else
                                                        if has_terminal?("b.", false, index)
                                                          r28 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                                          @index += 2
                                                        else
                                                          terminal_parse_failure("b.")
                                                          r28 = nil
                                                        end
                                                        if r28
                                                          r1 = r28
                                                          r1.extend(Rank0)
                                                        else
                                                          if has_terminal?("c.", false, index)
                                                            r29 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                                            @index += 2
                                                          else
                                                            terminal_parse_failure("c.")
                                                            r29 = nil
                                                          end
                                                          if r29
                                                            r1 = r29
                                                            r1.extend(Rank0)
                                                          else
                                                            if has_terminal?("d.", false, index)
                                                              r30 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                                              @index += 2
                                                            else
                                                              terminal_parse_failure("d.")
                                                              r30 = nil
                                                            end
                                                            if r30
                                                              r1 = r30
                                                              r1.extend(Rank0)
                                                            else
                                                              if has_terminal?("e.", false, index)
                                                                r31 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                                                @index += 2
                                                              else
                                                                terminal_parse_failure("e.")
                                                                r31 = nil
                                                              end
                                                              if r31
                                                                r1 = r31
                                                                r1.extend(Rank0)
                                                              else
                                                                if has_terminal?("g.", false, index)
                                                                  r32 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                                                  @index += 2
                                                                else
                                                                  terminal_parse_failure("g.")
                                                                  r32 = nil
                                                                end
                                                                if r32
                                                                  r1 = r32
                                                                  r1.extend(Rank0)
                                                                else
                                                                  if has_terminal?("k.", false, index)
                                                                    r33 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                                                    @index += 2
                                                                  else
                                                                    terminal_parse_failure("k.")
                                                                    r33 = nil
                                                                  end
                                                                  if r33
                                                                    r1 = r33
                                                                    r1.extend(Rank0)
                                                                  else
                                                                    if has_terminal?("****", false, index)
                                                                      r34 = instantiate_node(SyntaxNode,input, index...(index + 4))
                                                                      @index += 4
                                                                    else
                                                                      terminal_parse_failure("****")
                                                                      r34 = nil
                                                                    end
                                                                    if r34
                                                                      r1 = r34
                                                                      r1.extend(Rank0)
                                                                    else
                                                                      if has_terminal?("**", false, index)
                                                                        r35 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                                                        @index += 2
                                                                      else
                                                                        terminal_parse_failure("**")
                                                                        r35 = nil
                                                                      end
                                                                      if r35
                                                                        r1 = r35
                                                                        r1.extend(Rank0)
                                                                      else
                                                                        if has_terminal?("*", false, index)
                                                                          r36 = instantiate_node(SyntaxNode,input, index...(index + 1))
                                                                          @index += 1
                                                                        else
                                                                          terminal_parse_failure("*")
                                                                          r36 = nil
                                                                        end
                                                                        if r36
                                                                          r1 = r36
                                                                          r1.extend(Rank0)
                                                                        else
                                                                          @index = i1
                                                                          r1 = nil
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
      end
    end
    if r1
      r0 = r1
    else
      r37 = _nt_rank_forma
      if r37
        r0 = r37
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:rank][start_index] = r0

    r0
  end

  module RankForma0
    def value
      "f."
    end
    def apply(a)
      " " + value + " " + a.value
    end
    def canonical(a)
      " " + a.value
    end
    def details(a = nil)
      {:infraspecies => {:epitheton => (a.value rescue nil), :rank => value}}
    end
  end

  def _nt_rank_forma
    start_index = index
    if node_cache[:rank_forma].has_key?(index)
      cached = node_cache[:rank_forma][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if has_terminal?("forma", false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 5))
      @index += 5
    else
      terminal_parse_failure("forma")
      r1 = nil
    end
    if r1
      r0 = r1
      r0.extend(RankForma0)
    else
      if has_terminal?("form.", false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 5))
        @index += 5
      else
        terminal_parse_failure("form.")
        r2 = nil
      end
      if r2
        r0 = r2
        r0.extend(RankForma0)
      else
        if has_terminal?("fo.", false, index)
          r3 = instantiate_node(SyntaxNode,input, index...(index + 3))
          @index += 3
        else
          terminal_parse_failure("fo.")
          r3 = nil
        end
        if r3
          r0 = r3
          r0.extend(RankForma0)
        else
          if has_terminal?("f.", false, index)
            r4 = instantiate_node(SyntaxNode,input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure("f.")
            r4 = nil
          end
          if r4
            r0 = r4
            r0.extend(RankForma0)
          else
            @index = i0
            r0 = nil
          end
        end
      end
    end

    node_cache[:rank_forma][start_index] = r0

    r0
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
    
    def hybrid
      a.hybrid rescue false
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
        r4 = _nt_authorship
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Species0)
      r1.extend(Species1)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = _nt_species_epitheton
      if r5
        r0 = r5
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:species][start_index] = r0

    r0
  end

  module SpeciesEpitheton0
    def space_hard
      elements[0]
    end

    def author_prefix_word
      elements[1]
    end

    def space_hard
      elements[2]
    end
  end

  module SpeciesEpitheton1
    def a
      elements[0]
    end

  end

  module SpeciesEpitheton2
    def value 
      a.value
    end
    
    def canonical
      a.value
    end
    
    def hybrid
      a.hybrid rescue false
    end
  
    def pos
      {a.interval.begin => ['species', a.interval.end]}
    end
  
    def details
      {:species => {:epitheton => a.value}}
    end
  end

  module SpeciesEpitheton3
    def canonical
      value
    end
    
    def pos
      {interval.begin => ['species', interval.end]}
    end
    
    def hybrid
      false
    end
    
    def details
      {:species => {:epitheton => value}}
    end
  end

  def _nt_species_epitheton
    start_index = index
    if node_cache[:species_epitheton].has_key?(index)
      cached = node_cache[:species_epitheton][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_species_word
    s1 << r2
    if r2
      i3 = index
      i4, s4 = index, []
      r5 = _nt_space_hard
      s4 << r5
      if r5
        r6 = _nt_author_prefix_word
        s4 << r6
        if r6
          r7 = _nt_space_hard
          s4 << r7
        end
      end
      if s4.last
        r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
        r4.extend(SpeciesEpitheton0)
      else
        @index = i4
        r4 = nil
      end
      if r4
        @index = i3
        r3 = instantiate_node(SyntaxNode,input, index...index)
      else
        r3 = nil
      end
      s1 << r3
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(SpeciesEpitheton1)
      r1.extend(SpeciesEpitheton2)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r8 = _nt_species_word
      r8.extend(SpeciesEpitheton3)
      if r8
        r0 = r8
      else
        r9 = _nt_species_word_hybrid
        if r9
          r0 = r9
        else
          @index = i0
          r0 = nil
        end
      end
    end

    node_cache[:species_epitheton][start_index] = r0

    r0
  end

  module Subgenus0
    def left_paren
      elements[0]
    end

    def space
      elements[1]
    end

    def a
      elements[2]
    end

    def space
      elements[3]
    end

    def right_paren
      elements[4]
    end
  end

  module Subgenus1
    def value
      "(" + a.value + ")"
    end
    
    def canonical
      a.value
    end
    
    def pos
      {a.interval.begin => ['subgenus', a.interval.end]}
    end
    
    def details
      {:subgenus => {:epitheton => a.value}}
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
    r1 = _nt_left_paren
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
            r5 = _nt_right_paren
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
      @index = i0
      r0 = nil
    end

    node_cache[:subgenus][start_index] = r0

    r0
  end

  module Genus0
    def space_hard
      elements[0]
    end

    def author_prefix_word
      elements[1]
    end

    def space_hard
      elements[2]
    end

    def author_word
      elements[3]
    end
  end

  module Genus1
    def a
      elements[0]
    end

  end

  module Genus2
    def value
      a.value
    end
    
    def pos
      {a.interval.begin => ['genus', a.interval.end]}
    end
    
    def canonical
      a.value
    end
        
    def details
      {:genus => {:epitheton => a.value}}
    end
  end

  def _nt_genus
    start_index = index
    if node_cache[:genus].has_key?(index)
      cached = node_cache[:genus][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_cap_latin_word
    s0 << r1
    if r1
      i2 = index
      i3, s3 = index, []
      r4 = _nt_space_hard
      s3 << r4
      if r4
        r5 = _nt_author_prefix_word
        s3 << r5
        if r5
          r6 = _nt_space_hard
          s3 << r6
          if r6
            r7 = _nt_author_word
            s3 << r7
          end
        end
      end
      if s3.last
        r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
        r3.extend(Genus0)
      else
        @index = i3
        r3 = nil
      end
      if r3
        r2 = nil
      else
        @index = i2
        r2 = instantiate_node(SyntaxNode,input, index...index)
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Genus1)
      r0.extend(Genus2)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:genus][start_index] = r0

    r0
  end

  module UninomialName0
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

  module UninomialName1
    def value
      a.value + " " + b.value
    end
    
    def canonical
      a.canonical
    end
    
    def pos
      a.pos.merge(b.pos)
    end
    
    def hybrid
      false
    end
    
    def details
      {:uninomial => a.details[:uninomial].merge(b.details)}
    end
  end

  def _nt_uninomial_name
    start_index = index
    if node_cache[:uninomial_name].has_key?(index)
      cached = node_cache[:uninomial_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_uninomial_epitheton
    s1 << r2
    if r2
      r3 = _nt_space_hard
      s1 << r3
      if r3
        r4 = _nt_authorship
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(UninomialName0)
      r1.extend(UninomialName1)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = _nt_uninomial_epitheton
      if r5
        r0 = r5
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:uninomial_name][start_index] = r0

    r0
  end

  module UninomialEpitheton0
    def canonical
      value
    end
    
    def pos
      {interval.begin => ['uninomial', interval.end]}
    end
    
    def hybrid
      false
    end
    
    def details 
      {:uninomial => {:epitheton => value}}
    end
  end

  def _nt_uninomial_epitheton
    start_index = index
    if node_cache[:uninomial_epitheton].has_key?(index)
      cached = node_cache[:uninomial_epitheton][index]
      @index = cached.interval.end if cached
      return cached
    end

    r0 = _nt_cap_latin_word
    r0.extend(UninomialEpitheton0)

    node_cache[:uninomial_epitheton][start_index] = r0

    r0
  end

  module Authorship0
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
      elements[4]
    end

    def c
      elements[5]
    end
  end

  module Authorship1
    def value
      a.value + " " + b.value + " " + c.value
    end
    
    def pos
      a.pos.merge(b.pos).merge(c.pos)
    end
    
    def details
      val = {:authorship => text_value.strip, :combinationAuthorTeam => b.details[:basionymAuthorTeam], :basionymAuthorTeam => a.details[:basionymAuthorTeam]}
      val[:combinationAuthorTeam].merge!(c.details)
      val
    end
  end

  module Authorship2
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

  module Authorship3
    def value
      a.value + " " + b.value
    end
    
    def pos
      a.pos.merge(b.pos)
    end
    
    def details
      {:authorship => text_value.strip, :combinationAuthorTeam => b.details[:basionymAuthorTeam], :basionymAuthorTeam => a.details[:basionymAuthorTeam]}
    end
  end

  module Authorship4
    def a
      elements[0]
    end

    def space
      elements[2]
    end

    def b
      elements[3]
    end
  end

  module Authorship5
    def value
      a.value + " " + b.value
    end
    
    def pos
      a.pos.merge(b.pos)
    end
    
    def details
      val = a.details
      val[:authorship] = text_value.strip
      val[:basionymAuthorTeam].merge!(b.details)
      val
    end
  end

  def _nt_authorship
    start_index = index
    if node_cache[:authorship].has_key?(index)
      cached = node_cache[:authorship][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_basionym_authorship_with_parenthesis
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_simple_authorship
        s1 << r4
        if r4
          if has_terminal?(",", false, index)
            r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure(",")
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
              r8 = _nt_ex_authorship
              s1 << r8
            end
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Authorship0)
      r1.extend(Authorship1)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i9, s9 = index, []
      r10 = _nt_basionym_authorship_with_parenthesis
      s9 << r10
      if r10
        r11 = _nt_space
        s9 << r11
        if r11
          r12 = _nt_simple_authorship
          s9 << r12
        end
      end
      if s9.last
        r9 = instantiate_node(SyntaxNode,input, i9...index, s9)
        r9.extend(Authorship2)
        r9.extend(Authorship3)
      else
        @index = i9
        r9 = nil
      end
      if r9
        r0 = r9
      else
        r13 = _nt_basionym_authorship_with_parenthesis
        if r13
          r0 = r13
        else
          i14, s14 = index, []
          r15 = _nt_simple_authorship
          s14 << r15
          if r15
            if has_terminal?(",", false, index)
              r17 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(",")
              r17 = nil
            end
            if r17
              r16 = r17
            else
              r16 = instantiate_node(SyntaxNode,input, index...index)
            end
            s14 << r16
            if r16
              r18 = _nt_space
              s14 << r18
              if r18
                r19 = _nt_ex_authorship
                s14 << r19
              end
            end
          end
          if s14.last
            r14 = instantiate_node(SyntaxNode,input, i14...index, s14)
            r14.extend(Authorship4)
            r14.extend(Authorship5)
          else
            @index = i14
            r14 = nil
          end
          if r14
            r0 = r14
          else
            r20 = _nt_simple_authorship
            if r20
              r0 = r20
            else
              @index = i0
              r0 = nil
            end
          end
        end
      end
    end

    node_cache[:authorship][start_index] = r0

    r0
  end

  module BasionymAuthorshipWithParenthesis0
    def left_paren
      elements[0]
    end

    def space
      elements[1]
    end

    def a
      elements[2]
    end

    def space
      elements[3]
    end

    def right_paren
      elements[4]
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

  module BasionymAuthorshipWithParenthesis1
    def value
      "(" + a.value + " " + b.value + ")"
    end
    
    def pos
     a.pos.merge(b.pos)
    end 
    
    def details
      { :authorship => text_value, 
        :basionymAuthorTeam => {:author_team => text_value}.merge(a.details).merge(b.details)          
        }
    end
  end

  module BasionymAuthorshipWithParenthesis2
    def left_paren
      elements[0]
    end

    def space
      elements[1]
    end

    def a
      elements[2]
    end

    def space
      elements[4]
    end

    def b
      elements[5]
    end

    def space
      elements[6]
    end

    def right_paren
      elements[7]
    end
  end

  module BasionymAuthorshipWithParenthesis3
    def value
      "(" + a.value + " " + b.value + ")"
    end
    
    def pos
      a.pos.merge(b.pos)
    end
    
    def details
      val = a.details
      val[:basionymAuthorTeam].merge!(b.details)
      val[:authorship] = text_value.strip
      val
    end
  end

  module BasionymAuthorshipWithParenthesis4
    def left_paren
      elements[0]
    end

    def space
      elements[1]
    end

    def a
      elements[2]
    end

    def space
      elements[3]
    end

    def right_paren
      elements[4]
    end
  end

  module BasionymAuthorshipWithParenthesis5
    def value
      "(" + a.value + ")"
    end
    
    def pos
      a.pos
    end
    
    def details
      val = a.details
      val[:authorship] = text_value
      val      
    end
  end

  module BasionymAuthorshipWithParenthesis6
    def left_paren
      elements[0]
    end

    def space
      elements[1]
    end

    def a
      elements[2]
    end

    def space
      elements[3]
    end

    def right_paren
      elements[4]
    end
  end

  module BasionymAuthorshipWithParenthesis7
    def value
      "(?)"
    end
    
    def pos
      {a.interval.begin => ['unknown_author', a.interval.end]}
    end
    
    def details
      {:authorship => text_value, :basionymAuthorTeam => {:authorTeam => text_value, :author => ['?']}}
    end
  end

  def _nt_basionym_authorship_with_parenthesis
    start_index = index
    if node_cache[:basionym_authorship_with_parenthesis].has_key?(index)
      cached = node_cache[:basionym_authorship_with_parenthesis][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_left_paren
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
            r6 = _nt_right_paren
            s1 << r6
            if r6
              r7 = _nt_space
              s1 << r7
              if r7
                if has_terminal?('\G[,]', true, index)
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
      r1.extend(BasionymAuthorshipWithParenthesis0)
      r1.extend(BasionymAuthorshipWithParenthesis1)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i12, s12 = index, []
      r13 = _nt_left_paren
      s12 << r13
      if r13
        r14 = _nt_space
        s12 << r14
        if r14
          r15 = _nt_simple_authorship
          s12 << r15
          if r15
            if has_terminal?(",", false, index)
              r17 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(",")
              r17 = nil
            end
            if r17
              r16 = r17
            else
              r16 = instantiate_node(SyntaxNode,input, index...index)
            end
            s12 << r16
            if r16
              r18 = _nt_space
              s12 << r18
              if r18
                r19 = _nt_ex_authorship
                s12 << r19
                if r19
                  r20 = _nt_space
                  s12 << r20
                  if r20
                    r21 = _nt_right_paren
                    s12 << r21
                  end
                end
              end
            end
          end
        end
      end
      if s12.last
        r12 = instantiate_node(SyntaxNode,input, i12...index, s12)
        r12.extend(BasionymAuthorshipWithParenthesis2)
        r12.extend(BasionymAuthorshipWithParenthesis3)
      else
        @index = i12
        r12 = nil
      end
      if r12
        r0 = r12
      else
        i22, s22 = index, []
        r23 = _nt_left_paren
        s22 << r23
        if r23
          r24 = _nt_space
          s22 << r24
          if r24
            r25 = _nt_simple_authorship
            s22 << r25
            if r25
              r26 = _nt_space
              s22 << r26
              if r26
                r27 = _nt_right_paren
                s22 << r27
              end
            end
          end
        end
        if s22.last
          r22 = instantiate_node(SyntaxNode,input, i22...index, s22)
          r22.extend(BasionymAuthorshipWithParenthesis4)
          r22.extend(BasionymAuthorshipWithParenthesis5)
        else
          @index = i22
          r22 = nil
        end
        if r22
          r0 = r22
        else
          i28, s28 = index, []
          r29 = _nt_left_paren
          s28 << r29
          if r29
            r30 = _nt_space
            s28 << r30
            if r30
              if has_terminal?("?", false, index)
                r31 = instantiate_node(SyntaxNode,input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure("?")
                r31 = nil
              end
              s28 << r31
              if r31
                r32 = _nt_space
                s28 << r32
                if r32
                  r33 = _nt_right_paren
                  s28 << r33
                end
              end
            end
          end
          if s28.last
            r28 = instantiate_node(SyntaxNode,input, i28...index, s28)
            r28.extend(BasionymAuthorshipWithParenthesis6)
            r28.extend(BasionymAuthorshipWithParenthesis7)
          else
            @index = i28
            r28 = nil
          end
          if r28
            r0 = r28
          else
            @index = i0
            r0 = nil
          end
        end
      end
    end

    node_cache[:basionym_authorship_with_parenthesis][start_index] = r0

    r0
  end

  module ExAuthorship0
    def ex_sep
      elements[0]
    end

    def space
      elements[1]
    end

    def b
      elements[2]
    end
  end

  module ExAuthorship1
    def value
      " ex " + b.value
    end
    
    def pos
      b.pos
    end
    
    def details
      val = {:exAuthorTeam => {:authorTeam => b.text_value.strip}.merge(b.details[:basionymAuthorTeam])}
      val
    end
  end

  def _nt_ex_authorship
    start_index = index
    if node_cache[:ex_authorship].has_key?(index)
      cached = node_cache[:ex_authorship][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_ex_sep
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        r3 = _nt_simple_authorship
        s0 << r3
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(ExAuthorship0)
      r0.extend(ExAuthorship1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:ex_authorship][start_index] = r0

    r0
  end

  module SimpleAuthorship0
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

    def space
      elements[6]
    end

    def space
      elements[8]
    end

    def authors_names
      elements[9]
    end

    def space
      elements[10]
    end

    def space
      elements[12]
    end

    def year
      elements[13]
    end
  end

  module SimpleAuthorship1
    def value
      a.value + " " + b.value
    end
    
    def pos
      a.pos.merge(b.pos)
    end
    
    def details
      details_with_arg(:basionymAuthorTeam)
    end
    
    def details_with_arg(authorTeamType = 'basionymAuthorTeam')
      { :authorship => text_value, 
        authorTeamType.to_sym => {
          :authorTeam => a.text_value.strip
        }.merge(a.details).merge(b.details)
      }
    end
  end

  module SimpleAuthorship2
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

  module SimpleAuthorship3
    def value
      a.value + " " + b.value
    end
    
    def pos
      a.pos.merge(b.pos)
    end
    
    def details
      details_with_arg(:basionymAuthorTeam)
    end
    
    def details_with_arg(authorTeamType = 'basionymAuthorTeam')
      { :authorship => text_value, 
        authorTeamType.to_sym => {
          :authorTeam => a.text_value.strip
        }.merge(a.details).merge(b.details)
      }
    end
  end

  module SimpleAuthorship4
    def details
      details = details_with_arg(:basionymAuthorTeam)
      details[:basionymAuthorTeam].merge!(super)
      details
    end
    
    def details_with_arg(authorTeamType = 'basionymAuthorTeam')
      { :authorship => text_value, 
        authorTeamType.to_sym => {
          :authorTeam => text_value,
        }
      }      
    end
  end

  def _nt_simple_authorship
    start_index = index
    if node_cache[:simple_authorship].has_key?(index)
      cached = node_cache[:simple_authorship][index]
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
        if has_terminal?('\G[,]', true, index)
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
            r8 = _nt_year
            if r8
              r7 = r8
            else
              r7 = instantiate_node(SyntaxNode,input, index...index)
            end
            s1 << r7
            if r7
              if has_terminal?('\G[,]', true, index)
                r10 = instantiate_node(SyntaxNode,input, index...(index + 1))
                @index += 1
              else
                r10 = nil
              end
              if r10
                r9 = r10
              else
                r9 = instantiate_node(SyntaxNode,input, index...index)
              end
              s1 << r9
              if r9
                r11 = _nt_space
                s1 << r11
                if r11
                  if has_terminal?("non", false, index)
                    r12 = instantiate_node(SyntaxNode,input, index...(index + 3))
                    @index += 3
                  else
                    terminal_parse_failure("non")
                    r12 = nil
                  end
                  s1 << r12
                  if r12
                    r13 = _nt_space
                    s1 << r13
                    if r13
                      r14 = _nt_authors_names
                      s1 << r14
                      if r14
                        r15 = _nt_space
                        s1 << r15
                        if r15
                          if has_terminal?('\G[,]', true, index)
                            r17 = instantiate_node(SyntaxNode,input, index...(index + 1))
                            @index += 1
                          else
                            r17 = nil
                          end
                          if r17
                            r16 = r17
                          else
                            r16 = instantiate_node(SyntaxNode,input, index...index)
                          end
                          s1 << r16
                          if r16
                            r18 = _nt_space
                            s1 << r18
                            if r18
                              r19 = _nt_year
                              s1 << r19
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
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(SimpleAuthorship0)
      r1.extend(SimpleAuthorship1)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i20, s20 = index, []
      r21 = _nt_authors_names
      s20 << r21
      if r21
        r22 = _nt_space
        s20 << r22
        if r22
          if has_terminal?('\G[,]', true, index)
            r24 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            r24 = nil
          end
          if r24
            r23 = r24
          else
            r23 = instantiate_node(SyntaxNode,input, index...index)
          end
          s20 << r23
          if r23
            r25 = _nt_space
            s20 << r25
            if r25
              r26 = _nt_year
              s20 << r26
            end
          end
        end
      end
      if s20.last
        r20 = instantiate_node(SyntaxNode,input, i20...index, s20)
        r20.extend(SimpleAuthorship2)
        r20.extend(SimpleAuthorship3)
      else
        @index = i20
        r20 = nil
      end
      if r20
        r0 = r20
      else
        r27 = _nt_authors_names
        r27.extend(SimpleAuthorship4)
        if r27
          r0 = r27
        else
          @index = i0
          r0 = nil
        end
      end
    end

    node_cache[:simple_authorship][start_index] = r0

    r0
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
    
    def pos
      sep.pos(a,b)
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
        r4 = _nt_author_separator
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
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r7 = _nt_author_name
      if r7
        r0 = r7
      else
        r8 = _nt_unknown_auth
        if r8
          r0 = r8
        else
          @index = i0
          r0 = nil
        end
      end
    end

    node_cache[:authors_names][start_index] = r0

    r0
  end

  module UnknownAuth0
    def value
      text_value
    end
    
    def pos
     {interval.begin => ['unknown_author', interval.end]}
    end
    
    def details
      {:author => ["unknown"]}
    end
  end

  def _nt_unknown_auth
    start_index = index
    if node_cache[:unknown_auth].has_key?(index)
      cached = node_cache[:unknown_auth][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if has_terminal?("auct.", false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 5))
      @index += 5
    else
      terminal_parse_failure("auct.")
      r1 = nil
    end
    if r1
      r0 = r1
      r0.extend(UnknownAuth0)
    else
      if has_terminal?("hort.", false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 5))
        @index += 5
      else
        terminal_parse_failure("hort.")
        r2 = nil
      end
      if r2
        r0 = r2
        r0.extend(UnknownAuth0)
      else
        if has_terminal?("anon.", false, index)
          r3 = instantiate_node(SyntaxNode,input, index...(index + 5))
          @index += 5
        else
          terminal_parse_failure("anon.")
          r3 = nil
        end
        if r3
          r0 = r3
          r0.extend(UnknownAuth0)
        else
          if has_terminal?("ht.", false, index)
            r4 = instantiate_node(SyntaxNode,input, index...(index + 3))
            @index += 3
          else
            terminal_parse_failure("ht.")
            r4 = nil
          end
          if r4
            r0 = r4
            r0.extend(UnknownAuth0)
          else
            @index = i0
            r0 = nil
          end
        end
      end
    end

    node_cache[:unknown_auth][start_index] = r0

    r0
  end

  module ExSep0
  end

  def _nt_ex_sep
    start_index = index
    if node_cache[:ex_sep].has_key?(index)
      cached = node_cache[:ex_sep][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    i1 = index
    if has_terminal?("ex", false, index)
      r2 = instantiate_node(SyntaxNode,input, index...(index + 2))
      @index += 2
    else
      terminal_parse_failure("ex")
      r2 = nil
    end
    if r2
      r1 = r2
    else
      if has_terminal?("in", false, index)
        r3 = instantiate_node(SyntaxNode,input, index...(index + 2))
        @index += 2
      else
        terminal_parse_failure("in")
        r3 = nil
      end
      if r3
        r1 = r3
      else
        @index = i1
        r1 = nil
      end
    end
    s0 << r1
    if r1
      i4 = index
      if has_terminal?('\G[\\s]', true, index)
        r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r5 = nil
      end
      if r5
        @index = i4
        r4 = instantiate_node(SyntaxNode,input, index...index)
      else
        r4 = nil
      end
      s0 << r4
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(ExSep0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:ex_sep][start_index] = r0

    r0
  end

  module AuthorSeparator0
    def apply(a,b)
      sep = text_value.strip
      sep = " et" if ["&","and","et"].include? sep
      a.value + sep + " " + b.value
    end
    
    def pos(a,b)
      a.pos.merge(b.pos)
    end
    
    def details(a,b)
      {:author => a.details[:author] + b.details[:author]}
    end
  end

  def _nt_author_separator
    start_index = index
    if node_cache[:author_separator].has_key?(index)
      cached = node_cache[:author_separator][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if has_terminal?("&", false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("&")
      r1 = nil
    end
    if r1
      r0 = r1
      r0.extend(AuthorSeparator0)
    else
      if has_terminal?(",", false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(",")
        r2 = nil
      end
      if r2
        r0 = r2
        r0.extend(AuthorSeparator0)
      else
        if has_terminal?("and", false, index)
          r3 = instantiate_node(SyntaxNode,input, index...(index + 3))
          @index += 3
        else
          terminal_parse_failure("and")
          r3 = nil
        end
        if r3
          r0 = r3
          r0.extend(AuthorSeparator0)
        else
          if has_terminal?("et", false, index)
            r4 = instantiate_node(SyntaxNode,input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure("et")
            r4 = nil
          end
          if r4
            r0 = r4
            r0.extend(AuthorSeparator0)
          else
            @index = i0
            r0 = nil
          end
        end
      end
    end

    node_cache[:author_separator][start_index] = r0

    r0
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
    
    def pos
      a.pos.merge(b.pos)
    end
    
    def details
      {:author => [value]}
    end
  end

  module AuthorName2
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

  module AuthorName3
    def value
      a.value + " " + b.value
    end
    
    def pos
      a.pos.merge(b.pos)
    end
    
    def details
      {:author => [value]}
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
      r3 = _nt_author_prefix_word
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
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i7, s7 = index, []
      r8 = _nt_space
      s7 << r8
      if r8
        r9 = _nt_author_word
        s7 << r9
        if r9
          r10 = _nt_space
          s7 << r10
          if r10
            r11 = _nt_author_name
            s7 << r11
            if r11
              r12 = _nt_space
              s7 << r12
            end
          end
        end
      end
      if s7.last
        r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
        r7.extend(AuthorName2)
        r7.extend(AuthorName3)
      else
        @index = i7
        r7 = nil
      end
      if r7
        r0 = r7
      else
        r13 = _nt_author_word
        if r13
          r0 = r13
        else
          @index = i0
          r0 = nil
        end
      end
    end

    node_cache[:author_name][start_index] = r0

    r0
  end

  module AuthorWord0
    def value
      text_value.strip
    end
    
    def pos
      {interval.begin => ['author_word', 1], (interval.begin + 2) => ['author_word', 2], (interval.begin + 5) => ['author_word', 2]}
    end
    
    def details
      {:author => [value]}
    end
  end

  module AuthorWord1
    def value
      text_value.strip
    end
    
    def pos
      #cheating because there are several words in some of them
      {interval.begin => ['author_word', interval.end]}
    end
    
    def details
      {:author => [value]}
    end
  end

  module AuthorWord2
  end

  module AuthorWord3
    def value
      text_value
    end
    
    def pos
      {interval.begin => ['author_word', interval.end]}
    end
    
    def details
      {:author => [value]}
    end
  end

  module AuthorWord4
  end

  module AuthorWord5
    def value
      text_value
    end
    
    def pos
      {interval.begin => ['author_word', interval.end]}
    end
    
    def details
      {:author => [value]}
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
    if has_terminal?("A S. Xu", false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 7))
      r1.extend(AuthorWord0)
      @index += 7
    else
      terminal_parse_failure("A S. Xu")
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i2 = index
      if has_terminal?("arg.", false, index)
        r3 = instantiate_node(SyntaxNode,input, index...(index + 4))
        @index += 4
      else
        terminal_parse_failure("arg.")
        r3 = nil
      end
      if r3
        r2 = r3
        r2.extend(AuthorWord1)
      else
        if has_terminal?("et al.\{\?\}", false, index)
          r4 = instantiate_node(SyntaxNode,input, index...(index + 9))
          @index += 9
        else
          terminal_parse_failure("et al.\{\?\}")
          r4 = nil
        end
        if r4
          r2 = r4
          r2.extend(AuthorWord1)
        else
          if has_terminal?("et al.", false, index)
            r5 = instantiate_node(SyntaxNode,input, index...(index + 6))
            @index += 6
          else
            terminal_parse_failure("et al.")
            r5 = nil
          end
          if r5
            r2 = r5
            r2.extend(AuthorWord1)
          else
            @index = i2
            r2 = nil
          end
        end
      end
      if r2
        r0 = r2
      else
        i6, s6 = index, []
        i7 = index
        if has_terminal?("Å", false, index)
          r8 = instantiate_node(SyntaxNode,input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure("Å")
          r8 = nil
        end
        if r8
          r7 = r8
        else
          if has_terminal?("Ö", false, index)
            r9 = instantiate_node(SyntaxNode,input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure("Ö")
            r9 = nil
          end
          if r9
            r7 = r9
          else
            if has_terminal?("Á", false, index)
              r10 = instantiate_node(SyntaxNode,input, index...(index + 2))
              @index += 2
            else
              terminal_parse_failure("Á")
              r10 = nil
            end
            if r10
              r7 = r10
            else
              if has_terminal?("Ø", false, index)
                r11 = instantiate_node(SyntaxNode,input, index...(index + 2))
                @index += 2
              else
                terminal_parse_failure("Ø")
                r11 = nil
              end
              if r11
                r7 = r11
              else
                if has_terminal?("Ô", false, index)
                  r12 = instantiate_node(SyntaxNode,input, index...(index + 2))
                  @index += 2
                else
                  terminal_parse_failure("Ô")
                  r12 = nil
                end
                if r12
                  r7 = r12
                else
                  if has_terminal?("Š", false, index)
                    r13 = instantiate_node(SyntaxNode,input, index...(index + 2))
                    @index += 2
                  else
                    terminal_parse_failure("Š")
                    r13 = nil
                  end
                  if r13
                    r7 = r13
                  else
                    if has_terminal?("Ś", false, index)
                      r14 = instantiate_node(SyntaxNode,input, index...(index + 2))
                      @index += 2
                    else
                      terminal_parse_failure("Ś")
                      r14 = nil
                    end
                    if r14
                      r7 = r14
                    else
                      if has_terminal?("Č", false, index)
                        r15 = instantiate_node(SyntaxNode,input, index...(index + 2))
                        @index += 2
                      else
                        terminal_parse_failure("Č")
                        r15 = nil
                      end
                      if r15
                        r7 = r15
                      else
                        if has_terminal?("Ķ", false, index)
                          r16 = instantiate_node(SyntaxNode,input, index...(index + 2))
                          @index += 2
                        else
                          terminal_parse_failure("Ķ")
                          r16 = nil
                        end
                        if r16
                          r7 = r16
                        else
                          if has_terminal?("Ł", false, index)
                            r17 = instantiate_node(SyntaxNode,input, index...(index + 2))
                            @index += 2
                          else
                            terminal_parse_failure("Ł")
                            r17 = nil
                          end
                          if r17
                            r7 = r17
                          else
                            if has_terminal?("É", false, index)
                              r18 = instantiate_node(SyntaxNode,input, index...(index + 2))
                              @index += 2
                            else
                              terminal_parse_failure("É")
                              r18 = nil
                            end
                            if r18
                              r7 = r18
                            else
                              if has_terminal?("Ž", false, index)
                                r19 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                @index += 2
                              else
                                terminal_parse_failure("Ž")
                                r19 = nil
                              end
                              if r19
                                r7 = r19
                              else
                                if has_terminal?('\G[A-W]', true, index)
                                  r20 = instantiate_node(SyntaxNode,input, index...(index + 1))
                                  @index += 1
                                else
                                  r20 = nil
                                end
                                if r20
                                  r7 = r20
                                else
                                  if has_terminal?('\G[Y-Z]', true, index)
                                    r21 = instantiate_node(SyntaxNode,input, index...(index + 1))
                                    @index += 1
                                  else
                                    r21 = nil
                                  end
                                  if r21
                                    r7 = r21
                                  else
                                    @index = i7
                                    r7 = nil
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
        s6 << r7
        if r7
          s22, i22 = [], index
          loop do
            if has_terminal?('\G[^0-9\\[\\]\\(\\)\\s&,]', true, index)
              r23 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              r23 = nil
            end
            if r23
              s22 << r23
            else
              break
            end
          end
          r22 = instantiate_node(SyntaxNode,input, i22...index, s22)
          s6 << r22
        end
        if s6.last
          r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
          r6.extend(AuthorWord2)
          r6.extend(AuthorWord3)
        else
          @index = i6
          r6 = nil
        end
        if r6
          r0 = r6
        else
          i24, s24 = index, []
          if has_terminal?("X", false, index)
            r25 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("X")
            r25 = nil
          end
          s24 << r25
          if r25
            s26, i26 = [], index
            loop do
              if has_terminal?('\G[^0-9\\[\\]\\(\\)\\s&,]', true, index)
                r27 = instantiate_node(SyntaxNode,input, index...(index + 1))
                @index += 1
              else
                r27 = nil
              end
              if r27
                s26 << r27
              else
                break
              end
            end
            if s26.empty?
              @index = i26
              r26 = nil
            else
              r26 = instantiate_node(SyntaxNode,input, i26...index, s26)
            end
            s24 << r26
          end
          if s24.last
            r24 = instantiate_node(SyntaxNode,input, i24...index, s24)
            r24.extend(AuthorWord4)
            r24.extend(AuthorWord5)
          else
            @index = i24
            r24 = nil
          end
          if r24
            r0 = r24
          else
            r28 = _nt_author_prefix_word
            if r28
              r0 = r28
            else
              @index = i0
              r0 = nil
            end
          end
        end
      end
    end

    node_cache[:author_word][start_index] = r0

    r0
  end

  module AuthorPrefixWord0
    def space
      elements[0]
    end

  end

  module AuthorPrefixWord1
    def value
      text_value
    end
    
    def pos
      #cheating because there are several words in some of them
      {interval.begin => ['author_word', interval.end]}
    end
  end

  def _nt_author_prefix_word
    start_index = index
    if node_cache[:author_prefix_word].has_key?(index)
      cached = node_cache[:author_prefix_word][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_space
    s0 << r1
    if r1
      i2 = index
      if has_terminal?("ab", false, index)
        r3 = instantiate_node(SyntaxNode,input, index...(index + 2))
        @index += 2
      else
        terminal_parse_failure("ab")
        r3 = nil
      end
      if r3
        r2 = r3
      else
        if has_terminal?("bis", false, index)
          r4 = instantiate_node(SyntaxNode,input, index...(index + 3))
          @index += 3
        else
          terminal_parse_failure("bis")
          r4 = nil
        end
        if r4
          r2 = r4
        else
          if has_terminal?("da", false, index)
            r5 = instantiate_node(SyntaxNode,input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure("da")
            r5 = nil
          end
          if r5
            r2 = r5
          else
            if has_terminal?("der", false, index)
              r6 = instantiate_node(SyntaxNode,input, index...(index + 3))
              @index += 3
            else
              terminal_parse_failure("der")
              r6 = nil
            end
            if r6
              r2 = r6
            else
              if has_terminal?("den", false, index)
                r7 = instantiate_node(SyntaxNode,input, index...(index + 3))
                @index += 3
              else
                terminal_parse_failure("den")
                r7 = nil
              end
              if r7
                r2 = r7
              else
                if has_terminal?("della", false, index)
                  r8 = instantiate_node(SyntaxNode,input, index...(index + 5))
                  @index += 5
                else
                  terminal_parse_failure("della")
                  r8 = nil
                end
                if r8
                  r2 = r8
                else
                  if has_terminal?("dela", false, index)
                    r9 = instantiate_node(SyntaxNode,input, index...(index + 4))
                    @index += 4
                  else
                    terminal_parse_failure("dela")
                    r9 = nil
                  end
                  if r9
                    r2 = r9
                  else
                    if has_terminal?("de", false, index)
                      r10 = instantiate_node(SyntaxNode,input, index...(index + 2))
                      @index += 2
                    else
                      terminal_parse_failure("de")
                      r10 = nil
                    end
                    if r10
                      r2 = r10
                    else
                      if has_terminal?("di", false, index)
                        r11 = instantiate_node(SyntaxNode,input, index...(index + 2))
                        @index += 2
                      else
                        terminal_parse_failure("di")
                        r11 = nil
                      end
                      if r11
                        r2 = r11
                      else
                        if has_terminal?("du", false, index)
                          r12 = instantiate_node(SyntaxNode,input, index...(index + 2))
                          @index += 2
                        else
                          terminal_parse_failure("du")
                          r12 = nil
                        end
                        if r12
                          r2 = r12
                        else
                          if has_terminal?("la", false, index)
                            r13 = instantiate_node(SyntaxNode,input, index...(index + 2))
                            @index += 2
                          else
                            terminal_parse_failure("la")
                            r13 = nil
                          end
                          if r13
                            r2 = r13
                          else
                            if has_terminal?("ter", false, index)
                              r14 = instantiate_node(SyntaxNode,input, index...(index + 3))
                              @index += 3
                            else
                              terminal_parse_failure("ter")
                              r14 = nil
                            end
                            if r14
                              r2 = r14
                            else
                              if has_terminal?("van", false, index)
                                r15 = instantiate_node(SyntaxNode,input, index...(index + 3))
                                @index += 3
                              else
                                terminal_parse_failure("van")
                                r15 = nil
                              end
                              if r15
                                r2 = r15
                              else
                                if has_terminal?("von", false, index)
                                  r16 = instantiate_node(SyntaxNode,input, index...(index + 3))
                                  @index += 3
                                else
                                  terminal_parse_failure("von")
                                  r16 = nil
                                end
                                if r16
                                  r2 = r16
                                else
                                  @index = i2
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
      s0 << r2
      if r2
        i17 = index
        r18 = _nt_space_hard
        if r18
          @index = i17
          r17 = instantiate_node(SyntaxNode,input, index...index)
        else
          r17 = nil
        end
        s0 << r17
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(AuthorPrefixWord0)
      r0.extend(AuthorPrefixWord1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:author_prefix_word][start_index] = r0

    r0
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
      (a.value rescue a.text_value) + b.value
    end
  end

  module CapLatinWord2
    def a
      elements[0]
    end

    def b
      elements[1]
    end
  end

  module CapLatinWord3
    def value
      (a.value rescue a.text_value) + b.value
    end
  end

  module CapLatinWord4
    def value
      text_value
    end
  end

  def _nt_cap_latin_word
    start_index = index
    if node_cache[:cap_latin_word].has_key?(index)
      cached = node_cache[:cap_latin_word][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    i2 = index
    if has_terminal?('\G[A-Z]', true, index)
      r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      r3 = nil
    end
    if r3
      r2 = r3
    else
      r4 = _nt_cap_digraph
      if r4
        r2 = r4
      else
        @index = i2
        r2 = nil
      end
    end
    s1 << r2
    if r2
      r5 = _nt_latin_word
      s1 << r5
      if r5
        if has_terminal?("?", false, index)
          r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("?")
          r6 = nil
        end
        s1 << r6
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(CapLatinWord0)
      r1.extend(CapLatinWord1)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i7, s7 = index, []
      i8 = index
      if has_terminal?('\G[A-Z]', true, index)
        r9 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r9 = nil
      end
      if r9
        r8 = r9
      else
        r10 = _nt_cap_digraph
        if r10
          r8 = r10
        else
          @index = i8
          r8 = nil
        end
      end
      s7 << r8
      if r8
        r11 = _nt_latin_word
        s7 << r11
      end
      if s7.last
        r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
        r7.extend(CapLatinWord2)
        r7.extend(CapLatinWord3)
      else
        @index = i7
        r7 = nil
      end
      if r7
        r0 = r7
      else
        i12 = index
        if has_terminal?("Ca", false, index)
          r13 = instantiate_node(SyntaxNode,input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure("Ca")
          r13 = nil
        end
        if r13
          r12 = r13
          r12.extend(CapLatinWord4)
        else
          if has_terminal?("Ea", false, index)
            r14 = instantiate_node(SyntaxNode,input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure("Ea")
            r14 = nil
          end
          if r14
            r12 = r14
            r12.extend(CapLatinWord4)
          else
            if has_terminal?("Ge", false, index)
              r15 = instantiate_node(SyntaxNode,input, index...(index + 2))
              @index += 2
            else
              terminal_parse_failure("Ge")
              r15 = nil
            end
            if r15
              r12 = r15
              r12.extend(CapLatinWord4)
            else
              if has_terminal?("Ia", false, index)
                r16 = instantiate_node(SyntaxNode,input, index...(index + 2))
                @index += 2
              else
                terminal_parse_failure("Ia")
                r16 = nil
              end
              if r16
                r12 = r16
                r12.extend(CapLatinWord4)
              else
                if has_terminal?("Io", false, index)
                  r17 = instantiate_node(SyntaxNode,input, index...(index + 2))
                  @index += 2
                else
                  terminal_parse_failure("Io")
                  r17 = nil
                end
                if r17
                  r12 = r17
                  r12.extend(CapLatinWord4)
                else
                  if has_terminal?("Io", false, index)
                    r18 = instantiate_node(SyntaxNode,input, index...(index + 2))
                    @index += 2
                  else
                    terminal_parse_failure("Io")
                    r18 = nil
                  end
                  if r18
                    r12 = r18
                    r12.extend(CapLatinWord4)
                  else
                    if has_terminal?("Ix", false, index)
                      r19 = instantiate_node(SyntaxNode,input, index...(index + 2))
                      @index += 2
                    else
                      terminal_parse_failure("Ix")
                      r19 = nil
                    end
                    if r19
                      r12 = r19
                      r12.extend(CapLatinWord4)
                    else
                      if has_terminal?("Lo", false, index)
                        r20 = instantiate_node(SyntaxNode,input, index...(index + 2))
                        @index += 2
                      else
                        terminal_parse_failure("Lo")
                        r20 = nil
                      end
                      if r20
                        r12 = r20
                        r12.extend(CapLatinWord4)
                      else
                        if has_terminal?("Oa", false, index)
                          r21 = instantiate_node(SyntaxNode,input, index...(index + 2))
                          @index += 2
                        else
                          terminal_parse_failure("Oa")
                          r21 = nil
                        end
                        if r21
                          r12 = r21
                          r12.extend(CapLatinWord4)
                        else
                          if has_terminal?("Ra", false, index)
                            r22 = instantiate_node(SyntaxNode,input, index...(index + 2))
                            @index += 2
                          else
                            terminal_parse_failure("Ra")
                            r22 = nil
                          end
                          if r22
                            r12 = r22
                            r12.extend(CapLatinWord4)
                          else
                            if has_terminal?("Ty", false, index)
                              r23 = instantiate_node(SyntaxNode,input, index...(index + 2))
                              @index += 2
                            else
                              terminal_parse_failure("Ty")
                              r23 = nil
                            end
                            if r23
                              r12 = r23
                              r12.extend(CapLatinWord4)
                            else
                              if has_terminal?("Ua", false, index)
                                r24 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                @index += 2
                              else
                                terminal_parse_failure("Ua")
                                r24 = nil
                              end
                              if r24
                                r12 = r24
                                r12.extend(CapLatinWord4)
                              else
                                if has_terminal?("Aa", false, index)
                                  r25 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                  @index += 2
                                else
                                  terminal_parse_failure("Aa")
                                  r25 = nil
                                end
                                if r25
                                  r12 = r25
                                  r12.extend(CapLatinWord4)
                                else
                                  if has_terminal?("Ja", false, index)
                                    r26 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                    @index += 2
                                  else
                                    terminal_parse_failure("Ja")
                                    r26 = nil
                                  end
                                  if r26
                                    r12 = r26
                                    r12.extend(CapLatinWord4)
                                  else
                                    if has_terminal?("Zu", false, index)
                                      r27 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                      @index += 2
                                    else
                                      terminal_parse_failure("Zu")
                                      r27 = nil
                                    end
                                    if r27
                                      r12 = r27
                                      r12.extend(CapLatinWord4)
                                    else
                                      if has_terminal?("La", false, index)
                                        r28 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                        @index += 2
                                      else
                                        terminal_parse_failure("La")
                                        r28 = nil
                                      end
                                      if r28
                                        r12 = r28
                                        r12.extend(CapLatinWord4)
                                      else
                                        if has_terminal?("Qu", false, index)
                                          r29 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                          @index += 2
                                        else
                                          terminal_parse_failure("Qu")
                                          r29 = nil
                                        end
                                        if r29
                                          r12 = r29
                                          r12.extend(CapLatinWord4)
                                        else
                                          if has_terminal?("As", false, index)
                                            r30 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                            @index += 2
                                          else
                                            terminal_parse_failure("As")
                                            r30 = nil
                                          end
                                          if r30
                                            r12 = r30
                                            r12.extend(CapLatinWord4)
                                          else
                                            if has_terminal?("Ba", false, index)
                                              r31 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                              @index += 2
                                            else
                                              terminal_parse_failure("Ba")
                                              r31 = nil
                                            end
                                            if r31
                                              r12 = r31
                                              r12.extend(CapLatinWord4)
                                            else
                                              @index = i12
                                              r12 = nil
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
        if r12
          r0 = r12
        else
          @index = i0
          r0 = nil
        end
      end
    end

    node_cache[:cap_latin_word][start_index] = r0

    r0
  end

  module SpeciesWordHybrid0
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

  module SpeciesWordHybrid1
    def value
      a.value + " " + b.value
    end
    
    def canonical
      b.value
    end
    
    def hybrid
      true
    end
    
    def pos
      {b.interval.begin => ['species', b.interval.end]}
    end
    
    def details
      {:species => {:epitheton => b.value}}
    end
  end

  module SpeciesWordHybrid2
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

  module SpeciesWordHybrid3
    def value
      "× " + b.value
    end
    
    def canonical
      b.value
    end
    
    def hybrid
      true
    end
    
    def pos
      {b.interval.begin => ['species', b.interval.end]}
    end
    
    def details
      {:species => {:epitheton => b.value}}
    end
  end

  module SpeciesWordHybrid4
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

  module SpeciesWordHybrid5
    def value
      "× " + b.value
    end
    
    def canonical
      b.value
    end
    
    def hybrid
      true
    end
    
    def pos
      {b.interval.begin => ['species', b.interval.end]}
    end
    
    def details
      {:species => {:epitheton => b.value}}
    end
  end

  def _nt_species_word_hybrid
    start_index = index
    if node_cache[:species_word_hybrid].has_key?(index)
      cached = node_cache[:species_word_hybrid][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_multiplication_sign
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_species_word
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(SpeciesWordHybrid0)
      r1.extend(SpeciesWordHybrid1)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i5, s5 = index, []
      if has_terminal?("X", false, index)
        r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("X")
        r6 = nil
      end
      s5 << r6
      if r6
        r7 = _nt_space
        s5 << r7
        if r7
          r8 = _nt_species_word
          s5 << r8
        end
      end
      if s5.last
        r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
        r5.extend(SpeciesWordHybrid2)
        r5.extend(SpeciesWordHybrid3)
      else
        @index = i5
        r5 = nil
      end
      if r5
        r0 = r5
      else
        i9, s9 = index, []
        if has_terminal?("x", false, index)
          r10 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("x")
          r10 = nil
        end
        s9 << r10
        if r10
          r11 = _nt_space_hard
          s9 << r11
          if r11
            r12 = _nt_species_word
            s9 << r12
          end
        end
        if s9.last
          r9 = instantiate_node(SyntaxNode,input, i9...index, s9)
          r9.extend(SpeciesWordHybrid4)
          r9.extend(SpeciesWordHybrid5)
        else
          @index = i9
          r9 = nil
        end
        if r9
          r0 = r9
        else
          @index = i0
          r0 = nil
        end
      end
    end

    node_cache[:species_word_hybrid][start_index] = r0

    r0
  end

  module SpeciesPrefix0
  end

  def _nt_species_prefix
    start_index = index
    if node_cache[:species_prefix].has_key?(index)
      cached = node_cache[:species_prefix][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    i1 = index
    if has_terminal?("aff.", false, index)
      r2 = instantiate_node(SyntaxNode,input, index...(index + 4))
      @index += 4
    else
      terminal_parse_failure("aff.")
      r2 = nil
    end
    if r2
      r1 = r2
    else
      if has_terminal?("corrig.", false, index)
        r3 = instantiate_node(SyntaxNode,input, index...(index + 7))
        @index += 7
      else
        terminal_parse_failure("corrig.")
        r3 = nil
      end
      if r3
        r1 = r3
      else
        if has_terminal?("?", false, index)
          r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("?")
          r4 = nil
        end
        if r4
          r1 = r4
        else
          @index = i1
          r1 = nil
        end
      end
    end
    s0 << r1
    if r1
      i5 = index
      r6 = _nt_space_hard
      if r6
        @index = i5
        r5 = instantiate_node(SyntaxNode,input, index...index)
      else
        r5 = nil
      end
      s0 << r5
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(SpeciesPrefix0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:species_prefix][start_index] = r0

    r0
  end

  module SpeciesWord0
    def a
      elements[0]
    end

    def b
      elements[2]
    end
  end

  module SpeciesWord1
    def value
      a.text_value + "-" + b.value
    end
  end

  def _nt_species_word
    start_index = index
    if node_cache[:species_word].has_key?(index)
      cached = node_cache[:species_word][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    s2, i2 = [], index
    loop do
      if has_terminal?('\G[0-9]', true, index)
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
      @index = i2
      r2 = nil
    else
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
    end
    s1 << r2
    if r2
      if has_terminal?("-", false, index)
        r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("-")
        r5 = nil
      end
      if r5
        r4 = r5
      else
        r4 = instantiate_node(SyntaxNode,input, index...index)
      end
      s1 << r4
      if r4
        r6 = _nt_latin_word
        s1 << r6
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(SpeciesWord0)
      r1.extend(SpeciesWord1)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r7 = _nt_latin_word
      if r7
        r0 = r7
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:species_word][start_index] = r0

    r0
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
    if has_terminal?('\G[a-zëüäöïéåóç]', true, index)
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
      @index = i1
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
        @index = i4
        r4 = nil
      end
      if r4
        r0 = r4
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:latin_word][start_index] = r0

    r0
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
      @index = i1
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
        @index = i4
        r4 = nil
      end
      if r4
        r0 = r4
      else
        r8 = _nt_valid_name_letters
        if r8
          r0 = r8
        else
          @index = i0
          r0 = nil
        end
      end
    end

    node_cache[:full_name_letters][start_index] = r0

    r0
  end

  module ValidNameLetters0
    def value
      text_value
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
      if has_terminal?('\G[a-z\\-ëüäöïéåóç]', true, index)
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
      @index = i0
      r0 = nil
    else
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(ValidNameLetters0)
    end

    node_cache[:valid_name_letters][start_index] = r0

    r0
  end

  module CapDigraph0
    def value
    'Ae'
    end
  end

  module CapDigraph1
    def value
    'Oe'
    end
  end

  def _nt_cap_digraph
    start_index = index
    if node_cache[:cap_digraph].has_key?(index)
      cached = node_cache[:cap_digraph][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if has_terminal?("Æ", false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 2))
      r1.extend(CapDigraph0)
      @index += 2
    else
      terminal_parse_failure("Æ")
      r1 = nil
    end
    if r1
      r0 = r1
    else
      if has_terminal?("Œ", false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 2))
        r2.extend(CapDigraph1)
        @index += 2
      else
        terminal_parse_failure("Œ")
        r2 = nil
      end
      if r2
        r0 = r2
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:cap_digraph][start_index] = r0

    r0
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
    if has_terminal?("æ", false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 2))
      r1.extend(Digraph0)
      @index += 2
    else
      terminal_parse_failure("æ")
      r1 = nil
    end
    if r1
      r0 = r1
    else
      if has_terminal?("œ", false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 2))
        r2.extend(Digraph1)
        @index += 2
      else
        terminal_parse_failure("œ")
        r2 = nil
      end
      if r2
        r0 = r2
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:digraph][start_index] = r0

    r0
  end

  module Year0
    def b
      elements[0]
    end

    def space
      elements[1]
    end

    def a
      elements[2]
    end

    def space
      elements[3]
    end

    def c
      elements[4]
    end
  end

  module Year1
    def value
      a.value
    end
    
    def pos
      a.pos
    end
    
    def details
      a.details
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
    r2 = _nt_left_paren
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        i4 = index
        r5 = _nt_year_number_with_character
        if r5
          r4 = r5
        else
          r6 = _nt_year_number
          if r6
            r4 = r6
          else
            @index = i4
            r4 = nil
          end
        end
        s1 << r4
        if r4
          r7 = _nt_space
          s1 << r7
          if r7
            r8 = _nt_right_paren
            s1 << r8
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Year0)
      r1.extend(Year1)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r9 = _nt_year_number_with_character
      if r9
        r0 = r9
      else
        r10 = _nt_year_number
        if r10
          r0 = r10
        else
          @index = i0
          r0 = nil
        end
      end
    end

    node_cache[:year][start_index] = r0

    r0
  end

  module YearNumberWithCharacter0
    def a
      elements[0]
    end

  end

  module YearNumberWithCharacter1
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

  def _nt_year_number_with_character
    start_index = index
    if node_cache[:year_number_with_character].has_key?(index)
      cached = node_cache[:year_number_with_character][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_year_number
    s0 << r1
    if r1
      if has_terminal?('\G[a-zA-Z]', true, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r2 = nil
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(YearNumberWithCharacter0)
      r0.extend(YearNumberWithCharacter1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:year_number_with_character][start_index] = r0

    r0
  end

  module YearNumber0
  end

  module YearNumber1
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

  def _nt_year_number
    start_index = index
    if node_cache[:year_number].has_key?(index)
      cached = node_cache[:year_number][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if has_terminal?('\G[12]', true, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      r1 = nil
    end
    s0 << r1
    if r1
      if has_terminal?('\G[7890]', true, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r2 = nil
      end
      s0 << r2
      if r2
        if has_terminal?('\G[0-9]', true, index)
          r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          r3 = nil
        end
        s0 << r3
        if r3
          if has_terminal?('\G[0-9]', true, index)
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
          s0 << r4
          if r4
            if has_terminal?('\G[\\?]', true, index)
              r7 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              r7 = nil
            end
            if r7
              r6 = r7
            else
              r6 = instantiate_node(SyntaxNode,input, index...index)
            end
            s0 << r6
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(YearNumber0)
      r0.extend(YearNumber1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:year_number][start_index] = r0

    r0
  end

  def _nt_left_paren
    start_index = index
    if node_cache[:left_paren].has_key?(index)
      cached = node_cache[:left_paren][index]
      @index = cached.interval.end if cached
      return cached
    end

    if has_terminal?("(", false, index)
      r0 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("(")
      r0 = nil
    end

    node_cache[:left_paren][start_index] = r0

    r0
  end

  def _nt_right_paren
    start_index = index
    if node_cache[:right_paren].has_key?(index)
      cached = node_cache[:right_paren][index]
      @index = cached.interval.end if cached
      return cached
    end

    if has_terminal?(")", false, index)
      r0 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure(")")
      r0 = nil
    end

    node_cache[:right_paren][start_index] = r0

    r0
  end

  module HybridCharacter0
    def value
      "×"
    end
  end

  def _nt_hybrid_character
    start_index = index
    if node_cache[:hybrid_character].has_key?(index)
      cached = node_cache[:hybrid_character][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1 = index
    if has_terminal?("x", false, index)
      r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("x")
      r2 = nil
    end
    if r2
      r1 = r2
      r1.extend(HybridCharacter0)
    else
      if has_terminal?("X", false, index)
        r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("X")
        r3 = nil
      end
      if r3
        r1 = r3
        r1.extend(HybridCharacter0)
      else
        @index = i1
        r1 = nil
      end
    end
    if r1
      r0 = r1
    else
      r4 = _nt_multiplication_sign
      if r4
        r0 = r4
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:hybrid_character][start_index] = r0

    r0
  end

  module MultiplicationSign0
    def value
      text_value
    end
  end

  def _nt_multiplication_sign
    start_index = index
    if node_cache[:multiplication_sign].has_key?(index)
      cached = node_cache[:multiplication_sign][index]
      @index = cached.interval.end if cached
      return cached
    end

    if has_terminal?("×", false, index)
      r0 = instantiate_node(SyntaxNode,input, index...(index + 2))
      r0.extend(MultiplicationSign0)
      @index += 2
    else
      terminal_parse_failure("×")
      r0 = nil
    end

    node_cache[:multiplication_sign][start_index] = r0

    r0
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
      if has_terminal?('\G[\\s]', true, index)
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

    node_cache[:space][start_index] = r0

    r0
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
      if has_terminal?('\G[\\s]', true, index)
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
      @index = i0
      r0 = nil
    else
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
    end

    node_cache[:space_hard][start_index] = r0

    r0
  end

end

class ScientificNameCleanParser < Treetop::Runtime::CompiledParser
  include ScientificNameClean
end
