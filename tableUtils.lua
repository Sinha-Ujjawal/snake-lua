local tableUtils = {}

---Return the new table within the given range [start..end]
---@param tbl table Array to slice
---@param s number Starting Index
---@param e number? Ending Index. Defaults to the last value
---@return table
function tableUtils.islice(tbl, s, e)
	local sliced = {}
	for i = s, e or #tbl do
		table.insert(sliced, tbl[i])
	end
	return sliced
end

return tableUtils
