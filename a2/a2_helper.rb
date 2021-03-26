require_relative "./a2"

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
