"use strict"
importless = require '../src/importless'
fs             = require 'fs'
_              =  require('grunt').util._


#
#  ======== A Handy Little Nodeunit Reference ========
#  https://github.com/caolan/nodeunit
#
#  Test methods:
#    test.expect(numAssertions)
#    test.done()
#  Test assertions:
#    test.ok(value, [message])
#    test.equal(actual, expected, [message])
#    test.notEqual(actual, expected, [message])
#    test.deepEqual(actual, expected, [message])
#    test.notDeepEqual(actual, expected, [message])
#    test.strictEqual(actual, expected, [message])
#    test.notStrictEqual(actual, expected, [message])
#    test.throws(block, [error], [message])
#    test.doesNotThrow(block, [error], [message])
#    test.ifError(value)
#

exports['findAll'] =
  setUp: (next) ->
    next()
  tearDown: (next) ->
    next()
  'return files from "test" directory with trailing slash': (test) ->
    test.expect 1
    actual = _.sortBy importless.findAll("test/files/")
    expected = _.sortBy ['test/files/imported.less', 'test/files/test.less', 'test/files/test2.css']
    test.deepEqual actual, expected
    test.done()

exports['rename'] =
  setUp: (next) ->
    fs.writeFileSync 'test/files/example.css', fs.readFileSync 'test/files/test2.css'
    next()
  tearDown: (next) ->
    fs.unlink 'test/files/example.less'
    next()
  'renames .css file to .less': (test) ->
    test.expect 1
    importless.rename 'test/files/example.css'
    test.ok fs.existsSync('test/files/example.less'), 'files was renamed'
    test.done()

exports['cssToLess'] =
  setUp: (next) ->
    fs.writeFileSync 'test/files/example.css', fs.readFileSync 'test/files/test2.css'
    next()
  tearDown: (next) ->
    if fs.existsSync 'test/files/example.less' then fs.unlink 'test/files/example.less'
    if fs.existsSync 'test/other/file.ending' then fs.unlink 'test/other/file.ending'
    next()
  'renames .css file to .less and return correct filepath': (test) ->
    test.expect 2
    test.equal importless.rename('test/files/example.css'), 'test/files/example.less'
    test.ok fs.existsSync('test/files/example.less'), 'files was renamed'
    test.done()

exports['getImported'] =
  'returns array of imported filepaths': (test) ->
    test.expect 1
    actual = _.sortBy importless.getImported(['test/files/test.less'])
    expected = _.sortBy ['test/files/whereever/someLessFile.less', 'test/files/imported.less', 'test/upperDir.less']
    test.deepEqual actual, expected
    test.done()

exports['stripImported'] =
  'return array without imported filepaths': (test) ->
    test.expect 1
    files = importless.findAll 'test/files'
    actual = _.sortBy importless.stripImported(files, importless.getImported(files))
    expected = _.sortBy ['test/files/test.less', 'test/files/test2.css']
    test.deepEqual actual, expected
    test.done()

exports['setIgnored'] =
  'ignore `ignore` directory when set': (test) ->
    test.expect 1
    importless.setIgnored '**/test2.*'
    files = importless.findAll 'test/files'
    actual = _.sortBy importless.stripIgnored(files, importless.getIgnored())
    expected = _.sortBy ['test/files/imported.less', 'test/files/test.less']
    test.deepEqual actual, expected
    importless.setIgnored []
    test.done()


exports['detectDependencies'] =
  setUp: (next) ->
    next()
  tearDown: (next) ->
    fs.rename 'test/files/test2.less', 'test/files/test2.css'
    next()
  'return array of dependencies in directory without imported files': (test) ->
    test.expect 2
    actual = _.sortBy importless.detectDependencies('test/files')
    expected = _.sortBy ['test/files/test.less', 'test/files/test2.less']
    test.deepEqual actual, expected
    test.ok fs.existsSync 'test/files/test2.less'
    test.done()