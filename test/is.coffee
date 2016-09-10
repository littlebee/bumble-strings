


BStr = require('../src/bumble-strings')

debugger





describe "isCapitalized", ->
  it "should return true if passed capitalized string", ->
    BStr.isCapitalized("Capitalized string").should.equal true
    BStr.isCapitalized("capitalized String").should.equal false
    
    
describe "isNumeric", ->
  it "should return true if passed numeric string or number", ->
    BStr.isNumeric(112234).should.equal true, "numeric value"
    BStr.isNumeric("112234").should.equal true, "numeric string"
    BStr.isNumeric("-112234").should.equal true, "numeric negative string"
    BStr.isNumeric("112234    ").should.equal true, "numeric string with spaces"
    BStr.isNumeric("112234.56").should.equal true
    
  it "should return false if any alpha characters", ->
    BStr.isNumeric("112234.56a").should.equal false, 'mostly numeric with one alphabetic character'
    BStr.isNumeric("random other string").should.equal false, 'all alphabetic string'
    
    
