require_relative "./a3"

def generiere_welt(n,m)
  # Anzahl der maxi
  #r_n = 4
  welt = Welt.new(n,m)
  # generiere Raeume
  for i in 0...n
    for j in 0...m
      raum = Raum.new()
      #  Es werden zufaellig Gegenstaende erzeugt und in die Raeume eingetragen
      a_g = rand(0..4)
      gegenstaende = []
      for k in 0...a_g
        gegenstaende << Gegenstand.new(rand(1..3),rand(1..4))
      end
      while !gegenstaende.empty?()
        raum.instance_variable_get(:@gegenstaende) << gegenstaende.pop()
      end
      welt.instance_variable_get(:@flaeche)[i][j]=raum
    end
  end
  File.open("a3/test_welt",'w'){|test_welt|
    Marshal.dump(welt,test_welt)
  }
end

srand(100)
$N = 5
$M = 6
generiere_welt($N,$M)

def generiere_instanz_variablen(welt)
  flaeche = welt.instance_variable_get(:@flaeche)
  n = flaeche.size()
  m = flaeche[0].size()
  ary = []
  for i in 0...n
    for j in 0...m
      # erzeugt Instanzvariablen fuer alle Raeume und setzt
      # deren Wert auf den Raum an Position i,j in der Welt
      # Die Instanzvariable @r00 zeigt auf den Raum an Position 0,0
      # Die Instanzvariable @r22 zeigt auf den Raum an Position 2,2
      # Die Instanzvariable @r45 zeigt auf den Raum an Position 4,5
      instance_variable_set("@r#{i}#{j}",flaeche[i][j])
      ary<<flaeche[i][j]
    end
  end
  return ary
end
