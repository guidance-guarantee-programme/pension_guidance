# Govspeak

[Govspeak](https://github.com/alphagov/govspeak) is a markdown-derived mark-up language.

# Extensions

In addition to the [standard Markdown syntax](http://daringfireball.net/projects/markdown/syntax), Govspeak adds its own extensions.

## Callouts

### Information callouts

^This is an information callout^

### Warning callouts

%This is a warning callout%

### Example callout

$E
**Example**: Open the pod bay doors
$E

## Highlights

### Advisory

@This is a very important message or warning@

### Answer

{::highlight-answer}
The VAT rate is *20%*
{:/highlight-answer}

## Points of Contact

### Contact

$C
**Student Finance England**
**Telephone:** 0845 300 50 90
**Minicom:** 0845 604 44 34
$C

### Address

$A
Hercules House
Hercules Road
London SE1 7DU
$A

## Downloads

$D
[An example form download link](http://example.com/ "Example form")

Something about this form download
$D

## Steps

s1. one
s2. two
s3. three


## Legislative Lists

$LegislativeList
* 1. Item 1
* 2. Item 2
* a) Item 2a
* b) Item 2b
* i. Item 2 b i
* ii. Item 2 b ii
* 3. Item 3
$EndLegislativeList


## Abbreviations

Special rules apply if you’re exporting a vehicle outside the EU.

*[EU]:European Union

## Devolved content

:england:content goes here:england:
:scotland:content goes here:scotland:
:london:content goes here:london:
:wales:content goes here:wales:
:northern-ireland:content goes here:northern-ireland:
:england-wales:content goes here:england-wales: