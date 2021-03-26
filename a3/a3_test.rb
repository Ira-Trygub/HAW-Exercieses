require "./a3/a3"
require "./a3/a3_helper"
require "test/unit"
require "Set"

class A3Test < Test::Unit::TestCase
  def setup
    @n0 = 7
    @m0 = 13
    @welt0 = Welt.new(@n0,@m0)
    @raum00 = Raum.new()
    @raum01 = Raum.new()
    @gegenstand0= Gegenstand.new(5,3)
    @gegenstand1= Gegenstand.new(3,2)
    @gegenstand2= Gegenstand.new(1,1)
    @gegenstand3= Gegenstand.new(2,7)

    File.open("a3/test_welt",'r') {|test_welt|
      @welt1 = Marshal.load(test_welt)
    }
    @welt1_inhalt = generiere_instanz_variablen(@welt1)

  end

  def test_raum_push()
    assert_true(@raum00.empty?())
    assert_equal(@raum00,@raum00 << @gegenstand0 <<@gegenstand1)
    assert_equal([@gegenstand0,@gegenstand1],@raum00.instance_variable_get(:@gegenstaende))
    assert_equal([],@raum01.instance_variable_get(:@gegenstaende))
  end

  def test_raum_empty?()
    @raum00.instance_variable_set(:@gegenstaende,[@gegenstand0,@gegenstand1])
    assert(!@raum00.empty?())
    assert(@raum01.empty?())
  end

  def test_raum_size()
    @raum00.instance_variable_set(:@gegenstaende,[@gegenstand0,@gegenstand1,@gegenstand2])
    assert_equal(3,@raum00.size())
    assert_equal(0,@raum01.size())
  end

  def test_raum_wertigkeit()
    @raum00.instance_variable_set(:@gegenstaende,[@gegenstand0,@gegenstand1])
    assert_equal(5,@raum00.wertigkeit())
    assert_equal(0,@raum01.wertigkeit())
  end

  def test_raum_kosten()
    @raum00.instance_variable_set(:@gegenstaende,[@gegenstand0,@gegenstand1,@gegenstand2,@gegenstand3])
    assert_equal(11,@raum00.kosten())
    assert_equal(0,@raum01.kosten())
  end

  def test_welt_setze_raum()
    i = 3; j = 3
    @welt0.setze_raum(i,j,@raum00)
    assert_equal(@raum00,@welt0.instance_variable_get(:@flaeche)[i][j])
    k = 4; l = 12
    @welt0.setze_raum(k,l,@raum01)
    assert_equal(@raum01,@welt0.instance_variable_get(:@flaeche)[k][l])
  end

  def test_welt_raum_an_position()
    i = 3; j = 3
    flaeche = @welt0.instance_variable_get(:@flaeche)
    flaeche[i][j] = @raum00
    assert_equal(@raum00,@welt0.raum_an_position(i,j))
    k = 4; l = 12
    flaeche[k][l] = @raum01
    assert_equal(@raum01,@welt0.raum_an_position(k,l))
    flaeche.each_with_index(){|korr,x|
      korr.each_with_index(){ |raum,y|
        if !((x==i&& y==j) || (x==k&&y==l))
          assert_nil(raum)
        end
      }}
  end

  def test_welt_raum_position()
    i = 3; j = 3
    flaeche = @welt0.instance_variable_get(:@flaeche)
    flaeche[i][j] = @raum00
    assert_equal([i,j],@welt0.raum_position(@raum00))
    k = 4; l = 12
    flaeche[k][l] = @raum01
    assert_equal([k,l],@welt0.raum_position(@raum01))
  end

  def test_welt_weg_kosten()
    i = 3; j = 3
    flaeche = @welt0.instance_variable_get(:@flaeche)
    flaeche[i][j] = @raum00
    assert_equal([i,j],@welt0.raum_position(@raum00))
    k = 4; l = 12
    flaeche[k][l] = @raum01
    assert_equal(10,@welt0.wegkosten(@raum00,@raum01))
    assert_equal(10,@welt0.wegkosten(@raum01,@raum00))
  end

  def test_welt_each()
    ary = []
    @welt1.each(){|raum| ary << raum}
    assert_equal(@welt1_inhalt,ary)
  end

  def test_spieler_erreichbare_ziele()
    @spieler = Spieler.new(:sp1,10,10,@r34,@welt1)
    @erreichbar_von_34_10_10 = [@r00,@r01,@r02,@r03,@r04,@r05,@r10,@r11,@r12,@r13,@r14,@r15,@r20,@r21,@r22,@r23,@r24,@r25,@r30,@r31,@r33,@r35,@r40,@r41,@r42,@r43,@r44,@r45]
    assert_equal( @erreichbar_von_34_10_10.to_set(),@spieler.erreichbare_ziele().to_set())

    @spieler = Spieler.new(:sp1,10,10,@r45,@welt1)
    @erreichbar_von_45_10_10 = [@r00,@r01,@r02,@r03,@r04,@r05,@r10,@r11,@r12,@r13,@r14,@r15,@r20,@r21,@r22,@r23,@r24,@r25,@r30,@r31,@r33,@r34,@r35,@r40,@r41,@r42,@r43,@r44]
    assert_equal( @erreichbar_von_45_10_10.to_set(),@spieler.erreichbare_ziele().to_set())

    @spieler = Spieler.new(:sp3,10,10,@r00,@welt1)
    @erreichbar_von_00_10_10 = [@r01,@r02,@r03,@r04,@r05,@r10,@r11,@r12,@r13,@r14,@r15,@r20,@r21,@r22,@r23,@r24,@r25,@r30,@r31,@r33,@r34,@r35,@r40,@r41,@r42,@r43,@r44,@r45]
    assert_equal( @erreichbar_von_00_10_10.to_set(),@spieler.erreichbare_ziele().to_set())

    @spieler = Spieler.new(:sp1,10,6,@r34,@welt1)
    @erreichbar_von_34_10_6 = [@r00,@r01,@r03,@r04,@r05,@r11,@r13,@r14,@r15,@r21,@r22,@r23,@r24,@r31,@r33,@r35,@r40,@r41,@r42,@r43,@r44]
    assert_equal( @erreichbar_von_34_10_6.to_set(),@spieler.erreichbare_ziele().to_set())

    @spieler = Spieler.new(:sp1,10,6,@r45,@welt1)
    @erreichbar_von_45_10_6 = [@r00,@r01,@r03,@r04,@r05,@r11,@r13,@r14,@r15,@r21,@r22,@r23,@r24,@r31,@r33,@r35,@r40,@r41,@r42,@r43,@r44]
    assert_equal( @erreichbar_von_45_10_6.to_set(),@spieler.erreichbare_ziele().to_set())

    @spieler = Spieler.new(:sp1,10,6,@r00,@welt1)
    @erreichbar_von_00_10_6 = [@r01,@r03,@r04,@r05,@r11,@r13,@r14,@r15,@r21,@r22,@r23,@r24,@r31,@r33,@r35,@r40,@r41,@r42,@r43,@r44]
    assert_equal( @erreichbar_von_00_10_6.to_set(),@spieler.erreichbare_ziele().to_set())

  end

  def test_spieler_optimales_ziel()
    @spieler = Spieler.new(:sp1,10,10,@r34,@welt1)
    assert_equal(@r24,@spieler.optimales_ziel())
    @spieler = Spieler.new(:sp1,10,10,@r45,@welt1)
    assert_equal(@r35,@spieler.optimales_ziel())
    @spieler = Spieler.new(:sp3,10,10,@r00,@welt1)
    assert_equal(@r10,@spieler.optimales_ziel())
  end
end