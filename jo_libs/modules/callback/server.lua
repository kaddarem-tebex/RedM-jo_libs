ServerCallbacks = {}

function RegisterServerCallback(name, cb)
  ServerCallbacks[name] = {
    cb = cb,
    resource = GetCurrentResourceName()
  }
end

function FireServerCallback(name, source, cb, ...)
  cb(ServerCallbacks[name].cb(source, ...))
end

RegisterServerEvent('jo_libs:triggerServerCallback', function(name, requestId,fromRessource, ...)
  local source = source
  if not ServerCallbacks[name] then return end

  FireServerCallback(name, source, function(...)
    TriggerClientEvent('jo_libs:serverCallback', source, requestId,fromRessource, ...)
  end, ...)
end)