local Translations = {
    notify = {
        totals = 'Toplam kazanç : %{result} Sınır : %{limit}',
        added = 'iş limitinize eklendi',
        cantearn = "O kadar para kazanamazsın. Limit %{limit} $ ve şimdiden %{earning} $ kazandınız."
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
