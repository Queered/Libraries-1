local Heap = {};
Heap.__index = Heap;

function Heap.new(compare)
    return setmetatable({
        _values = {},
        _compare = compare or function(a, b)
            return a > b;
        end
    }, Heap);
end

function Heap:Pop()
    return table.remove(self._values, 1);
end

function Heap:Push(value)
    local idx = 1;
    for i, v in next, self._values do
        if self._compare(v, value) then
            idx = i;
            break;
        end
    end
    table.insert(self._values, idx, value);
end

function Heap:Peak(idx)
    return rawget(self._values, idx);
end

function Heap:Size()
    return rawlen(self._values);
end

return Heap;
