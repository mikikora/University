class Kolekcja
  def initialize
    @kol = []
  end
  def add(x)
    @kol.push(x)
  end
  def length
    @kol.length
  end
  def get(i)
    @kol[i]
  end
  def swap(i,j)
    t = @kol[i]
    @kol[i] = @kol[j]
    @kol[j] = t
  end
end

class Sortowanie
  def sort1(kol)
    if kol.length == 1 or kol.length == 0
      return kol
    end
    pivot = kol.get(0)
    l = Kolekcja.new()
    r = Kolekcja.new()
    for i in 1..kol.length - 1
      #puts kol.get(i)
      if kol.get(i) < pivot
        l.add(kol.get(i))
      else
        r.add(kol.get(i))
      end
    end
    s = Sortowanie.new()
    l = s.sort1(l)
    r = s.sort1(r)
    res = Kolekcja.new()
    for i in 0..l.length - 1
      res.add(l.get(i))
    end
    res.add(pivot)
    for i in 0..r.length - 1
      res.add(r.get(i))
    end
    return res
  end
  def sort2(kol)
    n = kol.length
    while n > 1
      for i in 0..n-2
        if kol.get(i) > kol.get(i+1)
          kol.swap(i,i+1)
        end
      end
      n = n - 1
    end
    return kol
  end
end


k = Kolekcja.new()
for i in 0..10
  a = rand
  k.add(a)
  puts a
end
puts k.length, "\n"
s = Sortowanie.new()
k = s.sort1(k)
for i in 0..k.length
  puts k.get(i)
end
puts k.length
