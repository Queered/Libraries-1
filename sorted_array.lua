-- Custom sorted array implementation specifically made and optimised for LuaU
local SortedArray = {};

function SortedArray.new(size, compare)
    return setmetatable({
        _array = table.create(size or 0),
        _compare = compare or function(a, b) return a > b; end
    }, { __index = SortedArray });
end

function SortedArray:Push(value)
    for idx, item in ipairs(self._array) do
        if self._compare(item, value) then
            table.insert(self._array, idx, value);
            return;
        end
    end
    table.insert(self._array, value);
end

function SortedArray:Pop(idx)
    return table.remove(self._array, idx or 1);
end

function SortedArray:Peek(idx)
    return self._array[idx or 1];
end

function SortedArray:Size()
    return #self._array;
end

return SortedArray;
