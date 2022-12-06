local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand('showjoblimit', function()
    QBCore.Functions.TriggerCallback('ik-joblimit:server:getJobMoney', function(result)
        if result then
            QBCore.Functions.Notify(Lang:t('notify.totals', {result = result, limit = Config.Limit}), 'primary', 7500)
        end
    end)
end)

local function ControlEarning(money)
    QBCore.Functions.TriggerCallback('ik-joblimit:server:canEarnJobMoney', function(result)
        if result then
            return true
        else
            return false
        end
    end,money)
end

exports('ControlEarning', ControlEarning)

local function AddJobMoney(money)
    QBCore.Functions.TriggerCallback('ik-joblimit:server:addJobMoney', function(result)
        if result then
            QBCore.Functions.Notify('$ '..money..' '..Lang:t('notify.added'), 'success', 7500)
        end
    end,money)
end

exports('AddJobMoney', AddJobMoney)