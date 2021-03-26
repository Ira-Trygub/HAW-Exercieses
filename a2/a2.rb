class Raum
  attr_reader :gegenstaende
  protected :gegenstaende
  def initialize(gegenstaende)
    @gegenstaende = gegenstaende
  end

  def clone
    g_clones = @gegenstaende.map(){|g| g.clone()}
    return Raum.new(g_clones)
  end

  # Ergänzungen nach Aufgabenstellung 15Pkt
  # TODO
  def <=> (other)
    return @gegenstaende.sort() <=> other.gegenstaende.sort()
  end

  def to_s()
    "R(#{@gegenstaende.join().strip()})"
  end
end


class Gegenstand
  attr_reader :gewicht,:lebenspunkte
  def initialize(gewicht,lebenspunkte)
    @gewicht = gewicht
    @lebenspunkte = lebenspunkte
  end

  # Ergänzungen nach Aufgabenstellung 15Pkt
  # TODO

  def <=> (other)
    return [@lebenspunkte,@gewicht] <=> [other.lebenspunkte,other.gewicht]
  end

  def to_s()
    "G(#{gewicht},#{lebenspunkte})"
  end
end


# Wird nur benötigt für die Testdaten
class Welt
  def initialize(n,m)
    @flaeche = Array.new(n){Array.new(m)}
  end
end
