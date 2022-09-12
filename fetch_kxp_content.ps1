


foreach($line in Get-Content C:\temp\kxp\gnd_auth_export_062022.csv ) {
    New-Item -Path "c:\temp\kxp\$line" -ItemType "directory"
    $dwld = "http://sru.k10plus.de/k10plus?operation=searchRetrieve&version=1.1&recordSchema=dc&startRecord=1&maximumRecords=100&query=pica.nid=$line"
    $stack = "c:\temp\kxp\$line\kxp.xml"
    
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($dwld,$stack)


[xml]$relation = Get-Content -Path $stack

#$zs=New-Object System.Xml.XmlNamespaceManager($relation.NameTable)
#$zs.AddNamespace("zs","http://www.loc.gov/zing/srw/")
#$relation.SelectNodes("//zs:searchRetrieveResponse",$zs)


$namespace = @{zs="http://www.loc.gov/zing/srw/"; dc="http://purl.org/dc/elements/1.1/"; oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"}
#new-item c:\temp\kxp\$identifier -itemtype directory

(Select-Xml -Path $stack -XPath "//zs:searchRetrieveResponse/zs:records/zs:record/zs:recordData/oai_dc:dc/dc:relation" -Namespace $namespace).Node.InnerXml > C:\temp\kxp\kxp_externallinks$line.txt
(Select-Xml -Path $stack -XPath "//zs:searchRetrieveResponse/zs:records/zs:record/zs:recordData/oai_dc:dc/dc:title" -Namespace $namespace).Node.InnerXml > C:\temp\kxp\kxp_title$line.txt
(Select-Xml -Path $stack -XPath "//zs:searchRetrieveResponse/zs:records/zs:record/zs:recordData/oai_dc:dc/dc:description" -Namespace $namespace).Node.InnerXml > C:\temp\kxp\kxp_description$line.txt
(Select-Xml -Path $stack -XPath "//zs:searchRetrieveResponse/zs:records/zs:record/zs:recordData/oai_dc:dc/dc:relation" -Namespace $namespace).Node.InnerXml > C:\temp\kxp\kxp_relation$line.txt
(Select-Xml -Path $stack -XPath "//zs:searchRetrieveResponse/zs:records/zs:record/zs:recordData/oai_dc:dc/dc:coverage" -Namespace $namespace).Node.InnerXml > C:\temp\kxp\kxp_coverage$line.txt
(Select-Xml -Path $stack -XPath "//zs:searchRetrieveResponse/zs:records/zs:record/zs:recordData/oai_dc:dc/dc:identifier" -Namespace $namespace).Node.InnerXml > C:\temp\kxp\kxp_identifier$line.txt

}


Get-ChildItem "C:\temp\kxp\coverage\input" -Filter *.txt | 
Foreach-Object {
    $content = Get-Content $_.FullName
    " DNB_ID: " + $_.FullName + "; Inhalt Coverage: " +$content + ";" | Add-Content -Path C:\temp\kxp\coverage\output\coverage.txt
} 


Get-ChildItem "C:\temp\kxp\description" -Filter *.txt | 
Foreach-Object {
    $content = Get-Content $_.FullName
    " DNB_ID: " + $_.FullName + "; Inhalt Description: " +$content + ";" | Add-Content -Path C:\temp\kxp\description\description.txt
} 


Get-ChildItem "C:\temp\kxp\external" -Filter *.txt | 
Foreach-Object {
    $content = Get-Content $_.FullName
    " DNB_ID: " + $_.FullName + "; Inhalt External: " +$content + ";" | Add-Content -Path C:\temp\kxp\external\external.txt
} 


Get-ChildItem "C:\temp\kxp\identifier" -Filter *.txt | 
Foreach-Object {
    $content = Get-Content $_.FullName
    " DNB_ID: " + $_.FullName + "; Inhalt Identifier: " +$content + ";" | Add-Content -Path C:\temp\kxp\identifier\identifier.txt
} 


Get-ChildItem "C:\temp\kxp\relation" -Filter *.txt | 
Foreach-Object {
    $content = Get-Content $_.FullName
    " DNB_ID: " + $_.FullName + "; Inhalt relation: " +$content + ";" | Add-Content -Path C:\temp\kxp\relation\relation.txt
} 


Get-ChildItem "C:\temp\kxp\title" -Filter *.txt | 
Foreach-Object {
    $content = Get-Content $_.FullName
    " DNB_ID: " + $_.FullName + "; Inhalt title: " +$content + ";" | Add-Content -Path C:\temp\kxp\title\title.txt
} 