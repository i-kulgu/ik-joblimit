local Translations = {
    notify = {
        totals = 'Toplam kazanç : %{result} Sınır : %{limit}',
        added = 'iş limitinize eklendi',
        cantearn = "O kadar para kazanamazsın. Limit %{limit} $ ve şimdiden %{earning} $ kazandınız."
    }
}
if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true
    })
end
