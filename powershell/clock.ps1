Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

powershell.exe -WindowStyle hidden -Command "exit"

# Making a form
$form = New-Object System.Windows.Forms.Form
$form.Text = "c" # Window title
$form.Size = New-Object System.Drawing.Size(200, 100) # Window size
$form.Location = New-Object System.Drawing.Point(20, 30) # Window size
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::Manual
$form.MinimizeBox = $false
$form.MaximizeBox = $false
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.TopMost = $true


# Making a label
$label1 = New-Object System.Windows.Forms.Label
$label1.Text = ""
$label1.Location = New-Object System.Drawing.Point(15, 20)
$label1.AutoSize = $true
$form.Controls.Add($label1)

$timer1 = New-Object System.Windows.Forms.Timer
$timer1.Interval = 10
$timer1.Add_Tick({
    $label1.Text = [datetime]::Now.ToString('yyyy/MM/dd HH:mm:ss.ffffff')
})
$timer1.Start()


$form.ShowDialog()