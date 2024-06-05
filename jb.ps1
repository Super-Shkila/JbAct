$idePaths = @(
    "C:\Program Files\JetBrains\IntelliJ IDEA 2024.1.2\bin\idea64.exe"
)
#Iterate through each IDE path
foreach ($path in $idePaths) {
    # Extract IDE name from the path
    $ideName = [System.IO.Path]::GetFileNameWithoutExtension($path)
    # Fix IDE name
    $ideName = $ideName.Substring(0, $ideName.IndexOf("64"))
    # Prepend "activate " to IDE name
    $firewallRuleName = "activate $ideName"
    # Get IP address from DNS lookup
    $ipArray = @()
    # Loop until 2 unique IP addresses are found
    $ip = (nslookup account.jetbrains.com | Select-String '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}').Matches.Value
    $ipArray += $ip
    # Check if the rule exists
    $rule = Get-NetFirewallRule -DisplayName $firewallRuleName -ErrorAction SilentlyContinue
    if ($rule) {
        # Disable firewall rule for the current IDE
        Set-NetFirewallRule -DisplayName $firewallRuleName -Enabled False
        # Enable firewall rule for the current IDE with the retrieved IP addresses
        Set-NetFirewallRule -DisplayName $firewallRuleName -RemoteAddress $ipArray -Enabled True
    } else {
        # Create a new firewall rule
        New-NetFirewallRule -DisplayName $firewallRuleName -Direction Outbound -Action Block -Program $path -RemoteAddress $ipArray
        Write-Host "Created new firewall rule for $firewallRuleName"
    }
}
