# gesamt  15Pkt
class Welt
  include Enumerable
  #gegeben
  def initialize(n, m)
    @flaeche = Array.new(n) {Array.new(m)}
  end

  # gegeben
  def each(&b)
    @flaeche.each() {|korridor|
      korridor.each() {|raum| b.call(raum)}
    }
  end

  # gegeben
  def to_s()
    @flaeche.map() {|korridor| korridor.join("::")}.join("\n")
  end

  # TODO setze_raum gesamt 2 Pkt
  def setze_raum(i, j, raum) #2 Pkt
    @flaeche[i][j] = raum
  end

  # TODO gesamt 2Pkt
  def raum_an_position(i, j)
    return @flaeche[i][j]
  end

  # TODO gesamt: 7 Pkt
  def raum_position(raum)
    for i in (0...@flaeche.size())
      for j in (0...@flaeche[i].size())
        if @flaeche[i][j] == raum
          return [i, j]
        end
      end
    end
  end

  # TODO gesamt: 4Pkt
  def wegkosten(raum1, raum2)
    pos1 = raum_position(raum1)
    pos2 = raum_position(raum2)
    return (pos1[0] - pos2[0]).abs() + (pos1[1] - pos2[1]).abs()
  end
end

# gesamt 15 Pkt
class Spieler
  # gegeben
  def initialize(name, lebenspunkte, tragkraft, aktueller_raum, welt)
    @name = name
    @lebenspunkte = lebenspunkte
    @tragkraft = tragkraft
    @aktueller_raum = aktueller_raum
    @welt = welt
  end

  # gegeben
  def to_s()
    "Sp(#@name,#@lebenspunkte,#@tragkraft,#@aktueller_raum)"
  end

  # TODO gesamt 9 Pkt
  def optimales_ziel()

    erreichbare_ziele().select(){|raum| !raum.empty?()}.
        max_by(){|raum| raum.wertigkeit() /
            (@welt.wegkosten(@aktueller_raum,raum)+raum.kosten())}
  end

  # TODO gesamt 6 Pkt
  def erreichbare_ziele()

    @welt.find_all() {|raum|
      raum != @aktueller_raum && @tragkraft >= raum.kosten() &&
      @lebenspunkte >= @welt.wegkosten(@aktueller_raum, raum)
    }
  end

end

# gesamt 10 Pkt
class Raum
  include Enumerable
  # gegeben
  def initialize()
    @gegenstaende = Array.new()
  end

  # gegeben Iteriert ueber die Gegenstaende des Raumes
  def each(&b)
    @gegenstaende.each(&b)
  end

  #gegeben
  def to_s()
    "R(#{@gegenstaende.join().strip()})"
  end

  # TODO 2 Pkt
  def <<(gegenstand)
    @gegenstaende << gegenstand
    return self
  end

  # TODO 1Pkt
  def size()
    @gegenstaende.size()
  end

  # TODO berechnet die Summe der Gewichte der enthaltenen Gegenstaende
  # 3 Pkt
  def kosten()
    return self.inject(0) {|gewichte, gstd| gewichte + gstd.gewicht()}
  end

  # TODO berechnet die Summe der Lebenspunkte der enthaltenen Gegestaende
  # 3 Pkt
  def wertigkeit()
    return self.inject(0) {|lbpkt, gstd| lbpkt + gstd.lebenspunkte()}
  end

  # TODO 1Pkt
  def empty?()
    return @gegenstaende.empty?()
  end

end

class Gegenstand
  attr_reader :gewicht, :lebenspunkte

  def initialize(gewicht, lebenspunkte)
    @gewicht = gewicht
    @lebenspunkte = lebenspunkte
  end

  def to_s()
    "G(#{gewicht},#{lebenspunkte})"
  end
end


