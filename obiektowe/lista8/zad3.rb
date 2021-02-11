class Jawna
  def initialize(napis)
    @napis = napis
  end
  def to_s
    return @napis
  end
  def zaszyfruj(klucz)
    wynik = ""
    @napis.each_char {|c| wynik += klucz[c]}
    return Zaszyfrowane.new(wynik)
  end
end

class Zaszyfrowane
  def initialize(napis)
    @napis = napis
  end
  def to_s
    return @napis
  end
  def odszyfruj(klucz)
    wynik = ""
    @napis.each_char do |c|
      for e in klucz
        if klucz[e[0]] == c
          wynik += e[0]
        end
      end
    end
    return Jawna.new(wynik)
  end
end

jawne = Jawna.new("ruby")
print jawne.to_s
print "\n"

klucz = {}
i = 0
alfabet = "xyzabcdefghijklmnopqrstuvw"
for e in 'a'..'z'
  klucz[e] = alfabet[i]
  i += 1
end
print klucz
print "\n"

print jawne.zaszyfruj(klucz).to_s
print "\n"

zaszyfrowane = jawne.zaszyfruj(klucz)

print zaszyfrowane.odszyfruj(klucz).to_s
print "\n"


