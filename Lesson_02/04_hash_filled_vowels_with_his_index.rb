vowels = %i[a e i o u]
alphabet = (:a..:z).to_a

vowels.map { |vowel| [vowel, alphabet.index(vowel) + 1] }.to_h
