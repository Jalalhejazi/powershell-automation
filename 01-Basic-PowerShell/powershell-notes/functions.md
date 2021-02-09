## Function
* All PowerShell inbuilt functions are in the form of `Verb-Noun`.
* Follow the same pattern while naming your functions.

```powershell
# simple hello function declaration
function Say-Hello {
    Write-Host "Welcome, It's good to see you here" -ForegroundColor Cyan 
}
# invoking/calling a function using its name
Say-Hello

# Adding two numbers which are passed as arguments
function Add-Numbers {
    $total = $args[0] + $args[1]  # + $args[2..10]
    Write-Output "Total: $total"
}

Add-Numbers 2 3 #[OUTPUT] Total: 5

# passing array as argument
function Add-Numbers($n) {
    $total = 0
    foreach($x in $n){
        $total += $x
    }
    Write-Output "Total: $total"
}

$nums = @(1,2,3,4,5,6)
Add-Numbers $nums #[OUTPUT] Total: 21

# Named Parameters/arguments to the function
# In case while calling function if you dont provide any country then by default is Greenland
function Get-Info {
    param(
        [string]$name,
        [int]$age,
        [string]$country = "Greenland"
    )
    Write-Output "Hey! My name is $name and I am $age years old. I came from $country"
}
Get-Info -name "Human"  -age 44 -country "Danmark"
Get-Info -name "Anja"   -age 33 -country "USA" 
Get-Info -name "Nadine" -age 18 
```

## What is a Pipeline Function ? 


```powershell
function Get-Function1 {
    [CmdletBinding()]
    param
    (
        [Parameter(ValueFromPipeline=$true)]
        $Text
    )
 
    Process {
        Write-Host "$Text"
    }

}

"demo1", "demo2" | Get-Function1

```