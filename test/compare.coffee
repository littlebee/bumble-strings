
BStr = require('../src/bumble-strings')

debugger

# test value with extra spaces everywhere and imbedded uppercased word
MY_DOG = "  My dog,  Tommy,  is a    really smart  dog. "
STRONG_HAS = MY_DOG.slice(6, 15)
WEAK_HAS = BStr.trim(MY_DOG.slice(6, 20), all: true)

NON_MATCHING = ["smart cat", "smart unicorn.", "Somthing completely different"]

describe "compare()", ->
  it 'should return -1 when string is less than the other string', ->
    BStr.weaklyCompare("betty", "wilma").should.equal -1
  it 'should return 1 when strings is greater than the other string', ->
    BStr.weaklyCompare("fred", "barney").should.equal 1
  it 'should return 0 when two strings are equal', ->
    BStr.weaklyCompare("dino", "dino").should.equal 0
  