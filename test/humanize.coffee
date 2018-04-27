
BStr = require('../src/bumble-strings')

debugger

TEST_STRINGS = [{
  input: "bob-went-to_the_store"
  expected: "bob went to the store"
  why: "Should have removed all dashes and underscores"
  
}]

describe "humanize()", ->

  it "should humanize", ->  
    for testString in TEST_STRINGS
      output = BStr.humanize(testString.input)
      expect(output).to.equal(testString.expected, testString.why)
    
  