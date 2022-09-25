local Heap = {};
Heap.__index = Heap;

function Heap.new(compare, size)
    return setmetatable({
        _heap = table.create(size or 0),
        _compare = compare or function(a, b)
            return a > b;
        end
    }, Heap);
end

function Heap:Pop()
    return table.remove(self._heap, 1);
end

function Heap:Push(value)
    local idx = 1;
    for i, v in next, self._heap do
        if self._compare(v, value) then
            idx = i;
            break;
        end
    end
    table.insert(self._heap, idx, value);
end

function Heap:Peek(idx)
    return rawget(self._heap, idx);
end

function Heap:Size()
    return rawlen(self._heap);
end

return Heap;
