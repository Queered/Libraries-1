local Heap = {};
Heap.__index = Heap;

function Heap.new(compare, min_size)
    return setmetatable({
        _heap = table.create(min_size or 0),
        _compare = compare or function(a, b)
            return a > b;
        end
    }, Heap);
end

function Heap:Pop(idx)
    return table.remove(self._heap, idx or 1);
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
    return idx;
end

function Heap:Peek(idx)
    return self._heap[idx];
end

function Heap:Size()
    return #self._heap;
end

return Heap;
