# from https://ja.wikipedia.org/wiki/ISO_3166-1
# more https://www.asahi-net.or.jp/~ax2s-kmtn/ref/iso3166-1.html


$url = 'https://ja.wikipedia.org/wiki/ISO_3166-1'

$resMain = Invoke-WebRequest $url

$rows = $resMain.ParsedHtml.querySelector('table').getElementsByTagName('tr')

foreach ($row in $rows) {
    $countryName = $row.getElementsByTagName('td')[0].innerText.Trim()
    $countryCode = $row.getElementsByTagName('td')[3].innerText
    $iso3316_3chr_nm = $row.getElementsByTagName('td')[4].innerText
    $iso3316_2chr_nm = $row.getElementsByTagName('td')[5].innerText

    if ($null -ne $countryCode) {
        Write-Host "(${countryCode}, '${countryName}', '${iso3316_2chr_nm}', '${iso3316_3chr_nm}')"
    }

}