$VER = "1.0.1"

echo "PoshStats v$($VER)"
echo "------------------"
echo "Loading required assemblies..."
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$wnd = New-Object System.Windows.Forms.Form
$wnd.Text = "Performance Stats"
$wnd.StartPosition = "Manual"
$size = New-Object System.Drawing.Size(200,300)
$wnd.Size = $size
$bnds = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea
$wnd.Left = $bnds.Width - $size.Width
$wnd.Top = $bnds.Height - $size.Height
$wnd.FormBorderStyle = "None"
$wnd.TransparencyKey = "Lime"
$wnd.BackColor = "Lime"

$b64i = [Convert]::FromBase64String("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")
$wnd.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new([System.IO.MemoryStream]::new($b64i, 0, $b64i.Length)).GetHicon()))
#prevent excess mem usage
$b641 = $null

$cls = New-Object System.Windows.Forms.Button
$cls.BackColor = "Crimson"
$cls.Text = "X"
$cls.Size = New-Object System.Drawing.Size(25,25)
$cls.Left = $size.Width - $cls.Size.Width
$cls.Top = $size.Height - $cls.Size.Height
$cls.Add_Click({
    $wnd.Dispose()
})

$lblfnt = New-Object System.Drawing.Font("Consolas", 12)
$capfnt = New-Object System.Drawing.Font("Consolas", 8)
$lblanchor = $true
$lblclr = "green"
$capclr = "red"

$pne = New-Object System.Windows.Forms.FlowLayoutPanel
$pne.Size = New-Object System.Drawing.Size($size.Width, ($size.Height - $cls.Height))
$pne.FlowDirection = "TopDown"

$cpulbl = New-Object System.Windows.Forms.Label
$cpulbl.Text = "CPU: -"
$cpulbl.Font = $lblfnt
$cpulbl.AutoSize = $lblanchor
$cpulbl.ForeColor = $lblclr

$memlbl = New-Object System.Windows.Forms.Label
$memlbl.Text = "MEM: -"
$memlbl.Font = $lblfnt
$memlbl.AutoSize = $lblanchor
$memlbl.ForeColor = $lblclr

$gpulbl = New-Object System.Windows.Forms.Label
$gpulbl.Text = "GPU: -"
$gpulbl.Font = $lblfnt
$gpulbl.AutoSize = $lblanchor
$gpulbl.ForeColor = $lblclr

$gpucap = New-Object System.Windows.Forms.Label
$gpucap.Text = "-"
$gpucap.Font = $capfnt
$gpucap.AutoSize = $lblanchor
$gpucap.ForeColor = $capclr

$selflbl = New-Object System.Windows.Forms.Label
$selflbl.Text = "SELF USAGE: -"
$selflbl.Font = $capfnt
$selflbl.AutoSize = $lblanchor
$selflbl.ForeColor = $capclr

$cpucap = New-Object System.Windows.Forms.Label
$cpucap.Text = "-"
$cpucap.Font = $capfnt
$cpucap.AutoSize = $lblanchor
$cpucap.ForeColor = $capclr

$verlink = New-Object System.Windows.Forms.LinkLabel
$verlink.Text = "New version available"
$verlink.AutoSize = $true
$verlink.Add_LinkClicked({
    $verlink.LinkVisited = $true
    [System.Diagnostics.Process]::Start("https://github.com/mochawoof/PoshStats")
})
$verlink.ForeColor = "yellow"
$verlink.Font = $capfnt

$evt = New-Object System.Windows.Forms.Timer
$evt.Interval = 450
$fnsh = $true

function check_state($arr) {
    foreach ($e in $arr) {
        if ($arr.State -ne "Completed") {
            return $false
        }
    }
    return $true
}

function setcaps() {
    $cap = (Get-WmiObject -Query "select Caption from win32_VideoController").Caption
    $gpucap.Text = $cap.Caption
    $cpi = Get-WmiObject -Query "select Name, NumberOfLogicalProcessors, MaxClockSpeed from Win32_Processor"
    $cpucap.Text = "$($cpi.Name), $([math]::round($cpi.MaxClockSpeed / 100, 2))GHz max, $($cpi.NumberOfLogicalProcessors) cores"
}

$tev = $evt.Add_Tick({
    if ($fnsh -eq $true) {
        $fnsh = $false
        $jobs = @()
        #stat blocks
        $cpublk = {
            Get-WmiObject -Query "select LoadPercentage from Win32_Processor" | Select-Object LoadPercentage
        }

        $memblk = {
            $cim = Get-CIMInstance Win32_OperatingSystem
            $rti = $cim | Select FreePhysicalMemory
            $rti | Add-Member -NotePropertyName "Total" -NotePropertyValue ($cim | Select TotalVisibleMemorySize).TotalVisibleMemorySize
            return $rti

        }

        $gpublk = {
            $3duse = (((Get-Counter "\Gpu Engine(*engtype_3D)\Utilization Percentage").CounterSamples | where CookedValue).CookedValue | measure -sum).sum
            $vduse = (((Get-Counter "\Gpu Engine(*engtype_VideoDecode)\Utilization Percentage").CounterSamples | where CookedValue).CookedValue | measure -sum).sum
            $copyuse = (((Get-Counter "\Gpu Engine(*engtype_Copy)\Utilization Percentage").CounterSamples | where CookedValue).CookedValue | measure -sum).sum
            $vpuse = (((Get-Counter "\Gpu Engine(*engtype_VideoProcessing)\Utilization Percentage").CounterSamples | where CookedValue).CookedValue | measure -sum).sum

            return $3duse + $vduse + $copyuse + $vpuse
        }

        $selfblk = {
            
            return (Get-WmiObject Win32_Process | Where-Object ProcessID -eq $pid).ws
        }

        $cpujb = Start-Job -ScriptBlock $cpublk
        $memjb = Start-Job -ScriptBlock $memblk
        $gpujb = Start-Job -ScriptBlock $gpublk
        $selfjb = Start-Job -ScriptBlock $selfblk
        $jobs += $cpujb
        $jobs += $memjb
        $jobs += $gpujb
        $jobs += $selfjb

        $totalstate = check_state($jobs)
        Do {
            #prevent blocking
            [System.Windows.Forms.Application]::DoEvents()
            $totalstate = check_state($jobs)
        }While ($totalstate -ne $true)

        $cpur = Receive-Job $cpujb
        $memr = Receive-Job $memjb
        $gpur = Receive-Job $gpujb
        $selfr = Receive-Job $selfjb
        $cpulbl.Text = "CPU: $($cpur.LoadPercentage)%"
        $memlbl.Text = "MEM: $([math]::round(100 * (1 - ($memr.FreePhysicalMemory / $memr.Total)), 2))% Used ($([math]::round(($memr.Total - $memr.FreePhysicalMemory)/1024))MB)"
        $gpulbl.Text = "GPU: $([math]::round($gpur, 2))%"
        $selflbl.Text = "Self mem usage: $([math]::round(($selfr / 1024) / 1024))MB"
        $fnsh = $true
    }

    $wnd.TopMost = $true
})
$evt.Start()
setcaps

$wnd.Controls.Add($cls)
$wnd.Controls.Add($pne)
$pne.Controls.Add($cpulbl)
$pne.Controls.Add($cpucap)
$pne.Controls.Add($memlbl)
$pne.Controls.Add($selflbl)
$pne.Controls.Add($gpulbl)
$pne.Controls.Add($gpucap)

#check version. change CHECKVER to $false to disable
$CHECKVER = $true

if ($CHECKVER -eq $true) {
    $req = Invoke-WebRequest -Uri "https://mochawoof.github.io/PoshStats/cv.txt"
    if ($req.Content -ne $null) {
        if ($req.Content -ne $VER) {
            $pne.Controls.Add($verlink)
        }
    }
}
echo "Started"
$wnd.ShowDialog()
echo "Cleaning up and closing..."
$evt.Stop()
Remove-Variable * -ErrorAction SilentlyContinue
