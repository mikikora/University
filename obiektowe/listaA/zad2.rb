class Kolekcja
  class Lista
    class Node
      def initialize(val, key)
        @val  = val
        @key = key
        @right = nil
        @left = nil
      end
      def SetRight(a)
        @right = a
      end
      def SetLeft(a)
        @left = a
      end
      def GetRight
        @right
      end
      def GetLeft
        @left
      end
      def GetVal
        @val
      end
      def SetKey(k)
        @key = k
      end
      def GetKey
        @key
      end
    end
    def initialize
      @lista = Node.new(0,-1)
      @leangth = 0
    end
    def add(x)
      @leangth = @leangth + 1
      k = -1
      lista = @lista
      while not lista.GetRight.nil? and lista.GetRight.GetVal < x
        lista = lista.GetRight
      end
      pom = Node.new(x, k)
      pom.SetLeft(lista)
      pom.SetRight(lista.GetRight)
      lista.SetRight(pom)
      lista = pom.GetRight
      while not lista.nil? and not lista.GetRight.nil?
        lista.SetKey(lista.GetKey + 1)
        lista = lista.GetRight
      end
    end
    def GetVal(n)
      lista = @lista
      for i in 0..n
        # puts lista.GetVal
        lista = lista.GetRight
      end
      # puts n
      return lista.GetVal
    end
    def length
      @leangth
    end
  end
  def initialize
    @list = Lista.new
  end
  def add(x)
    @list.add(x)
  end
  def get(n)
    @list.GetVal(n)
  end
  def length
    @list.length
  end
end

class Wyszukiwanie
  def BinSearch(kol, x)
    left = 0
    right  = kol.length
    while left < right
      s = (left + right) / 2
      if kol.get(s) < x
        left = s + 1
      else
        right = s
      end
    end
    return left
  end
  def Interpolacyjne(kol, x)
    left = 0
    right = kol.length - 1
    while left < right
      s = left + ((x - kol.get(left)*(right - left)/(kol.get(right) - kol.get(left))))
      if kol.get(s) != x
        if kol.get(s) < x
          right = s - 1
        else
          left = s + 1
        end
      else
        return s
      end
    end
    return -1
  end
end

kol = Kolekcja.new
for i in 3..15
  kol.add(i)
end
w = Wyszukiwanie.new
puts "\n", w.BinSearch(kol, 7), "\n"
puts w.Interpolacyjne(kol, 13)
