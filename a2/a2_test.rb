require "./a2/a2"
require "./a2/a2_helper"
require "test/unit"
require "Set"

class A2Test < Test::Unit::TestCase
  def setup
    File.open("a2/test_welt",'r') {|test_welt|
      @welt1 = Marshal.load(test_welt)
    }

    @welt1_inhalt = generiere_instanz_variablen(@welt1)
    @set = Set.new([@r00,@r04,@r15,@r34,@r45,@r21])
    @to_be_sorted = [@r02,@r10,@r11,@r22,@r34,@r35]
    @sorted = [@r34,@r11,@r02,@r10,@r35,@r22]  
  end

  def test_gleich_und_nicht_identisch()
    assert_equal(@r00.clone(),@welt1.instance_variable_get(:@flaeche)[0][0])
    assert_not_same(@r00.clone(),@welt1.instance_variable_get(:@flaeche)[0][0])
    r00_clone_g = @r00.clone().instance_variable_get(:@gegenstaende)
    r00_g =@welt1.instance_variable_get(:@flaeche)[0][0].instance_variable_get(:@gegenstaende)
    assert_not_same(r00_clone_g,r00_g)
    r00_clone_g.each_with_index(){|gegen00_clone,i|
      assert_not_same(gegen00_clone, r00_g[i])
    }
    assert_equal(@r04.clone(),@welt1.instance_variable_get(:@flaeche)[0][4])
    assert_not_same(@r04.clone(),@welt1.instance_variable_get(:@flaeche)[0][4])
    r04_clone_g = @r04.clone().instance_variable_get(:@gegenstaende)
    r04_g =@welt1.instance_variable_get(:@flaeche)[0][4].instance_variable_get(:@gegenstaende)
    assert_not_same(r04_clone_g,r04_g)
    r04_clone_g.each_with_index(){|gegen04_clone,i|
      assert_not_same(gegen04_clone, r04_g[i])
    }
    assert_equal(@r15.clone(),@welt1.instance_variable_get(:@flaeche)[1][5])
    assert_not_same(@r15.clone(),@welt1.instance_variable_get(:@flaeche)[1][5])
    r15_clone_g = @r15.clone().instance_variable_get(:@gegenstaende)
    r15_g =@welt1.instance_variable_get(:@flaeche)[1][5].instance_variable_get(:@gegenstaende)
    assert_not_same(r15_clone_g,r15_g)
    r15_clone_g.each_with_index(){|gegen15_clone,i|
      assert_not_same(gegen15_clone, r15_g[i])
    }
    assert_equal(@r34.clone(),@welt1.instance_variable_get(:@flaeche)[3][4])
    assert_not_same(@r34.clone(),@welt1.instance_variable_get(:@flaeche)[3][4])
    r34_clone_g = @r34.clone().instance_variable_get(:@gegenstaende)
    r34_g =@welt1.instance_variable_get(:@flaeche)[3][4].instance_variable_get(:@gegenstaende)
    assert_not_same(r34_clone_g,r34_g)
    r34_clone_g.each_with_index(){|gegen34_clone,i|
      assert_not_same(gegen34_clone, r34_g[i])
    }
    assert_equal(@r45.clone(),@welt1.instance_variable_get(:@flaeche)[4][5])
    assert_not_same(@r45.clone(),@welt1.instance_variable_get(:@flaeche)[4][5])
    r45_clone_g = @r45.clone().instance_variable_get(:@gegenstaende)
    r45_g =@welt1.instance_variable_get(:@flaeche)[4][5].instance_variable_get(:@gegenstaende)
    assert_not_same(r45_clone_g,r45_g)
    r45_clone_g.each_with_index(){|gegen45_clone,i|
      assert_not_same(gegen45_clone, r45_g[i])
    }
    assert_equal(@r21.clone(),@welt1.instance_variable_get(:@flaeche)[2][1])
    assert_not_same(@r21.clone(),@welt1.instance_variable_get(:@flaeche)[2][1])
    r21_clone_g = @r21.clone().instance_variable_get(:@gegenstaende)
    r21_g =@welt1.instance_variable_get(:@flaeche)[2][1].instance_variable_get(:@gegenstaende)
    assert_not_same(r21_clone_g,r21_g)
    r21_clone_g.each_with_index(){|gegen21_clone,i|
      assert_not_same(gegen21_clone, r21_g[i])
    }
  end

  def test_finde_in_ary()
    assert(@welt1_inhalt.include?(@r00.clone()))
    assert(@welt1_inhalt.include?(@r04.clone()))
    assert(@welt1_inhalt.include?(@r15.clone()))
    assert(@welt1_inhalt.include?(@r34.clone()))
    assert(@welt1_inhalt.include?(@r45.clone()))
    assert(@welt1_inhalt.include?(@r21.clone()))
  end

  def test_keine_dubletten_in_mengen()
    assert_nil(@set.add?(@r00.clone()))
    assert_nil(@set.add?(@r04.clone()))
    assert_nil(@set.add?(@r15.clone()))
    assert_nil(@set.add?(@r34.clone()))
    assert_nil(@set.add?(@r45.clone()))
    assert_nil(@set.add?(@r21.clone()))
  end
  
  
  def test_sortieren()
    assert_equal(@sorted,@to_be_sorted.sort())
  end
end