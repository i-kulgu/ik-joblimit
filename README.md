# IK-JobLimit

Easy configurable job limits with exports.

## Installation

- Download and place the resource in your resources folder
- Run the joblimit.sql file in your database. This will add a column in your 'players' table named earnings
- Use the following exports on the client or server side scripts:

### Control Money

Do a check if the user can earn the money thats going to be added to account.
Returns a boolean (true / false)

```lua
-- client side
exports['ik-joblimit']:ControlEarning(money)

-- server side 
exports['ik-joblimit']:ControlEarning(source, money)
```

### Add Money

Add the money to the users total earnings.
Returns a boolean (true / false)

```lua
-- client side
exports['ik-joblimit']:AddJobMoney(money)

-- server side 
exports['ik-joblimit']:AddJobMoney(source, money)
```

# Sample from qb-pawnshop

When selling from qb-pawnshop you can do a check if the user can earn that money and if it passes add the money

```lua
RegisterNetEvent('qb-pawnshop:server:sellPawnItems', function(itemName, itemAmount, itemPrice)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local totalPrice = (tonumber(itemAmount) * itemPrice)
    local jobearning = exports['ik-joblimit']:ControlEarning(src, totalPrice) -- Do a check if the user can earn that much money
    if not jobearning then return end -- Break the selling if the player is not allowed to earn that much
    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    local dist
    for _, value in pairs(Config.PawnLocation) do
        dist = #(playerCoords - value.coords)
        if #(playerCoords - value.coords) < 2 then
            dist = #(playerCoords - value.coords)
            break
        end
    end
    if dist > 5 then exploitBan(src, 'sellPawnItems Exploiting') return end
    if Player.Functions.RemoveItem(itemName, tonumber(itemAmount)) then
        if Config.BankMoney then
            Player.Functions.AddMoney('bank', totalPrice)
            exports['ik-joblimit']:AddJobMoney(src, totalPrice) -- Add the money amount to total earnings after giving out money
        else
            Player.Functions.AddMoney('cash', totalPrice)
            exports['ik-joblimit']:AddJobMoney(src, totalPrice) -- Add the money amount to total earnings after giving out money
        end
        TriggerClientEvent('QBCore:Notify', src, Lang:t('success.sold', { value = tonumber(itemAmount), value2 = QBCore.Shared.Items[itemName].label, value3 = totalPrice }),'success')
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove')
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_items'), 'error')
    end
    TriggerClientEvent('qb-pawnshop:client:openMenu', src)
end)
```