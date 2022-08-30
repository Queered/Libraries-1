local TaskHandler = {};
TaskHandler.__index = TaskHandler;

function TaskHandler.new(signal, callback)
    local self = setmetatable({}, TaskHandler);
    self._connection = signal:Connect(function(...)
        if self._waiting then
            self._waiting = false;
            return coroutine.resume(self._thread, ...);
        end
        return callback(...);
    end);
    return self;
end

function TaskHandler:Wait()
    self._waiting = true;
    self._thread = coroutine.running();
    return coroutine.yield();
end

function TaskHandler:Defer(callback)
    return callback(self:Wait());
end

function TaskHandler:Cancel()
    if self._thread then
        coroutine.resume(self._thread);
        self._thread = nil;
    end
    self._waiting = false;
    self._connection:Disconnect();
end

return TaskHandler;
