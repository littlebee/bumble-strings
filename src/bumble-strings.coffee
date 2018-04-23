
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
  @weaklyCompare: (str, otherStr, options={}) ->
    return @weakValue(str, options).localeCompare(@weakValue(otherStr, options))
    
  
  @weaklyIn: (str, otherStrings, options={}) ->
    __withOneOrArray otherStrings, (otherStr) =>
      @weaklyEqual(str, otherStr, options)

    
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
    
    
  ###
    makes strings like "this_string", "ThisString", "this-string", "this.string" into
    "this string"
  ###
  @humanize: (str) ->
    out = str
    .replace(/([A-Z])/g, " $1")
    .replace(/[_\-\.](.)/g, " $1")
    
    return @trim(out).toLowerCase()

  ###
    makes "this is a string" into "this-is-a-string"
    (stolen from underscore.string)
  ###
  @dasherize: (str) ->
    # fixed from underscore.string: only add dash before upper case letter if not the first letter 
    @trim(str).replace(/(.)([A-Z])/g, '$1-$2').replace(/[-_\s]+/g, '-').toLowerCase()
  

  ###  
    converts a string like "dropCamelCase".decamelize() => "Drop Camel Case"
  ###
  @decamelize: (str) ->
    result = str.replace( /_?([A-Z])/g, " $1" );
    result = result.charAt(0).toUpperCase() + result.slice(1);
    return result.toLowerCase()

  ###
    converts a string like "Drop Camel Case".dropcamelize() => "dropCamelCase"
  ###
  @dropcamelize: (str) ->
    result = str.replace( /\s/g, "" );
    return result.charAt(0).toLowerCase() + result.slice(1);


  ###
    capitalize the first letter of a string
  ###
  @capitalize: (str) ->
    str.charAt(0).toUpperCase() + str.substring(1);


  ###
    decapitalize the first letter of a string
  ###
  @decapitalize: (str) ->
    str.charAt(0).toLowerCase() + str.substring(1);


  @titleize: (str) ->
    str.toString().toLowerCase().replace /(?:^|\s|-)\S/g, (c) ->
      c.toUpperCase();


  ###
    returns true if the first letter of a string is capitalized
  ###
  @isCapitalized: (str) ->
    str.match(/^[A-Z].*/) != null


  ###
    returns true if all alphabetic characters of string are upper case letters.
    ignores numbers and punctuation
  ###
  @isAllCaps: (str) ->
    str.match(/^[A-Z\s0-9]*$/) != null


  ###
    returns true if string is numeric
  ###
  @isNumeric: (str) ->
    return str.toString().match(/^[\-,\+]?[\s\d\.]*$/) != null


  ###
    adds thousands separaters optionally truncates decimal portion to decimalPlaces characters
    slightly enhanced from
    http://stackoverflow.com/questions/2901102/how-to-print-a-number-with-commas-as-thousands-separators-in-javascript
  ###
  @numerize: (str, decimalPlaces=null, zeroFill=false) ->
    if decimalPlaces
      pow = Math.pow(10, decimalPlaces)
      parts = (Math.round(parseFloat(str) * pow) / pow).toString().split(".")
    else
      parts = str.toString().split('.')

    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");

    if decimalPlaces
      if parts.length > 1
        parts[1] = parts[1].slice(0, decimalPlaces)
        if zeroFill
          parts[1] += '0' while parts[1].length < decimalPlaces
      else if zeroFill
        parts.push(Array(decimalPlaces+1).join('0'))
    
    return parts.join(".")
      
    
  @_withOneOrArray: (strOrArray, fn) ->
    array = if _.isArray(strOrArray) then strOrArray else [strOrArray]
    truth = false
    for str in array
      if fn(str) == true
        truth = true
        break
              
    return truth
  