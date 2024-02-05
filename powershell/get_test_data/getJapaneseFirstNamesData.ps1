<#
myoji-yurai.net様から苗字のデータを生成する。
#>
# テーブルのxpath
# /html/body/div[3]/div[1]/div[2]/div[1]/table[1]


# https://learn.microsoft.com/ja-jp/dotnet/api/microsoft.powershell.commands.htmlwebresponseobject?view=powershellsdk-1.1.0
# オブジェクトの型の情報は上記URLを参照
[Microsoft.PowerShell.Commands.HtmlWebResponseObject]$res = Invoke-WebRequest 'https://myoji-yurai.net/prefectureRanking.htm'
$selectAreaElement = $res.ParsedHtml.getElementById('form_rankingSelect')

$firstNames = @()


foreach ($specifyRankingNode in $selectAreaElement) {
    # https://learn.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/platform-apis/aa752279(v=vs.85)
    # IHTMLElementへのref
    $specifyPageCount = $specifyRankingNode.getAttribute('value')
    $specifyUrl = "https://myoji-yurai.net/prefectureRanking.htm?prefecture=%E5%85%A8%E5%9B%BD&page=${specifyPageCount}"
    # $specifyUrl = "https://myoji-yurai.net/prefectureRanking.htm?prefecture=全国&page=${specifyPageCount}"
    Write-Host $specifyUrl -ForegroundColor Yellow

    [Microsoft.PowerShell.Commands.HtmlWebResponseObject]$specifyRes = Invoke-WebRequest $specifyUrl
    # Write-Host "Status Code ="$specifyRes.StatusCode

    # https://learn.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/platform-apis/aa752541(v=vs.85)
    # IHTMLDocument3
    # $nameInfoTableContents = $specifyRes.ParsedHtml.querySelectorAll('#content > div.post > table:nth-child(16) > tbody')
    $nameInfoTableContents = $specifyRes.ParsedHtml.querySelector('#content > div.post').getElementsByTagName('table')
    foreach ($nameInfoElements in $nameInfoTableContents) {

        foreach ($item in $nameInfoElements.getElementsByTagName('tr')) {
            # $item = $nameInfoElements.getElementsByTagName('tr')
            # $D_ranking = $item.querySelector('td:nth-child(1)').innerText # 苗字
            $D_name = $item.querySelector('td:nth-child(2) > a').innerText # 苗字
            $D_count = $item.querySelector('td:nth-child(3)').innerText # 苗字
            if (($null -ne $D_name) -and ($null -ne $D_count)) {
                $firstNames += ,[PSCustomObject]@{
                    'firstName' = $D_name
                }
                # Write-Host "苗字: ${D_name} 人数 = ${D_count}"
            }
        }
    }
    Start-Sleep 1
}

$firstNames
# $specifyUrl = 'https://myoji-yurai.net/prefectureRanking.htm?prefecture=%E5%85%A8%E5%9B%BD&page=0'
Write-Host 'done.'