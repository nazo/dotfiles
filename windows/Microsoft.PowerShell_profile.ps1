Invoke-Expression "$(vfox activate pwsh)"

# Scoop Tab completion
Import-Module "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\modules\scoop-completion"

# Windows Terminal customize
oh-my-posh init pwsh --config ~/AppData/Local/Programs/oh-my-posh/themes/peru.omp.json | Invoke-Expression

# # Show Terminal Icons
Import-Module Terminal-Icons

# Add posh-git
Import-Module posh-git

# zsh-like tab completion
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

Set-Alias -Name vim -Value nvim

