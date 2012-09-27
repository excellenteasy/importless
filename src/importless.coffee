###
 * less-detect
 * https://github.com/excellenteasy/less-detect
 *
 * Copyright (c) 2012 David Pfahler
 * Licensed under the MIT license.
###

'use strict';

glob  = require 'glob-whatev'
fs 		= require 'fs'
less  = require 'less'
path  = require 'path'

# returns an array of filepaths of less/css files 
# in current directory (or otherwise specified)
# which are not imported in other files
exports.detectDependencies = (directories=['./']) ->
  if typeof directories is 'string' then directories = [directories]
  files = (files or []).concat(@findAll dir) for dir in directories
  files = @cssToLess files
  files = @stripImported files, @getImported(files)

# return both less and css files from directory
exports.findAll = (directory) ->
	# remove trailing slash
	if /\/$/.test(directory) then directory = directory.replace /\/$/, ''
	return glob.glob("#{directory}/**/*.{less,css}")

# returns array of filespaths where .css files are converted to .less
exports.cssToLess = (files) ->
  if typeof files is 'string' then files = [files]
  files.map((filepath) -> if /\.css$/.test(filepath) then exports.rename(filepath) else filepath)

# return filepath of renamed file (css to less) and actually rename it
exports.rename = (filepath, newPath) ->
  fs.renameSync(filepath, newPath = newPath or filepath.replace /\.css$/, '.less')
  return newPath

# returns array of imported files as filepaths
exports.getImported = (files) ->
  if typeof files is 'string' then files = [files]
  
  # track imported filepaths in array
  imported = []

  # less parser
  parser = new less.Parser

  files.forEach (filepath) ->
    dirname = path.dirname filepath
    lessSrc = fs.readFileSync(filepath, 'utf-8')
    
    parser.parse lessSrc, (err, tree) ->
      if err then throw new Error err.message
      (imported.push path.join(dirname, rule.path) if rule.path) for rule in tree.rules
  
  return imported

# return filtered array without imported files
exports.stripImported = (files, imported) ->
  files.filter (filepath) ->
    # check if filepath is in imported
    if filepath in imported then false else true