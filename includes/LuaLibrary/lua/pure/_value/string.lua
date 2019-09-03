local libUtil = require 'libraryUtil'
local util = require '_value.util'

local vString = {}
vString.__index = vString
vString.conf = {
	tag = 'span',
	format = '%s'
}

function vString:__text( opts )
	libUtil.checkType( 'string:__text', 1, opts, 'table', false )
	local format = util.fallbacks( 'format', opts, vString.conf )
	return mw.ustring.format( format, self.value )
end

function vString:__html( opts )
	libUtil.checkType( 'string:__html', 1, opts, 'table', false )
	local tag = util.fallbacks( 'tag', opts, vString.conf )
	local html = mw.html.create( tag )
	return html:wikitext( self.value )
end

return vString
