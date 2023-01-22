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

function Heap:Push(value)
    local idx = 1;
    for i = 1, #self._heap do
        if self._compare(self._heap[i], value) then
            idx = i;
            break;
        end
    end
    
    table.insert(self._heap, idx, value);
    return idx;
end

function Heap:Pop(idx)
    return table.remove(self._heap, idx or 1);
end

function Heap:Peek(idx)
    return self._heap[idx];
end

function Heap:Size()
    return #self._heap;
end

return Heap;
