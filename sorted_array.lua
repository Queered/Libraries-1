local SortedArray = {}

function SortedArray.new(size: number?, compare: ((a: any, b: any) -> boolean)?)
    return setmetatable({
        _array = {},
        _size = 0,
        _compare = compare or function(a: any, b: any) return a > b end
    }, { __index = SortedArray })
end

function SortedArray:Push(value: any): number
    if not value then
        error("missing argument #1 to 'Push'", 2)
    end
    assert(type(value) ~= "table", "table values are not allowed in SortedArray")
    local low, high = 1, self._size
    local compare = self._compare
    while low <= high do
        local mid = math.floor((low + high) / 2)
        if compare(self._array[mid], value) then
            high = mid - 1
        else
            low = mid + 1
        end
    end
    table.insert(self._array, low, value)
    self._size = self._size + 1
    return low
end

function SortedArray:Pop(idx: number?): any?
    local value = table.remove(self._array, idx or 1)
    if value then
        self._size = self._size - 1
    end
    return value
end

function SortedArray:Peek(idx: number?): any?
    return self._array[idx or 1]
end

function SortedArray:Size(): number
    return self._size
end

function SortedArray:Iterator()
    local idx = 0
    local function iter()
        idx = idx + 1
        if idx <= self._size then
            return self._array[idx]
        end
    end
    return iter
end

return SortedArray
