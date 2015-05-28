#!/usr/bin/php
<?php
/*******************************************************************************************
// @desc 	- a simple command line tool to get the next incoming train to Ballston Station
// @params 	- Line=OR, api_key=kfgpmgvfgacx98de9q3xazww
// @auth 	- N. Peterson 
// @date 	- 05272015 
//******************************************************************************************/

// nothing fancy here because only employees would use a command line tool.
$ch = curl_init();
curl_setopt ($ch, CURLOPT_URL, "https://api.wmata.com/StationPrediction.svc/json/GetPrediction/All?api_key=kfgpmgvfgacx98de9q3xazww");
curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt ($ch, CURLOPT_CONNECTTIMEOUT, 0);
$response_data = curl_exec($ch);
curl_close($ch);

$tmp  = json_decode($response_data, true);
$data = $tmp['Trains'];
$min  = 999;

// LocationCode K04 = Ballston-MU, OR is for the Orange Line. 
// This picks the train that will arrive the soonest.
foreach($data as $stop) {
	if($stop['LocationCode'] == 'K04' && $stop['Line'] == 'OR') {
		if($stop['Min'] < $min) {
			$out = $stop;
			$min = $stop['Min'];
		}
	}
}

$dest = $out['DestinationName'];

echo "The Next Orange Line train will arrive at Ballston-MU station in " . $min . " minutes, and will be going to " . $dest . ".";
?>

