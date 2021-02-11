class Fixnum
  def czynniki
    wynik = []
    for i in 1..self
      if self % i == 0
        wynik.append(i)
      end
    end
    return wynik
  end
  def ack(m)
    if self == 0
      return m + 1
    end
    if m == 0
      return (self-1).ack(1)
    end
    return (self-1).ack(self.ack(m-1))
  end
  def doskonala
    pom = self.czynniki
    wynik = 0
    for e in pom
      wynik += e
    end
    wynik -= pom[-1]
    if wynik == self
      return true
    end
    return false
  end
  def slownie
    slownik = {1 => "jeden ", 2 => "dwa ", 3 => "trzy ", 4 => "cztery ", 5 => "piec ", 6 => "szesc ", 7 => "siedem ", 8 => "osiem ", 9 => "dziewiec "}
    pom = self
    wynik = ""
    if self == 0
      return "zero"
    end
    while pom > 0
      wynik = slownik[pom % 10] + wynik
      pom /= 10
    end
    return wynik
  end
end

print 6.czynniki
print "\n"
print 2.ack(1)
print "\n"
print 6.doskonala
print "\n"
print 15.doskonala
print "\n"
print 123.slownie
print "\n"

