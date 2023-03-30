-- Sorted array implementation specifically made and optimised for LuaU
local SortedArray = {};

function SortedArray.new(size: number?, compare: ((a: any, b: any) -> boolean)?)
    return setmetatable({
        _array = table.create(size or 0),
        _compare = compare or function(a, b) return a > b; end
    }, { __index = SortedArray });
end

function SortedArray:Push(value: any): number
    if value == nil then error("Missing argument #1", 2); end
    for idx, item in ipairs(self._array) do
        if self._compare(item, value) then
            return table.insert(self._array, idx, value) or idx;
        end
    end
    return table.insert(self._array, value) or self:Size();
end

function SortedArray:Pop(idx: number?): any?
    return table.remove(self._array, idx or 1);
end

function SortedArray:Peek(idx: number?): any?
    return self._array[idx or 1];
end

function SortedArray:Size(): number
    return #self._array;
end

return SortedArray;
