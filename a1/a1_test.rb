require "./a1/a1"
require "test/unit"

class A1Test < Test::Unit::TestCase
  def setup
    # Testdaten fuer die Naeherungsformeln
    @eps1 = 15.00000000000001 # n=0, a = 4, x = 2
    @a1 = 4; @x1=2; @n1 = 0
    @eps2 = 1.7763568394002509e-15 # n=22, a=3, x =2
    @a2 = 3; @x2 = 2;  @n2 = 22
    @eps3 = 1e-26 # a=2, x=3, n=22 (it), n=23(rek)
    @a3 = 2; @x3 = 3; @n3 = 22; @n3_rek=23
    # Testdaten fuer geschachtelte Arrays
    @ary0 = []
    @out0  = [0, []]
    @ary1 = [2,3,4]
    @ary2 = [1,[2,3,4]]
    @out1_2 = [3, [2, 3, 4]]
    @ary3 = [5,[6],[7,8,9],10,11]
    @ary4 = [[5,[6],[7,8,9],10,11]]
    @ary5 = [[[5,[6],[7,8,9],10,11]]]
    @ary6 = [[1,[2,3,4]],[[[5,[6],[7,8,9],10,11]]]]
    @out3_6 = [5, [5, [6], [7, 8, 9], 10, 11]]
    # Testdaten fuer geschachtelte Hashes
    @h0 = {}
    @h_a0 = []
    @h1 = {12 => 13, 14=>15}
    @h_a1 = [[12, 13], [14, 15]]
    @h2 = {11=> {12 => 13, 14=>15}, 16=>17}
    @h_a2 = [[11, [[12, 13], [14, 15]]], [16, 17]]
    @h3 = {10=> {11=> {12 => 13}}}
    @h_a3= [[10, [[11, [[12, 13]]]]]]
    @h4 = {8=>{10=> {11=> {12 => 13}}}}
    @h_a4= [[8, [[10, [[11, [[12, 13]]]]]]]]
    @h5 = { 2 => 7,
      1 =>{2 => {3 => {4 => {7 => 9}, 5=> {8=>{10=> {11=> {12 => 13}}}}}}},
      3 => {{2 => {17 => {15 => {21 => 9}, 23=> {8=>{10=> {1=> {2 => 3}}}}}}} =>{1=> 8}}}
    @h_a5 = [[2, 7], [1, [[2, [[3, [[4, [[7, 9]]], [5, [[8, [[10, [[11, [[12, 13]]]]]]]]]]]]]]], [3, [[[[2, [[17, [[15, [[21, 9]]], [23, [[8, [[10, [[1, [[2, 3]]]]]]]]]]]]]], [[1, 8]]]]]]
    @h6 = {{{}=>{}}=>{{}=>{}}}
    @h_a6 = [[[[[], []]], [[[], []]]]]
  end

  def test_f_it()
    assert_in_epsilon(@a1**@x1,f_it(@a1,@x1,@n1),@eps1, "Berechnung falsch für den Startwert")
    assert_in_epsilon(@a2**@x2,f_it(@a2,@x2,@n2),@eps2, "Berechnung nicht genau genug")
    assert_in_epsilon(@a3**@x3,f_it(@a3,@x3,@n3),@eps3, "Berechnung nicht genau genug")
  end

  def test_f_rek()
    assert_in_epsilon(@a1**@x1,f_rek(@a1,@x1,@n1),@eps1, "Berechnung falsch für den Startwert")
    assert_in_epsilon(@a2**@x2,f_rek(@a2,@x2,@n2),@eps2, "Berechnung nicht genau genug")
    assert_in_epsilon(@a3**@x3,f_rek(@a3,@x3,@n3_rek),@eps3, "Berechnung nicht genau genug")
  end

  def test_n_fuer_eps()
    assert_equal(@n3,n_fuer_eps(@a2,@x2,@eps2), "Naeherung ist nicht genau genug")
  end

  def test_array_max_with_size
    assert_equal(@out0,@ary0.max_with_size())
    assert_equal(@out1_2,@ary1.max_with_size())
    assert_equal(@out1_2,@ary2.max_with_size())
    assert_equal(@out3_6,@ary3.max_with_size())
    assert_equal(@out3_6,@ary4.max_with_size())
    assert_equal(@out3_6,@ary5.max_with_size())
    assert_equal(@out3_6,@ary6.max_with_size())
  end

  def test_hash_deep_to_a()
    assert_equal(@h_a0,@h0.deep_to_a())
    assert_equal(@h_a1,@h1.deep_to_a())
    assert_equal(@h_a2,@h2.deep_to_a())
    assert_equal(@h_a3,@h3.deep_to_a())
    assert_equal(@h_a4,@h4.deep_to_a())
    assert_equal(@h_a5,@h5.deep_to_a())
    assert_equal(@h_a6,@h6.deep_to_a())
  end
end