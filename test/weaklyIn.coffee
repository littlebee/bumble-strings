
BStr = require('../src/bumble-strings')

debugger


describe "weaklyIn()", ->
  it "should find a strong match when there is only one", ->
    assert BStr.weaklyIn("dog", ["cat", "kitten", "dog"])
    
  it "should find a weak match when there is only one", ->
    assert BStr.weaklyIn("dog", ["cat", "kitten", "  Dog"]), "it should have igored spaces and capitalization"
    
  it "should not find a match when there are none", ->
    assert !BStr.weaklyIn("dog", ["cat", "kitten", "Puppy"])
    
    