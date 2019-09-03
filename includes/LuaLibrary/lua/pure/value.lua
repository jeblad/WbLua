local libUtil = require 'libraryUtil'

local Value = {
	types = {}
}

Value.types['string'] = require '_value.string'
Value.types['wikibase-entityid'] = require '_value.entityid'
Value.types['time'] = require '_value.time'

function Value.inject( t )
	libUtil.checkType( 'value.inject', 1, t, 'table', false )
	local meta = Value.types[t.type]
	if not meta then
		return nil, 'value.inject: undefined type'
	end
	setmetatable( t, Value.types[t.type] )
	return t
end

-- wrong?
function Value.type( t )
	libUtil.checkType( 'value.type', 1, t, 'table', false )
	return t:type()
end

-- wrong?
function Value.value( t )
	libUtil.checkType( 'value.value', 1, t, 'table', false )
	return t
end

function Value.text( t, opts )
	libUtil.checkType( 'value.text', 1, t, 'table', false )
	libUtil.checkType( 'value.text', 2, opts, 'table', true )
	return t:__text( opts or {} )
end

function Value.html( t, opts )
	libUtil.checkType( 'value.html', 1, t, 'table', false )
	libUtil.checkType( 'value.html', 2, opts, 'table', true )
	return t:__html( opts or {} )
end

return Value