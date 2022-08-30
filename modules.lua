local moduleScanner = {};
moduleScanner.__index = moduleScanner;

function moduleScanner.new()
    return setmetatable({
        _cached = {},
        _garbage = getgc(true),
    }, moduleScanner);
end

function moduleScanner._hasKeys(tbl, keys)
    local totalFoundKeys = 0;
    for _, key in next, keys do
        if rawget(tbl, key) then
            totalFoundKeys += 1;
        end
    end
    return totalFoundKeys == #keys;
end

function moduleScanner:Scan(scanData)
    local collection = self._garbage;
    for _, garbage in next, collection do
        local gType = typeof(garbage);
        if gType == "table" or gType == "function" then
            for name, data in next, scanData do
                if
                    (data.Type == "Table" and gType == "table" and self._hasKeys(garbage, data.Keys)) or
                    (data.Type == "Function" and gType == "function" and debug.getinfo(garbage).name == data.Name)
                then
                    self._cached[name] = garbage;
                end
            end
        end
    end
    return self._cached;
end

function moduleScanner:Get(name)
    local module = self._cached[name];
    if module then
        return module;
    end
end

return moduleScanner;
