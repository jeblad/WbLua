local libUtil = require 'libraryUtil'
local util = require '_value.util'

local vWbEntityId = {}
vWbEntityId.__index = vWbEntityId
vWbEntityId.conf = {
	format = '%s'
}

function vWbEntityId:__text( opts )
	libUtil.checkType( 'wikibase-entityid:__text', 1, opts, 'table', false )
	local entityId = self.value.id or util.fallbacks( 'entityId', opts, vWbEntityId.conf )
	if not entityId and (opts.title or vWbEntityId.conf.title) then
		local siteId = util.fallbacks( 'siteId', opts, vWbEntityId.conf )
		entityId = ( siteId and mw.wikibase.getEntityIdForTitle( opts.title or vWbEntityId.conf.title, siteId ) )
			or mw.wikibase.getEntityIdForTitle( opts.title or vWbEntityId.conf.title )
	end
	if not entityId then
		entityId = mw.wikibase.getEntityIdForCurrentPage()
	end
	if not entityId then
		return nil, 'Value.wikibase-entityid: can not find entity identifier'
	end
	local langCode = util.fallbacks( 'langCode', opts, vWbEntityId.conf )
	local label = ( langCode and mw.wikibase.getLabelByLang( entityId, langCode ) )
		or mw.wikibase.getLabel( entityId )
	local format = util.fallbacks( 'format', opts, vWbEntityId.conf )
	return mw.ustring.format( format, label or entityId )
end

function vWbEntityId:__html( opts )
	return 'foo'
end

return vWbEntityId
