-- Universal Server Hop Script

print("Attempting to serverhop")

local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour

-- Load or initialize the server list
local function loadServerList()
    local success, result = pcall(function()
        return game:GetService("HttpService"):JSONDecode(readfile("NotSameServers.json"))
    end)
    if success and type(result) == "table" then
        return result
    else
        return { actualHour }
    end
end

AllIDs = loadServerList()

-- Save the updated server list
local function saveServerList()
    local success, errorMessage = pcall(function()
        writefile("NotSameServers.json", game:GetService("HttpService"):JSONEncode(AllIDs))
    end)
    if not success then
        warn("Failed to save server list: " .. tostring(errorMessage))
    end
end

-- Clear old entries if the hour has changed
if tonumber(AllIDs[1]) ~= actualHour then
    AllIDs = { actualHour }
    saveServerList()
end

-- Fetch and process servers
local function fetchServers(cursor)
    local url = 'https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'
    if cursor then
        url = url .. '&cursor=' .. cursor
    end

    local success, response = pcall(function()
        return game.HttpService:JSONDecode(game:HttpGet(url))
    end)

    if success and response and response.data then
        return response
    else
        warn("Failed to fetch server data")
        return nil
    end
end

-- Attempt to teleport to a new server
local function tryTeleport()
    local cursor = foundAnything
    while true do
        local servers = fetchServers(cursor)
        if not servers then break end

        cursor = servers.nextPageCursor
        for _, server in ipairs(servers.data) do
            if server.playing < server.maxPlayers then
                local serverID = tostring(server.id)
                if not table.find(AllIDs, serverID) then
                    table.insert(AllIDs, serverID)
                    saveServerList()
                    pcall(function()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, serverID, game.Players.LocalPlayer)
                    end)
                    wait(4)
                end
            end
        end

        if not cursor then break end
        wait(1) -- Prevent excessive requests
    end
end

-- Main execution
local function startServerHop()
    tryTeleport()
end

-- Start the process
startServerHop()
