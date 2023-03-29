-- Custom heap implementation specifically made and optimised for LuaU
-- Will NOT work with regular lua!
local Heap = {};

function Heap.new(size, compare)
    return setmetatable({
        _heap = table.create(size or 0),
        _compare = compare or function(v0, v1) return v0 > v1; end
    }, { __index = Heap });
end

function Heap:Push(value)
    for idx = 1, self:Size() do
        if self._compare(self:Peek(idx), value) then
            table.insert(self._heap, idx, value);
            return;
        end
    end
    table.insert(self._heap, value);
end

function Heap:Pop(idx)
    return table.remove(self._heap, idx or 1);
end

function Heap:Peek(idx)
    return self._heap[idx or 1];
end

function Heap:Size()
    return #self._heap;
end

return Heap;
