class Funkcja
  def initialize(&function)
    @function = function
  end
  def value(x)
    return @function.call(x)
  end
  def zerowe(a,b,e)
    wynik = []
    f = a + e
    while f <= b
      if (self.value(f) < 0) != (self.value(f-e) < 0)
        wynik.append(f)
      end
      f += e
    end
    return wynik
  end
  def pole(a,b)
    wynik = 0
    epsilon = 0.001
    e = a + epsilon
    while e <= b
      wynik += e * self.value(e)
      e += epsilon
    end
    return wynik
  end
  def poch(x)
    h = 0.001
    return (self.value(x+h) - self.value(x)) / h
  end
  def rysuj
    file = File.open("dane.dat", "w")
    x = -15
    e = 0.01
    while x < 15
      file.puts(x.to_s + " " + self.value(x).to_s)
      x += e
    end
    file.close
  end
end


f = Funkcja.new{ |x| x*x*Math.tan(x)}
puts f.value(5)
puts f.zerowe(0,10,0.001)
puts f.pole(0,10)
puts f.poch(5)
f.rysuj
