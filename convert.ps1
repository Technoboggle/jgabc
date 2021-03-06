foreach ($_ in $args[0]) {
  $f = Get-Content $_;
  $i = 0;
  $start = 0;
  $len = $f.length;
  $hasOE = $false;
  while($i -lt $len) {
    if($f[$i].indexof("œ") -ge 0) {
      $hasOE = $true;
      break;
    }
    $f[$i] = ($f[$i].Replace("\ae","æ").Replace("\oe","œ").Replace("\'{a}","á").Replace("\'{e}","é").Replace("\'{\i}","í").Replace("\'{o}","ó").Replace("\'{u}","ú").Replace("\'{y}","ý").Replace("\""{e}","ë").Replace("\AE","Æ").Replace("\OE","Œ").Replace("\'{A}","Á").Replace("\'{E}","É").Replace("\'{\I}","Í").Replace("\'{O}","Ó").Replace("\'{U}","Ú").Replace("\'{Y}","Ý").Replace("\""{E}","Ë").Replace("cæ lo","cælo").Replace("cæ li","cæli").Replace("præ cépto","præcépto").Replace("Æ gypto","Ægypto").Replace("Æ gýpto","Ægýpto").Replace("æ quit","æquit").Replace("sæ cul","sæcul").Replace("æ térn","ætérn").Replace("quæ cúmque","quæcúmque").Replace("æ .","æ.").Replace("æ ,","æ,").Replace("{\bf .}",".") -replace "^\s+|\s+$|\(\s*\w+\s+reverentia\s*\)|^\{\\bf Psalm.*$|^%.*$|^\{\\bf\s\d+\}\s+|\s+\\\\$","") -replace "\s+"," ";
    if($f[$i] -eq "") {
      if($start -eq $i) {
        $start = $i + 1;
      }
    }
    $i++;
  }
  $i = $len - 1;
  while($i -gt 0) {
    if($f[$i] -eq "") {
      $len = $i;
      $i--;
    } else {
      break;
    }
  }
  $f[$start..$len] | out-file ($_.Name) -Encoding UTF8
  
  $i = $start;
  while($i -lt $len) {
    $f[$i] = $f[$i] + "<br />";
    $i++;
  }
  $f[$start..$len] | out-file ("..\web-psalms\" + ($_.Name)) -Encoding UTF8
}