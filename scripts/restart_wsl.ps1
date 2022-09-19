function Restart-WSL {
    # Stopping WSL
    wsl.exe --shutdown
    # vmcompute is the service that runs the WSL2 VM
    $command = "Restart-Service vmcompute"
    try { 
        Write-Output "Starting new elevated PowerShell process..."
        # Restarting vmcompute needs admin privileges
        Start-Process -WindowStyle Hidden -Wait powershell -Verb runAs $command
        Write-Output "WSL has been restarted."
    }
    catch {
        # If the user is not an admin and cancels the UAC prompt, this block will be executed
        Write-Output "Failed to start a new PowerShell as administrator."
        Write-Output "Please run the following command in an eliviated shell:"
        Write-Output ""
        Write-Output "`"$command`""
    }
}
