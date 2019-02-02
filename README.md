Biodiversity
============

[![DOI](https://zenodo.org/badge/19435/GlobalNamesArchitecture/biodiversity.svg)](https://zenodo.org/badge/latestdoi/19435/GlobalNamesArchitecture/biodiversity)
[![Gem Version][gem_svg]][gem_link]
[![Continuous Integration Status][ci_svg]][ci_link]
[![CodePolice][cc_svg]][cc_link]
[![Dependency Status][deps_svg]][deps_link]

Parses taxonomic scientific name and breaks it into semantic elements.

# Important: Biodiversity parser is in 'archive' state: moving development to https://gitlab.com/gogna/gnparser

Developing parsers for scientific names is a very tedious job due to differences between nomenclatural codes, human
common errors, and gynamic nature of nomenclature. We decided to concentrate on developing one parser and deprecate
others we developed so far.

We rewrote the parser from scratch in [Go language](https://gitlab.com/gogna/gnparser), making it lighting fast, robust and much better designed than ``biodiversity`` parser. Specifically for Ruby developers we made a [gnparser Ruby Gem](https://rubygems.org/gems/gnparser) that uses gRPC framework to achieve almost native to Go speeds. If by some reason you want to go a different way, ``gnparser`` provides ultrafast [command line tool](https://gitlab.com/gogna/gnparser/releases) as well as good old (and fast) [REST API](http://parser.globalnames.org/doc/api).

Installation
------------

    sudo gem install biodiversity

Example usage
-------------

### As a command line script

You can parse file with taxonomic names from command line.
File should contain one scientific name per line

    nnparse file_with_names

The resuls will be put into parsed.json file in the current directory.
To save results into a different file:

    nnparse file_with_names output_file

### As a socket server

If you do not use Ruby and need a fast access to the parser functionality
you can use a socket server

    parserver

    parserver -h
    Usage: parserver [options]

        -r, --canonical_with_rank        Adds infraspecies rank
                                         to canonical forms

        -o, --output=output              Specifies the type of the output:
                                         json - parsed results in json
                                         canonical - canonical form only
                                         Default: json

        -H, --host=host                  Specifies host as "127.0.0.1",
                                         "localhost" etc.
                                         Default: 127.0.0.1

        -p, --port=port                  Specifies the port number
                                         Default: 4334

        -h, --help                       Show this help message.

    parserver --output=canonical



With default settings you can access parserserver via 4334 port using a
socket client library of your programming language.  You can find
[socket client script example][socket_example] in the examples directory of the gem.

If you want to check if socket server works for you:

    #run server in one terminal
    parserver

    #in another terminal window type
    telnet localhost 4334

If you enter a line with a scientific name -- server will send you back
parsed information in json format.

To stop telnet client type any of `end`,`exit`,`q`, `.` instead
of scientific name

    $ telnet localhost 4334
    Trying ::1...
    Connected to localhost.
    Escape character is '^]'.
    Acacia abyssinica Hochst. ex Benth. ssp. calophylla Brenan
    {"scientificName":{"canonical":"Acacia abyssinica calophylla"...}}
    end

### As a library

You can use it as a library in Ruby, JRuby etc.


```ruby
require 'biodiversity'

parser = ScientificNameParser.new

#to find version number
ScientificNameParser.version

# to fix capitalization in canonicals
ScientificNameParser.fix_case("QUERCUS (QUERCUS) ALBA")
# Output: Quercus (Quercus) alba

# to parse a scientific name into a ruby hash
parser.parse("Plantago major")

#to get json representation
parser.parse("Plantago").to_json
#or
parser.parse("Plantago")
parser.all_json

# to clean name up
parser.parse("      Plantago       major    ")[:scientificName][:normalized]

# to get only cleaned up latin part of the name
parser.parse("Pseudocercospora dendrobii (H.C. Burnett) U. \
Braun & Crous 2003")[:scientificName][:canonical]

# to get canonical form with infraspecies ranks
parsed = parser.parse("Seddera latifolia Hochst. & Steud. var. latifolia")
ranked = ScientificNameParser.add_rank_to_canonical(parsed)
ranked[:scientificName][:canonical]
#or
parser = ScientificNameParser.new(canonical_with_rank: true)
ranked = parser.parse("Seddera latifolia Hochst. & Steud. var. latifolia")
ranked[:scientificName][:canonical]

# to get detailed information about elements of the name
parser.parse("Pseudocercospora dendrobii (H.C. Burnett 1883) U. \
Braun & Crous 2003")[:scientificName][:details]
```

Returned result is not always linear, if name is complex. To get simple linear
representation of the name you can use:


```ruby
parser.parse("Pseudocercospora dendrobii (H.C. Burnett) \
U. Braun & Crous 2003")[:scientificName][:position]
# returns {0=>["genus", 16], 17=>["species", 26],
# 28=>["author_word", 32], 33=>["author_word", 40],
# 42=>["author_word", 44], 45=>["author_word", 50],
# 53=>["author_word", 58], 59=>["year", 63]}
# where the key is the char index of the start of
# a word, first element of the value is a semantic meaning
# of the word, second element of the value is the character index
# of end of the word
```

'Surrogate' is a broad group which includes 'Barcode of Life' names, and various
undetermined names with cf. sp. spp. nr. in them:

```ruby
parser.parse("Coleoptera BOLD:1234567")[:scientificName][:surrogate]
```
### What is "id" in the parsed results?

ID field contains UUID v5 hexadecimal string. ID is generated out of bytes
from the name string itself, and identical id can be generated using [any
popular programming language][uuid_examples]. You can read more about UUID
version 5 in a [blog post][uuid_blog]

For example "Homo sapiens" should generate "16f235a0-e4a3-529c-9b83-bd15fe722110" UUID

### Parse using several CPUs (4 threads seem to be optimal)

```ruby
parser = ParallelParser.new
# ParallelParser.new(4) will try to run 4 processes if hardware allows
array_of_names = ["Betula alba", "Homo sapiens"....]
parser.parse(array_of_names)
# Output: {"Betula alba" => {:scientificName...},
# "Homo sapiens" => {:scientificName...}, ...}
```

parallel parser takes list of names and returns back a hash with names as
keys and parsed data as values

### Canonicals with ranks for infraspecific epithets:

```ruby
parser = ScientificNameParser.new(canonical_with_rank: true)
parser.parse('Cola cordifolia var. puberula \
A. Chev.')[:scientificName][:canonical]
# Output: Cola cordifolia var. puberula
```

### Resolving lsid and geting back RDF file

    LsidResolver.resolve("urn:lsid:ubio.org:classificationbank:2232671")

Troubleshooting
---------------

If nnparse or parserver do not start -- try to run

    gem uninstall biodiversity
    gem uninstall biodiversity19

and make sure you remove all versions and all nnparse and parserver scripts.
Then install biodiversity again

    gem install biodiversity

It should fix the problem.

Copyright
---------

Authors: [Dmitry Mozzherin][dimus]

Copyright (c) 2008-2018 Dmitry Mozzherin. See [LICENSE][license]
for further details.

[gem_svg]: https://badge.fury.io/rb/biodiversity.svg
[gem_link]: http://badge.fury.io/rb/biodiversity
[ci_svg]: https://secure.travis-ci.org/GlobalNamesArchitecture/biodiversity.svg
[ci_link]: http://travis-ci.org/GlobalNamesArchitecture/biodiversity
[cc_svg]: https://codeclimate.com/github/GlobalNamesArchitecture/biodiversity.svg
[cc_link]: https://codeclimate.com/github/GlobalNamesArchitecture/biodiversity
[deps_svg]: https://gemnasium.com/GlobalNamesArchitecture/biodiversity.svg
[deps_link]: https://gemnasium.com/GlobalNamesArchitecture/biodiversity
[socket_example]: http://bit.ly/149iLm5
[dimus]: https://github.com/dimus
[license]: https://github.com/GlobalNamesArchitecture/biodiversity/blob/master/LICENSE
[waffle]: https://waffle.io/GlobalNamesArchitecture/biodiversity
[uuid_examples]: https://github.com/GlobalNamesArchitecture/gn_uuid_examples
[uuid_blog]: http://globalnamesarchitecture.github.io/gna/uuid/2015/05/31/gn-uuid-0-5-0.html
