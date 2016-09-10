

BStr = require('../src/bumble-strings')

debugger





describe "Case conversions", ->

  describe "humanize(str)", ->
    it "should humanize string with underscores", ->
      BStr.humanize("Some_string_like_this").should.equal "some string like this"

    it "should humanize camel cased strings", ->
      BStr.humanize("SomeStringLikeThis").should.equal "some string like this"

  
  describe "capitalize(str)", ->
    it "should work", -> BStr.capitalize("some string like this").should.equal "Some string like this"
      

  describe "decapitalize(str)", ->
    it "should work", -> BStr.decapitalize("Some string like this").should.equal "some string like this"
      

  describe "dropcamelize(str)", ->
    it "should work", -> BStr.dropcamelize("Some String Like This").should.equal "someStringLikeThis"
      

  describe "decamelize(str)", ->
    it "should work", -> BStr.decamelize("someStringLikeThis").should.equal "some string like this"
      
    
  describe "numerize(str)", ->
    it "should should add commas", -> BStr.numerize(123456789).should.equal "123,456,789"
    it "should not add zerofilled decimal places unless asked", -> BStr.numerize(1234, 2).should.equal "1,234" 
    it "should add zerofilled decimal places if asked", -> BStr.numerize(1234, 2, true).should.equal "1,234.00" 
    
      