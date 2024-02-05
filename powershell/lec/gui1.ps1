#フォームを作成するためのアセンブリ読込(PowerShell ISEでは不要)
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

#フォームの作成
$form = New-Object System.Windows.Forms.Form
$form.Text = "wi" # Window title
$form.Size = New-Object System.Drawing.Size(400,300) # Window size

# Making a TextBox
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10, 40)
$textBox.Size = New-Object System.Drawing.Point(200, 15)
$textBox.AllowDrop = $true
$textBox.Add_DragEnter({$_.Effect = 'ALL'})
$textBox.Add_DragDrop({ $Name = @($_.Data.GetData("FileDrop")); [System.Windows.Forms.MessageBox]::Show($Name[0], 'ファイルPATH') })
$form.Controls.Add($textBox) # Add a Textbox to form

# Making a label
$label1 = New-Object System.Windows.Forms.Label
$label1.Text = "Text in a label"
$label1.Location = New-Object System.Drawing.Point(100, 100)
$label1.AutoSize = $true
$form.Controls.Add($label1)

# Making a button
$button1 = New-Object System.Windows.Forms.Button
$button1.Location = New-Object System.Drawing.Point(10, 10)
$button1.Text = 'Pushable Button1'
$button1.Size = New-Object System.Drawing.Point(105, 20)
$form.Controls.Add($button1)


$form.ShowDialog()