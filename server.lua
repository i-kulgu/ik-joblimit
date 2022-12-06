local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('ik-joblimit:server:getJobMoney', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local Citizen = Player.PlayerData.citizenid
    local jobmoney = MySQL.query.await('SELECT earnings FROM players WHERE citizenid = ?',{Citizen})
    if jobmoney[1] then
        cb(jobmoney[1].earnings)
    else
        cb(nil)
    end
end)

QBCore.Functions.CreateCallback('ik-joblimit:server:canEarnJobMoney', function(source, cb, money)
    local Player = QBCore.Functions.GetPlayer(source)
    local Citizen = Player.PlayerData.citizenid
    local jobmoney = MySQL.query.await('SELECT earnings FROM players WHERE citizenid = ?',{Citizen})
    if (jobmoney[1].earnings + money) > Config.Limit then
        cb(false)
    else
        cb(true)
    end
end)

QBCore.Functions.CreateCallback('ik-joblimit:server:addJobMoney', function(source, cb, money)
    local Player = QBCore.Functions.GetPlayer(source)
    local Citizen = Player.PlayerData.citizenid
    local jobmoney = MySQL.query.await('SELECT earnings FROM players WHERE citizenid = ?',{Citizen})
    if (jobmoney[1].earnings + money) > Config.Limit then
        TriggerClientEvent('QBCore:Notify', source,  Lang:t('notify.cantearn', {limit = Config.Limit, earning = jobmoney[1].earnings}), "error")
        cb(false)
    else
        MySQL.update('UPDATE players SET earnings = earnings + ? WHERE citizenid = ?', {money, Citizen}, function(result)
            if result then
                cb(true)
            else
                cb(false)
            end
        end)
    end
end)

local function ControlEarning(source, money)
    local Player = QBCore.Functions.GetPlayer(source)
    local Citizen = Player.PlayerData.citizenid
    local jobmoney = MySQL.query.await('SELECT earnings FROM players WHERE citizenid = ?',{Citizen})
    if (jobmoney[1].earnings + money) > Config.Limit then
        TriggerClientEvent('QBCore:Notify', source,  Lang:t('notify.cantearn', {limit = Config.Limit, earning = jobmoney[1].earnings}), "error")
        return false
    else
        return true
    end
end

exports('ControlEarning', ControlEarning)

local function AddJobMoney(source, money)
    local Player = QBCore.Functions.GetPlayer(source)
    local Citizen = Player.PlayerData.citizenid
    local jobmoney = MySQL.query.await('SELECT earnings FROM players WHERE citizenid = ?',{Citizen})
    if (jobmoney[1].earnings + money) > Config.Limit then
        TriggerClientEvent('QBCore:Notify', source,  Lang:t('notify.cantearn', {limit = Config.Limit, earning = jobmoney[1].earnings}), "error")
        return false
    else
        MySQL.update('UPDATE players SET earnings = earnings + ? WHERE citizenid = ?', {money, Citizen}, function(result)
            if result then
                return true
            else
                return false
            end
        end)
    end
end

exports('AddJobMoney', AddJobMoney)

local function ClearLimits()
    MySQL.update('UPDATE players SET earnings = 0', {}, function(rows)
        if rows then
            print('=========================')
            print('=Daily Job Limits Reset =')
            print('=========================')
        end
    end)
end

TriggerEvent('cron:runAt', 22, 00, ClearLimits)