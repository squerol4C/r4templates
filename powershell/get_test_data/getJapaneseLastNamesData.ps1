# https://namedic.jp/names/yomi_list/f/%E3%81%82

$gender_flags = @('m', 'f')

$template_url = 'https://namedic.jp/names/yomi_list/{gender_flag}/{url_encoded_yomi}'

$domain = 'https://namedic.jp'

$yomi_list = ('‚ ‚¢‚¤‚¦‚¨‚©‚«‚­‚¯‚±‚³‚µ‚·‚¹‚»‚½‚¿‚Â‚Ä‚Æ‚È‚É‚Ê‚Ë‚Ì‚Í‚Ğ‚Ó‚Ö‚Ù‚Ü‚İ‚Ş‚ß‚à‚â‚ä‚æ‚ç‚è‚é‚ê‚ë‚í‚ğ‚ñ').Split('')[0]


# $request_url = $template_url.Replace('{gender_flag}', $gender_flags[0]).Replace('{url_encoded_yomi}', [System.Web.HttpUtility]::UrlEncode([string]$yomi_list[0]).ToUpper())
$request_url = $template_url.Replace('{gender_flag}', $gender_flags[0]).Replace('{url_encoded_yomi}', [string]$yomi_list[0])

Write-Host $request_url


# body > div.lo-wrapper > div > article > section:nth-child(1) > div > table > tbody

# [Microsoft.PowerShell.Commands.WebResponseObject]$res = Invoke-WebRequest $request_url
Write-Host "Reuqest to ${request_url}" -BackgroundColor Green
$res = Invoke-WebRequest $request_url

# $res.Content > output.html

# $res.ParsedHtml.querySelector('table[class="table-names"]')

$doc_yomi_names_list = $res.ParsedHtml.querySelector('table[class="table-names"]').getElementsByTagName('tr')

foreach ($doc_name in $doc_yomi_names_list) {
    $yomi_kana = $doc_name.children[0].innerText
    $same_names_list_url = $domain + $doc_name.children[2].children[0].GetAttribute('href', 2)
    Write-Host "–¼‘O(‚æ‚İ) = ${yomi_kana}, Ú×‚ÈURL = ${same_names_list_url}"

    # “¯‚¶“Ç‚İ‚Ì–¼‘O
    $detailed_name_url = $same_names_list_url

    $res = Invoke-WebRequest $detailed_name_url

    $doc_detailed_names_list = $res.ParsedHtml.querySelector('table[class="table-names"]').getElementsByTagName('tr')
    $bfirst = $true

    foreach ($detailed_name in $doc_detailed_names_list) {
        if ($bfirst -eq $true) {
            $bfirst = $false
            continue
        }

        $name_kanji = $detailed_name.getElementsByTagName('a')[3].GetAttribute('data-name')
        $name_kanji
        # ˆ—
    }

    Start-Sleep 0.6
}