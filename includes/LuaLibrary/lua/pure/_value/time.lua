local libUtil = require 'libraryUtil'
local util = require '_value.util'

local vTime = {}

function vTime:__text( opts )
	libUtil.checkType( 'time:__text', 1, opts, 'table', false )
	local layout = util.fallbacks( 'layout', opts, vTime.conf )
	for i,v in ipairs( layout ) do
		t[i] = self.value[v]
	end
	local format = util.fallbacks( 'format', opts, vTime.conf )
	return mw.ustring.format( format, unpack( t ) )
end

function vTime:__html( opts )
	libUtil.checkType( 'time:__text', 1, opts, 'table', false )
	local tag = util.fallbacks( 'tag', opts, vTime.conf )
	local html = mw.html.create( tag )
	local layout = util.fallbacks( 'layout', opts, vTime.conf )
	for i,v in ipairs( layout ) do
		local p = opts[i] or conf[i]
		local elem = mw.html.create( p.tag )
		elem:wikitext( self.value[v] )
		html:node( elem )
	end
	return html
end

return vTime
