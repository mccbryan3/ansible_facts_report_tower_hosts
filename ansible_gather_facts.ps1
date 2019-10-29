param (
    [Parameter(Mandatory=$True)]
    [string]$twr_user,
    [Parameter(Mandatory=$True)]
    [securestring]$twr_pass,
    [Parameter(Mandatory=$True)]
    [string]$twr_server
)

if ($twr_pass.GetType().Name -eq "SecureString") {

    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($twr_pass)            
    $p = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)            

} else {$p = $twr_pass}
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


try {
add-type @"
using System.Net;
using System.Security.Cryptography.X509Certificates;
public class TrustAllCertsPolicy : ICertificatePolicy {
public bool CheckValidationResult(
ServicePoint srvPoint, X509Certificate certificate,
WebRequest request, int certificateProblem) {
return true;
}
}
"@
} catch {}

[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
$EncodedAuthorization = [System.Text.Encoding]::UTF8.GetBytes($twr_user + ":" + $p)
    $EncodedPassword = [System.Convert]::ToBase64String($EncodedAuthorization)
    
$headers = @{
    "Authorization"="Basic $($EncodedPassword)"
    "Content-Type"="application/json"
}

$ansible_facts = @()

(Invoke-RestMethod -Method GET -Uri "https://$twr_server/api/v2/hosts/" -Headers $headers).results.id | ForEach-Object {
    $a = Invoke-RestMethod -Method GET -Uri "https://$twr_server/api/v2/hosts/$_/ansible_facts/" -Headers $headers
    if($a.ansible_hostname) {
        $ansible_facts += $a
    }
}

$ansible_facts