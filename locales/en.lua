local Translations = {
    notify = {
        totals = 'Total earned : %{result} Limit : %{limit}',
        added = 'is added to your joblimit',
        cantearn = "You can't earn that much money.. Limit is $ %{limit} an you earned already $ %{earning}"
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})