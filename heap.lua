local Heap = {};
Heap.__index = Heap;

function Heap.new(compare, size)
    return setmetatable({
        _heap = table.create(size or 0),
        _compare = compare or function(v0, v1)
            return v0 > v1;
        end
    }, Heap);
end

function Heap:Pop(idx)
    return table.remove(self._heap, idx or 1);
end

function Heap:Push(value)
    local heap = self._heap;
    local compare = self._compare;

    for i = 1, #heap do
        if compare(heap[i], value) then
            table.insert(heap, i, value);
            return i;
        end
    end
end

function Heap:Peek(idx)
    return self._heap[idx];
end

function Heap:Size()
    return #self._heap;
end

return Heap;
