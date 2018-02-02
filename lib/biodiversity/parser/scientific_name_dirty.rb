# encoding: UTF-8
# Autogenerated from a Treetop grammar. Edits may be lost.


module ScientificNameDirty
  include Treetop::Runtime

  def root
    @root ||= :root
  end

  include ScientificNameClean

  module Root0
    def space1
      elements[0]
    end

    def a
      elements[1]
    end

    def space2
      elements[2]
    end
  end

  module Root1
    def value
      a.value.gsub(/\s{2,}/, " ").strip
    end

    def canonical
      a.canonical.gsub(/\s{2,}/, " ").strip
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

    def parser_run
      2
    end
  end

  def _nt_root
    start_index = index
    if node_cache[:root].has_key?(index)
      cached = node_cache[:root][index]
      if cached
        node_cache[:root][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
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

    def garbage
      elements[1]
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
      if cached
        node_cache[:scientific_name_5][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_scientific_name_4
    s1 << r2
    if r2
      r3 = _nt_garbage
      s1 << r3
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
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      r4 = super
      if r4
        r4 = SyntaxNode.new(input, (index-1)...index) if r4 == true
        r0 = r4
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:scientific_name_5][start_index] = r0

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

  module Infraspecies2
    def a
      elements[0]
    end

    def space1
      elements[1]
    end

    def string_authorship_inconsistencies
      elements[2]
    end

    def space2
      elements[3]
    end

    def b
      elements[4]
    end
  end

  module Infraspecies3
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
      if cached
        node_cache[:infraspecies][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_infraspecies_string
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
      r1.extend(Infraspecies0)
      r1.extend(Infraspecies1)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      i5, s5 = index, []
      r6 = _nt_infraspecies_string
      s5 << r6
      if r6
        r7 = _nt_space
        s5 << r7
        if r7
          r8 = _nt_string_authorship_inconsistencies
          s5 << r8
          if r8
            r9 = _nt_space
            s5 << r9
            if r9
              r10 = _nt_authorship
              s5 << r10
            end
          end
        end
      end
      if s5.last
        r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
        r5.extend(Infraspecies2)
        r5.extend(Infraspecies3)
      else
        @index = i5
        r5 = nil
      end
      if r5
        r5 = SyntaxNode.new(input, (index-1)...index) if r5 == true
        r0 = r5
      else
        r11 = super
        if r11
          r11 = SyntaxNode.new(input, (index-1)...index) if r11 == true
          r0 = r11
        else
          @index = i0
          r0 = nil
        end
      end
    end

    node_cache[:infraspecies][start_index] = r0

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
      if cached
        node_cache[:species][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_species_string
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
      @index = i1
      r1 = nil
    end
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      r5 = super
      if r5
        r5 = SyntaxNode.new(input, (index-1)...index) if r5 == true
        r0 = r5
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:species][start_index] = r0

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
      res = ""
      text_value.split("").each do |l|
        l = "ae" if l == "æ"
        l = "oe" if l == "œ"
        res << l
      end
      res.tr("àâåãäáçčëéèíìïňññóòôøõöúùüŕřŗššşž",
             "aaaaaacceeeiiinnnoooooouuurrrsssz")
    end
  end

  def _nt_latin_word
    start_index = index
    if node_cache[:latin_word].has_key?(index)
      cached = node_cache[:latin_word][index]
      if cached
        node_cache[:latin_word][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?(@regexps[gr = '\A[a-z\\-æœàâåãäáçčëéèíìïňññóòôøõöúùüŕřŗššşž]'] ||= Regexp.new(gr), :regexp, index)
      r1 = true
      @index += 1
    else
      terminal_parse_failure('[a-z\\-æœàâåãäáçčëéèíìïňññóòôøõöúùüŕřŗššşž]')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_valid_name_letters
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(LatinWord0)
      r0.extend(LatinWord1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:latin_word][start_index] = r0

    r0
  end

  module ValidNameLetters0
    def value
      res = ""
      text_value.split("").each do |l|
        l = "ae" if l == "æ"
        l = "oe" if l == "œ"
        res << l
      end
      res.tr("àâåãäáçčëéèíìïňññóòôøõöúùüŕřŗššşž",
             "aaaaaacceeeiiinnnoooooouuurrrsssz")

    end
  end

  def _nt_valid_name_letters
    start_index = index
    if node_cache[:valid_name_letters].has_key?(index)
      cached = node_cache[:valid_name_letters][index]
      if cached
        node_cache[:valid_name_letters][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      if has_terminal?(@regexps[gr = '\A[a-z\\-æœàâåãäáçčëéèíìïňññóòôøõöúùüŕřŗššşž]'] ||= Regexp.new(gr), :regexp, index)
        r1 = true
        @index += 1
      else
        terminal_parse_failure('[a-z\\-æœàâåãäáçčëéèíìïňññóòôøõöúùüŕřŗššşž]')
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
      r0.extend(ValidNameLetters0)
    end

    node_cache[:valid_name_letters][start_index] = r0

    r0
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
      if cached
        node_cache[:right_paren][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if (match_len = has_terminal?(")", false, index))
      r2 = true
      @index += match_len
    else
      terminal_parse_failure('")"')
      r2 = nil
    end
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        if (match_len = has_terminal?(")", false, index))
          r4 = true
          @index += match_len
        else
          terminal_parse_failure('")"')
          r4 = nil
        end
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(RightParen0)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      r5 = super
      if r5
        r5 = SyntaxNode.new(input, (index-1)...index) if r5 == true
        r0 = r5
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:right_paren][start_index] = r0

    r0
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
      if cached
        node_cache[:left_paren][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if (match_len = has_terminal?("(", false, index))
      r2 = true
      @index += match_len
    else
      terminal_parse_failure('"("')
      r2 = nil
    end
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        if (match_len = has_terminal?("(", false, index))
          r4 = true
          @index += match_len
        else
          terminal_parse_failure('"("')
          r4 = nil
        end
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(LeftParen0)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      r5 = super
      if r5
        r5 = SyntaxNode.new(input, (index-1)...index) if r5 == true
        r0 = r5
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:left_paren][start_index] = r0

    r0
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
      {a.interval.begin => ["year", a.interval.end]}
    end

    def details
      {:year => value}
    end
  end

  def _nt_year
    start_index = index
    if node_cache[:year].has_key?(index)
      cached = node_cache[:year][index]
      if cached
        node_cache[:year][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
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
      @index = i1
      r1 = nil
    end
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
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
        @index = i5
        r5 = nil
      end
      if r5
        r5 = SyntaxNode.new(input, (index-1)...index) if r5 == true
        r0 = r5
      else
        r9 = _nt_year_number_with_punctuation
        if r9
          r9 = SyntaxNode.new(input, (index-1)...index) if r9 == true
          r0 = r9
        else
          r10 = _nt_approximate_year
          if r10
            r10 = SyntaxNode.new(input, (index-1)...index) if r10 == true
            r0 = r10
          else
            r11 = _nt_double_year
            if r11
              r11 = SyntaxNode.new(input, (index-1)...index) if r11 == true
              r0 = r11
            else
              r12 = super
              if r12
                r12 = SyntaxNode.new(input, (index-1)...index) if r12 == true
                r0 = r12
              else
                @index = i0
                r0 = nil
              end
            end
          end
        end
      end
    end

    node_cache[:year][start_index] = r0

    r0
  end

  module ApproximateYear0
    def space1
      elements[1]
    end

    def a
      elements[2]
    end

    def space2
      elements[3]
    end

  end

  module ApproximateYear1
    def value
     "(" + a.text_value + ")"
    end

    def pos
      {a.interval.begin => ["year", a.interval.end]}
    end

    def details
      {:approximate_year => value}
    end
  end

  def _nt_approximate_year
    start_index = index
    if node_cache[:approximate_year].has_key?(index)
      cached = node_cache[:approximate_year][index]
      if cached
        node_cache[:approximate_year][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?("[", false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure('"["')
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
              if (match_len = has_terminal?("]", false, index))
                r6 = true
                @index += match_len
              else
                terminal_parse_failure('"]"')
                r6 = nil
              end
              if r6
                s5 << r6
              else
                break
              end
            end
            if s5.empty?
              @index = i5
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
      @index = i0
      r0 = nil
    end

    node_cache[:approximate_year][start_index] = r0

    r0
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
      {interval.begin => ["year", interval.end]}
    end

    def details
      {:year => value}
    end
  end

  def _nt_double_year
    start_index = index
    if node_cache[:double_year].has_key?(index)
      cached = node_cache[:double_year][index]
      if cached
        node_cache[:double_year][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_year_number
    s0 << r1
    if r1
      if (match_len = has_terminal?("-", false, index))
        r2 = true
        @index += match_len
      else
        terminal_parse_failure('"-"')
        r2 = nil
      end
      s0 << r2
      if r2
        s3, i3 = [], index
        loop do
          if has_terminal?(@regexps[gr = '\A[0-9]'] ||= Regexp.new(gr), :regexp, index)
            r4 = true
            @index += 1
          else
            terminal_parse_failure('[0-9]')
            r4 = nil
          end
          if r4
            s3 << r4
          else
            break
          end
        end
        if s3.empty?
          @index = i3
          r3 = nil
        else
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
        end
        s0 << r3
        if r3
          if has_terminal?(@regexps[gr = '\A[A-Za-z]'] ||= Regexp.new(gr), :regexp, index)
            r6 = true
            @index += 1
          else
            terminal_parse_failure('[A-Za-z]')
            r6 = nil
          end
          if r6
            r5 = r6
          else
            r5 = instantiate_node(SyntaxNode,input, index...index)
          end
          s0 << r5
          if r5
            if has_terminal?(@regexps[gr = '\A[\\?]'] ||= Regexp.new(gr), :regexp, index)
              r8 = true
              @index += 1
            else
              terminal_parse_failure('[\\?]')
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
      @index = i0
      r0 = nil
    end

    node_cache[:double_year][start_index] = r0

    r0
  end

  module YearNumberWithPunctuation0
    def a
      elements[0]
    end

  end

  module YearNumberWithPunctuation1
    def value
      a.text_value
    end

    def pos
      {interval.begin => ["year", interval.end]}
    end

    def details
      {:year => value}
    end
  end

  def _nt_year_number_with_punctuation
    start_index = index
    if node_cache[:year_number_with_punctuation].has_key?(index)
      cached = node_cache[:year_number_with_punctuation][index]
      if cached
        node_cache[:year_number_with_punctuation][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_year_number
    s0 << r1
    if r1
      if (match_len = has_terminal?(".", false, index))
        r2 = true
        @index += match_len
      else
        terminal_parse_failure('"."')
        r2 = nil
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(YearNumberWithPunctuation0)
      r0.extend(YearNumberWithPunctuation1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:year_number_with_punctuation][start_index] = r0

    r0
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
      if cached
        node_cache[:page_number][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?(":", false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure('":"')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        s3, i3 = [], index
        loop do
          if has_terminal?(@regexps[gr = '\A[\\d]'] ||= Regexp.new(gr), :regexp, index)
            r4 = true
            @index += 1
          else
            terminal_parse_failure('[\\d]')
            r4 = nil
          end
          if r4
            s3 << r4
          else
            break
          end
        end
        if s3.empty?
          @index = i3
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
      @index = i0
      r0 = nil
    end

    node_cache[:page_number][start_index] = r0

    r0
  end

  def _nt_string_authorship_inconsistencies
    start_index = index
    if node_cache[:string_authorship_inconsistencies].has_key?(index)
      cached = node_cache[:string_authorship_inconsistencies][index]
      if cached
        node_cache[:string_authorship_inconsistencies][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    if (match_len = has_terminal?("corrig.", false, index))
      r0 = instantiate_node(SyntaxNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure('"corrig."')
      r0 = nil
    end

    node_cache[:string_authorship_inconsistencies][start_index] = r0

    r0
  end

  module Garbage0
    def space1
      elements[0]
    end

    def space2
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
      if cached
        node_cache[:garbage][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_space
    s1 << r2
    if r2
      if has_terminal?(@regexps[gr = '\A["\',]'] ||= Regexp.new(gr), :regexp, index)
        r3 = true
        @index += 1
      else
        terminal_parse_failure('["\',]')
        r3 = nil
      end
      s1 << r3
      if r3
        r4 = _nt_space
        s1 << r4
        if r4
          s5, i5 = [], index
          loop do
            if has_terminal?(@regexps[gr = '\A[^щ]'] ||= Regexp.new(gr), :regexp, index)
              r6 = true
              @index += 1
            else
              terminal_parse_failure('[^щ]')
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
      @index = i1
      r1 = nil
    end
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      i7, s7 = index, []
      r8 = _nt_space_hard
      s7 << r8
      if r8
        s9, i9 = [], index
        loop do
          if has_terminal?(@regexps[gr = '\A[^ш]'] ||= Regexp.new(gr), :regexp, index)
            r10 = true
            @index += 1
          else
            terminal_parse_failure('[^ш]')
            r10 = nil
          end
          if r10
            s9 << r10
          else
            break
          end
        end
        if s9.empty?
          @index = i9
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
        @index = i7
        r7 = nil
      end
      if r7
        r7 = SyntaxNode.new(input, (index-1)...index) if r7 == true
        r0 = r7
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:garbage][start_index] = r0

    r0
  end

end

class ScientificNameDirtyParser < Treetop::Runtime::CompiledParser
  include ScientificNameDirty
end

