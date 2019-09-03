local util = nil

function util.fallbacks( field, ... )
	local val = nil
	for _,v in ipairs( { ... } ) do
		val = v[field]
		if val then
			break
		end
	end
	return val
end


return util