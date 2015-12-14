
_ = require('underscore')

module.exports = class StringHelpers
  
  @trim: (str) -> 
    return str.replace(/^\s+|\s+$/g, "")
  
  @startsWith: (str, otherStr) ->
    return str.slice(0, otherStr.length) == otherStr
  
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
    
    
  