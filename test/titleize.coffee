
BStr = require('../src/bumble-strings')

debugger

TEST_STRINGS = [{
  input: "gettysburg address"
  expected: "Gettysburg Address"
  why: "Should title case all words"
  
}]

describe "titleize()", ->

  it "should titleize", ->  
    for testString in TEST_STRINGS
      output = BStr.titleize(testString.input)
      assert output == testString.expected, testString.why
    
  