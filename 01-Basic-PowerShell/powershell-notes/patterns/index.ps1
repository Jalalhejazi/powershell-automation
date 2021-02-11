
help about_Regular_Expressions

chrome http://rubular.com 

<# demo character classes

    [abc]	A single character of: a, b, or c
    [^abc]	Any single character except: a, b, or c
    [a-z]	Any single character in the range a-z
    [a-zA-Z]	Any single character in the range a-z or A-Z
    ^	Start of line
    $	End of line
    \A	Start of string
    \z	End of string
    .	Any single character
    \s	Any whitespace character
    \S	Any non-whitespace character
    \d	Any digit
    \D	Any non-digit
    \w	Any word character (letter, number, underscore)
    \W	Any non-word character
    \b	Any word boundary
    (...)	Capture everything enclosed
    (a|b)	a or b
    a?	Zero or one of a
    a*	Zero or more of a
    a+	One or more of a
    a{3}	Exactly 3 of a
    a{3,}	3 or more of a
    a{3,6}	Between 3 and 6 of a

    *   Match 0 or more times
    +   Match 1 or more times
    ?   Match 0 or 1 time
    
#>



<# create a pattern to match on dev-2021
 ^\w{3}-\d{4}$
 or to match on alpha
 ^[a-zA-Z]{3}-\d{4}$
#>

$rg1 = "^\w{3}-\d{4}$"
$rg2 = "^[a-zA-Z]{3}-\d{4}$"

"dev-2021" -match $rg1
"dev-2021" -match $rg2

####################################################

"10.11.12" -match "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"
"10.11.121.130" -match "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"
$matches

#case sensitivity
"jalal" -like "Ja*"
"jalal" -clike "Ja*"

"jalal" -notlike "Ja*"
"jalal" -cnotlike "Ja*"

"PowerShell 7.1" -Match "P*shell"
"PowerShell 7.1" -cMatch "P*shell"
"PowerShell 7.1" -cnotMatch "P*shell"

#pattern matching drift
"jalal@firma.com" -match "\w+@\w*\.com"
$matches.0
"jalal@firma.com" -match "\w+@\w*\.com"
$matches.0
"jalal-foo@firma.com" -match "\w+@\w*\.com"
$matches.0

#avoid pattern matching drift
#you can use an anchor at the start
"jalal-foo@firma.com" -match "^\w+@\w*\.com"

#anchor at the end
"jalal@firma.com" -match "\w+@\w*\.com$"

#anchor both
"jalal@firma.com" -match "^\w+@\w*\.com$"
$matches.0
"jalal-foo@firma.com" -match "^\w+@\w*\.com$"

#one way to fix this pattern 
"jalal-foo@firma.com" -match "^\w+-\w+@\w*\.com$"
"jalal-foo@firma.com" -match "^\S+@\w*\.com$"



#########################################################

Function Test-CompanyIP {
    [cmdletbinding()]

    Param(
        [Parameter(Mandatory,HelpMessage = "Enter a company IPv4 address that starts with 10.")]
        [ValidatePattern("^10\.\d{1,3}\.\d{1,3}\.\d{1,3}$")]
        [string]$IPAddress
    )

    Write-Verbose "Testing $IPAddress"
    Write-Host "#Your code runs here" -ForegroundColor green

}

