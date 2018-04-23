
BStr = require('../src/bumble-strings')

debugger

TEST_STRINGS = [{
  input: "Bob went to the store"
  expected: "bob-went-to-the-store"
  why: "Should have converted the whole string to lower case and replaced all spaces with dashes"
  
},{
  input: "someLowerCamelCasedThing"
  expected: "some-lower-camel-cased-thing"
  why: "Should have converted lower camel case to dashes"
},{
  input: "SomeUpperCamelCasedThing"
  expected: "some-upper-camel-cased-thing"
  why: "Should have converted lower camel case to dashes"
}]

describe "dasherize()", ->

  it "should dasherize", ->  
    for testString in TEST_STRINGS
      output = BStr.dasherize(testString.input)
      expect(output).to.equal(testString.expected, testString.why)
    
  