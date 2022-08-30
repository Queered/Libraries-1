local TaskHandler = {};
TaskHandler.__index = TaskHandler;

function TaskHandler.new(signal, callback)
    return setmetatable({
        _signal = signal,
        _callback = callback
    }, TaskHandler);
end

function TaskHandler:Wait()
    self._waiting = true;
    self._thread = coroutine.running();
    return coroutine.yield();
end

function TaskHandler:Defer(callback)
    return callback(self:Wait());
end

function TaskHandler:Start()
    assert(not self.active, "The handler is already active.");

    self.active = true;
    self.connection = self._signal:Connect(function(...)
        if self._waiting then
            self._waiting = false;
            return coroutine.resume(self._thread, ...);
        end
        return self:_callback(...);
    end);
end

function TaskHandler:Stop()
    assert(self.active, "The handler isn't active");

    self.active = false;
    self.connection:Disconnect();
end

return TaskHandler;
