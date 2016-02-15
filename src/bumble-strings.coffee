
_ = require('underscore')

module.exports = class StringHelpers
  
  ###
    Trims leading and trailing spaces.  Also optionally trims internal excess spaces 
  ###
  @trim: (str, options={}) -> 
    options = _.defaults options,
      # if true trim excess spaces too.
      all: false
    str = str.replace(/^\s+|\s+$/g, "")
    str = str.replace(/\s+/g, ' ') if options.all
    return str
    
  
  
  @elipsize: (str, maxLength) ->
    return str if !maxLength? || str.length <= maxLength
    str.slice(0, maxLength-3) + '...'
  
  
  ###
    otherStr can also be an array of other strings
  ###
  @startsWith: (str, otherStr) ->
    otherStrings = if _.isArray(otherStr) then otherStr else [otherStr]
    for testString in otherStrings
      return true if str.slice(0, testString.length) == testString
    
    return false
  
  
  @endsWith: (str, otherString) ->
    return str.slice(-otherString.length) == str

  
  @has: (str, otherStr) ->
    str.indexOf(otherStr) != -1


  @weakValue: (str, options={}) ->
    _.defaults options,
      ignoreCase: true
      useLocale: false
      trim: true
    if options.trim
      str = @trim(str) 
    if (options.ignoreCase) 
        if (options.useLocale) 
            str = str.toLocaleLowerCase()
        else 
            str = str.toLowerCase()
    
  @weaklyEqual: (str, otherStr, options={}) ->
    return @weakValue(str, options) == @weakValue(otherStr, options)      
    
    
  @weaklyCompare: (str, otherStr, options={}) ->
    return @weakValue(str, options).localeCompare(@weakValue(otherStr, options))
    
    
  @weaklyHas: (str, otherStr) ->
    return @weakValue(str).indexOf(@weakValue(otherStr)) != -1
    
    
  @weaklyStartsWith: (str, otherStr) ->
    return @startsWith(@weakValue(str), @weakValue(otherStr))
    
    
  @weaklyEndsWith: (str, otherStr) ->
    return @endsWith(@weakValue(str), @weakValue(otherStr))
    
    
    
  