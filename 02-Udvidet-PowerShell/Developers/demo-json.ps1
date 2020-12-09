$json = @"
{
    "firstName": "John",
    "lastName" : "Smith",
    "age"      : "25",
    "address"  :
    {
        "streetAddress": "21 2nd Street",
        "city"         : "New York",
        "state"        : "NY",
        "postalCode"   : "10021"
    },
     "phoneNumber":
     [
         {
            "type"  : "home",
            "number": "212 555-1234"
         },
         {
            "type"  : "mobile",
            "number": "646 555-4567"
         }
     ]
 }
"@

clear-host

$PowerShellRepresentation = $json | ConvertFrom-Json 
$PowerShellRepresentation | Out-String


$PowerShellRepresentation.address | format-table -a | Out-String
$PowerShellRepresentation.phoneNumber | format-table -a | Out-String


$PowerShellRepresentation | ConvertTo-Json | Out-String