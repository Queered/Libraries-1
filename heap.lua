local Heap = {};

function Heap.new(compare, size)
    return setmetatable({
        _heap = table.create(size or 0),
        _compare = compare or function(v0, v1)
            return v0 > v1;
        end
    }, { __index = Heap });
end

function Heap:Push(value)
    local idx = nil;
    for i = 1, self:Size() do
        if self._compare(self:Peek(i), value) then
            idx = i;
            break;
        end
    end
    return table.insert(self._heap, select(idx and 1 or 2, idx, value));
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
