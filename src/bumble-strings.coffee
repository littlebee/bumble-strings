
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
    returns true if string starts with other string 
    
    otherStr can also be an array of other strings, returns true if any match.
  ###
  @startsWith: (str, otherStrings) ->
    @_withOneOrArray otherStrings, (otherStr) ->
      return true if str.slice(0, otherStr.length) == otherStr
    
  
  @endsWith: (str, otherStrings) ->
    @_withOneOrArray otherStrings, (otherStr) ->
      #console.log "endsWith str='#{str}'  otherStr='#{otherStr}'  slice='#{ str.slice(-1 * otherStr.length)}'", str.slice(-1 * otherStr.length) == str
      return true unless otherStr?.length > 0
      return true if str.slice(-1 * otherStr.length) == otherStr

  
  @has: (str, otherStrings) ->
    @_withOneOrArray otherStrings, (otherStr) ->
      return true if str.indexOf(otherStr) != -1


  @weakValue: (str, options={}) ->
    _.defaults options,
      ignoreCase: true
      useLocale: false
      trim: true
    if options.trim
      str = @trim(str, all: true) 
    if (options.ignoreCase) 
        if (options.useLocale) 
            str = str.toLocaleLowerCase()
        else 
            str = str.toLowerCase()
    
  @weaklyEqual: (str, otherStr, options={}) ->
    return @weakValue(str, options) == @weakValue(otherStr, options)      
    
    
  @weaklyCompare: (str, otherStr, options={}) ->
    return @weakValue(str, options).localeCompare(@weakValue(otherStr, options))
    
    
  @weaklyHas: (str, otherStrings) ->
    @_withOneOrArray otherStrings, (otherStr) =>
      return true if @weakValue(str).indexOf(@weakValue(otherStr)) != -1
    
    
  @weaklyStartsWith: (str, otherStrings) ->
    @_withOneOrArray otherStrings, (otherStr) =>
      return true if @startsWith(@weakValue(str), @weakValue(otherStr))
    
    
  @weaklyEndsWith: (str, otherStrings) ->
    @_withOneOrArray otherStrings, (otherStr) =>
      return true if @endsWith(@weakValue(str), @weakValue(otherStr))
    
    
  @_withOneOrArray: (strOrArray, fn) ->
    array = if _.isArray(strOrArray) then strOrArray else [strOrArray]
    truth = false
    for str in array
      if fn(str) == true
        truth = true
        break
              
    return truth
  