#!/usr/bin/ruby

##
## Adam Shannon
## CS 3150
## Homework #2
##
require 'securerandom'

## Steps
## [x] 1. Read n input files, verify they're readable, otherwise print usage statement.
## [ ] 2. Generate inverted index list for the tokens in the documents
##    [ ] 1. Parse cli flags for sibjective heuristics for the dictionary generation. (Stemming)
##    [ ] 2. Lowercase and strip punctuation.
## [ ] 3. Open Output file, called document.pidx
## [ ] 4. Write output file in format given below.

USAGE_STATEMENT = <<EOF
USAGE
This program is desinged to create an inverted positional index of a series of given input files.

  $ ./hw2.rb [FLAGS] [FILE ...]

FLAGS
  --help, -h  Displays this help message

  --stemming=porters,none (default)
EOF

def parse_command_args()
  args = ARGV
  pretty_args = {
    :help => false,
    :stemming => :none,
    :files => []
  }
  args.each { |a|
    arg = a.downcase

    if (arg.include?("--help") || arg.include?("-h"))
      pretty_args[:help] = true
    elsif (arg.include?("--stemming"))
      if (arg.include?("porter"))
        pretty_args[:stemming] = :porters
      end
    else
      if (File.exists?(arg) and File.readable?(arg))
        pretty_args[:files].push arg
      elsif (arg.include?("-"))
        raise "Invalid command line arg: #{arg}."
      else
        raise "Non Readable file: #{arg}."
      end
    end
  }
  pretty_args
end

def read_files_or_quit(files)
  files.map { |filename|
    {
      :id => SecureRandom.uuid,
      :filename => filename,
      :data => File.read(filename)
    }
  }
end

def clean_word(word)
  word.downcase.gsub(/[^a-z0-9]/, '')
end

# Taken from: http://tartarus.org/martin/PorterStemmer/def.txt
PORTERS_REPLACEMENTS_STEP1 = {
  'sses' => 's',
  'ies' => 'i',
  'ss' => 'ss',
  's' => ''
}

PORTERS_REPLACEMENTS_STEP2 = {
  'ational' =>'ate',
  'tional' => 'tion',
  'enci' => 'ence',
  'anci' => 'ance',
  'izer' => 'ize',
  'bli' => 'ble',
  'alli' => 'al',
  'entli' => 'ent',
  'eli' => 'e',
  'ousli' => 'ous',
  'ization' => 'ize',
  'ation' => 'ate',
  'ator' => 'ate',
  'alism' => 'al',
  'iveness' => 'ive',
  'fulness' => 'ful',
  'ousness' => 'ous',
  'aliti' => 'al',
  'iviti' => 'ive',
  'biliti' => 'ble',
  'logi' => 'log'
}

PORTERS_REPLACEMENTS_STEP3 = {
  'icate' => 'ic',
  'ative' => '',
  'alize' => 'al',
  'iciti' => 'ic',
  'ical' => 'ic',
  'ful' => '',
  'ness' => ''
}

def porters_algorithm(word)
  if word.length > 1
    step_1 = perform_porters_step(word, PORTERS_REPLACEMENTS_STEP1)
    step_2 = perform_porters_step(step_1, PORTERS_REPLACEMENTS_STEP2)
    perform_porters_step(step_2, PORTERS_REPLACEMENTS_STEP3)
  else
    word
  end
end

def perform_porters_step(word, replacements)
  result = word
  replacements.each do |needle, replacement|
    if word.end_with?(needle)
      result = word.chomp(needle) + replacement
    end
  end
  result
end

def apply_stemming(word, stemming_type)
  if (stemming_type == :porters)
    porters_algorithm(word)
  else
    word
  end
end

def generate_inverted_index(file_contents, stemming_type)
  stemmed_words = file_contents.split.map { |w|
    apply_stemming(clean_word(w), stemming_type)
  }.reject { |w| w.empty? }

  ## Poor man's mutable Foldable
  grouped_terms = {}
  stemmed_words.each_with_index { |token, i|
    if grouped_terms.has_key?(token)
      grouped_terms[token].push i
    else
      grouped_terms[token] = [i]
    end
  }
  grouped_terms
end

## Basic Return Structure
## [
##   {
##     :term => "",
##     :documents => [{:documentId => "", :positions => [0]}]
##   }
## ]
def merge_individitual_inverted_indexes(files_with_indexes)
  ## For now, just map over everything, gonna be O(D * T) [Net Document Vocab * Net Token Count]
  positional_index = []

  files_with_indexes.reject { |f| f == nil }.each { |file|
    file[:inverted_index].each { |token, positions|
      maybe_existing_positional_idx = positional_index.find_index { |pos_index|
        pos_index[:term] == token
      }

      updated_positional_index =
      if maybe_existing_positional_idx
        pos_idx = positional_index[maybe_existing_positional_idx]
        updated = {
          :term => token,
          :documents => pos_idx[:documents].push = {
            :documentId => file[:id],
            :positions => pos_idx[:positions].push(positions)
          }
        }
        positional_index[maybe_existing_positional_idx] = updated
      else
        updated = {
          :term => token,
          :documents =>
          [
           {
             :documentId => file[:id],
             :positions => positions
           }
          ]
        }
        positional_index.push(updated)
      end
    }
  }
  positional_index
end

def write_positional_indexes(positional_index)
  outfile = File.open("document.pidx", "w")
  positional_index.each { |term_obj|
    outfile.write("#{term_obj[:term]}, #{term_obj[:documents].length}.\n")
    term_obj[:documents].each { |doc|
      outfile.write("     #{doc[:documentId]}, #{doc[:positions].length}: #{doc[:positions]};\n")
    }
    outfile.write("\n")
  }
  outfile.close()
end

def initialize_program()
  parsed_args = parse_command_args()
  if parsed_args[:help]
    puts USAGE_STATEMENT
    return
  else
    files = read_files_or_quit(parsed_args[:files])

    files_with_indexes = files.map { |file|
      file.merge ({
        :inverted_index => generate_inverted_index(file[:data], parsed_args[:stemming])
      })
    }

    ## Merge all files positional indexes into one.
    positional_index = merge_individitual_inverted_indexes(files_with_indexes)

    ## Write the positional index to a file.
    write_positional_indexes(positional_index)
  end
end

initialize_program()
