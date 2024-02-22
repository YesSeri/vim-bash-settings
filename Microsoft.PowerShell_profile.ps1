# For zoxide v0.8.0+
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})

# Starship
Invoke-Expression (&starship init powershell)

# I think it is better to have UTF8. Then I can pipe things without swedish letters breaking.
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Use zoxide to move to folder and then list all folders. 
function zls {
	z @args; lsd
}
$CustomConfigWorkspacer="C:\Users\Henrik\.workspacer\workspacer.config.csx"
