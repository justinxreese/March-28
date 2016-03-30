class Numeral
    def roman_to_int(str)
      {
        'I' => 1,
        'II' => 2,
        'X' => 10,
        'V' => 5
      }[str.upcase]
    end

    def method_missing(methId)
      str = methId.id2name
      roman_to_int(str)
    end
end

class Numeral
  (1..20).each do |n|
    define_method('n'+n.to_s) do
      {
        1 => 'I', 2 => 'II', 3 => 'III', 5 => 'V'
      }.fetch(n, "The roman numeral for #{n} hasn\'t been defined yet")
    end
  end
end
