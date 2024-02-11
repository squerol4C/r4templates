<#
myoji-yurai.net�l����c���̃f�[�^�𐶐�����B
#>
# �e�[�u����xpath
# /html/body/div[3]/div[1]/div[2]/div[1]/table[1]


# https://learn.microsoft.com/ja-jp/dotnet/api/microsoft.powershell.commands.htmlwebresponseobject?view=powershellsdk-1.1.0
# �I�u�W�F�N�g�̌^�̏��͏�LURL���Q��
[Microsoft.PowerShell.Commands.HtmlWebResponseObject]$res = Invoke-WebRequest 'https://myoji-yurai.net/prefectureRanking.htm'
$selectAreaElement = $res.ParsedHtml.getElementById('form_rankingSelect')

$firstNames = @()


foreach ($specifyRankingNode in $selectAreaElement) {
    # https://learn.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/platform-apis/aa752279(v=vs.85)
    # IHTMLElement�ւ�ref
    $specifyPageCount = $specifyRankingNode.getAttribute('value')
    $specifyUrl = "https://myoji-yurai.net/prefectureRanking.htm?prefecture=%E5%85%A8%E5%9B%BD&page=${specifyPageCount}"
    # $specifyUrl = "https://myoji-yurai.net/prefectureRanking.htm?prefecture=�S��&page=${specifyPageCount}"
    Write-Host $specifyUrl -ForegroundColor Yellow

    [Microsoft.PowerShell.Commands.HtmlWebResponseObject]$specifyRes = Invoke-WebRequest $specifyUrl
    # Write-Host "Status Code ="$specifyRes.StatusCode

    # https://learn.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/platform-apis/aa752541(v=vs.85)
    # IHTMLDocument3
    $nameInfoTableContents = $specifyRes.ParsedHtml.querySelector('#content > div.post').getElementsByTagName('table')
    foreach ($nameInfoElements in $nameInfoTableContents) {

        foreach ($item in $nameInfoElements.getElementsByTagName('tr')) {
            # $item = $nameInfoElements.getElementsByTagName('tr')
            # $D_ranking = $item.querySelector('td:nth-child(1)').innerText # �c��
            $D_ranking = $item.getElementsByTagName('td')[0].innerText # �l������
            $D_name = $null
            $tableData1 = $item.getElementsByTagName('td')[1]
            if ($null -ne $tableData1) {
                $D_name = $tableData1.getElementsByTagName('a')[0].innerText # �c��
            }
            $D_count = $item.getElementsByTagName('td')[2].innerText # �l��
            if (($null -ne $D_name) -and ($null -ne $D_count)) {
                $firstNames += ,[PSCustomObject]@{
                    'firstName' = $D_name
                }
                Write-Host "�c��: ${D_name} �l�� = ${D_count} (${D_ranking})"
            }
        }
    }
}

$firstNames
# $specifyUrl = 'https://myoji-yurai.net/prefectureRanking.htm?prefecture=%E5%85%A8%E5%9B%BD&page=0'
Write-Host 'done.'