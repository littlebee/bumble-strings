
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
    
  
  ###
    Adds elipsis to string, if neccessary, for maximum string length not
    to exceed maxLength
  ###
  @elipsize: (str, maxLength) ->
    return str if !maxLength? || str.length <= maxLength
    str.slice(0, maxLength-3) + '...'
  
  ###
    Returns true if the string is all whitespace characters
  ###
  @isEmpty: (str) ->
    return true if @weaklyEqual(str, "")
    
  
  ###
    Returns true if string starts with any of otherStrings.  
    otherStrings = one or array to compare to 
  ###
  @startsWith: (str, otherStrings) ->
    @_withOneOrArray otherStrings, (otherStr) ->
      return true if str.slice(0, otherStr.length) == otherStr
    
  
  ###
    Returns true if string ends with any of otherStrings.  
    otherStrings = one or array to compare to 
  ###
  @endsWith: (str, otherStrings) ->
    @_withOneOrArray otherStrings, (otherStr) ->
      #console.log "endsWith str='#{str}'  otherStr='#{otherStr}'  slice='#{ str.slice(-1 * otherStr.length)}'", str.slice(-1 * otherStr.length) == str
      return true unless otherStr?.length > 0
      return true if str.slice(-1 * otherStr.length) == otherStr

  
  ###
    Returns true if string contains any of otherStrings.  
    otherStrings = one or array to compare to 
  ###
  @has: (str, otherStrings) ->
    @_withOneOrArray otherStrings, (otherStr) ->
      return true if str.indexOf(otherStr) != -1


  ###
    Returns the weak value of the string -- all lowercase, plus trimmed
    and with excess inner whitespace ignored, locale ignored by default. 
    
    The weakly... functions below use this method on both strings being
    compared to return positive match of mismatched case, etc.
  ###
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
    
  ###
    Returns true if the first string weakly equals any of the otherStrings. 
    see weakValue() comments
  ###  
  @weaklyEqual: (str, otherStrings, options={}) ->
    @_withOneOrArray otherStrings, (otherStr) =>
      return true if @weakValue(str, options) == @weakValue(otherStr, options)      
    
    
  ###
    Returns -1, 0 or 1 like javascript localeCompare.  Comppares the weak values.  
    see weakValue() comments
  ###  
  @weaklyCompare: (str, otherStrings, options={}) ->
    @_withOneOrArray otherStrings, (otherStr) =>
      return true if @weakValue(str, options).localeCompare(@weakValue(otherStr, options))
    
    
  ###
    Returns true if the first string weakly contains any of the otherStrings. 
    see weakValue() comments
  ###  
  @weaklyHas: (str, otherStrings) ->
    @_withOneOrArray otherStrings, (otherStr) =>
      return true if @weakValue(str).indexOf(@weakValue(otherStr)) != -1
    
    
  ###
    Returns true if the first string weakly starts with any of the otherStrings. 
    see weakValue() comments
  ###  
  @weaklyStartsWith: (str, otherStrings) ->
    @_withOneOrArray otherStrings, (otherStr) =>
      return true if @startsWith(@weakValue(str), @weakValue(otherStr))
    
    
  ###
    Returns true if the first string weakly ends with any of the otherStrings. 
    see weakValue() comments
  ###  
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
  