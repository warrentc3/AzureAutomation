function Get-O365RegionData {
$CountryCodes = New-Object -TypeName System.Collections.ArrayList;
$CountryCodes.Add([PSCustomObject]@{ Country = "Afghanistan"; ISO2 = "AF"; ISO3 = "AFG"; UNM49 = "004"; Region = "APAC"; SubRegion = "Asia South"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Åland Islands"; ISO2 = "AX"; ISO3 = "ALA"; UNM49 = "248"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Albania"; ISO2 = "AL"; ISO3 = "ALB"; UNM49 = "008"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Algeria"; ISO2 = "DZ"; ISO3 = "DZA"; UNM49 = "012"; Region = "EMEA"; SubRegion = "Africa North"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "American Samoa"; ISO2 = "AS"; ISO3 = "ASM"; UNM49 = "016"; Region = "APAC"; SubRegion = "Australasia"; PDL = "AUS"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Andorra"; ISO2 = "AD"; ISO3 = "AND"; UNM49 = "020"; Region = "EMEA"; SubRegion = "Europe"; PDL = "FRA"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Angola"; ISO2 = "AO"; ISO3 = "AGO"; UNM49 = "024"; Region = "EMEA"; SubRegion = "Africa Central"; PDL = "ZAF"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Anguilla"; ISO2 = "AI"; ISO3 = "AIA"; UNM49 = "660"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Antigua and Barbuda"; ISO2 = "AG"; ISO3 = "ATG"; UNM49 = "028"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Argentina"; ISO2 = "AR"; ISO3 = "ARG"; UNM49 = "032"; Region = "LATM"; SubRegion = "South America"; PDL = "BRA"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Armenia"; ISO2 = "AM"; ISO3 = "ARM"; UNM49 = "051"; Region = "APAC"; SubRegion = "Asia West"; PDL = "ARE"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Aruba"; ISO2 = "AW"; ISO3 = "ABW"; UNM49 = "533"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Australia"; ISO2 = "AU"; ISO3 = "AUS"; UNM49 = "036"; Region = "APAC"; SubRegion = "Australasia"; PDL = "AUS"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Austria"; ISO2 = "AT"; ISO3 = "AUT"; UNM49 = "040"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Azerbaijan"; ISO2 = "AZ"; ISO3 = "AZE"; UNM49 = "031"; Region = "APAC"; SubRegion = "Asia West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Bahamas"; ISO2 = "BS"; ISO3 = "BHS"; UNM49 = "044"; Region = "AMER"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Bahrain"; ISO2 = "BH"; ISO3 = "BHR"; UNM49 = "048"; Region = "APAC"; SubRegion = "Asia West"; PDL = "ARE"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Bangladesh"; ISO2 = "BD"; ISO3 = "BGD"; UNM49 = "050"; Region = "APAC"; SubRegion = "Asia South"; PDL = "IND"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Barbados"; ISO2 = "BB"; ISO3 = "BRB"; UNM49 = "052"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Belarus"; ISO2 = "BY"; ISO3 = "BLR"; UNM49 = "112"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Belgium"; ISO2 = "BE"; ISO3 = "BEL"; UNM49 = "056"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Belize"; ISO2 = "BZ"; ISO3 = "BLZ"; UNM49 = "084"; Region = "LATM"; SubRegion = "Central America"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Benin"; ISO2 = "BJ"; ISO3 = "BEN"; UNM49 = "204"; Region = "EMEA"; SubRegion = "Africa West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Bermuda"; ISO2 = "BM"; ISO3 = "BMU"; UNM49 = "060"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Bhutan"; ISO2 = "BT"; ISO3 = "BTN"; UNM49 = "064"; Region = "APAC"; SubRegion = "Asia South"; PDL = "IND"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Bolivia"; ISO2 = "BO"; ISO3 = "BOL"; UNM49 = "068"; Region = "LATM"; SubRegion = "South America"; PDL = "BRA"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Bonaire, Sint Eustatius and Saba"; ISO2 = "BQ"; ISO3 = "BES"; UNM49 = "535"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Bosnia and Herzegovina"; ISO2 = "BA"; ISO3 = "BIH"; UNM49 = "070"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Botswana"; ISO2 = "BW"; ISO3 = "BWA"; UNM49 = "072"; Region = "EMEA"; SubRegion = "Africa South"; PDL = "ZAF"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Brazil"; ISO2 = "BR"; ISO3 = "BRA"; UNM49 = "076"; Region = "LATM"; SubRegion = "South America"; PDL = "BRA"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "British Indian Ocean Territory"; ISO2 = "IO"; ISO3 = "IOT"; UNM49 = "086"; Region = "APAC"; SubRegion = "Asia South"; PDL = "IND"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "British Virgin Islands"; ISO2 = "VG"; ISO3 = "VGB"; UNM49 = "092"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Brunei"; ISO2 = "BN"; ISO3 = "BRN"; UNM49 = "096"; Region = "APAC"; SubRegion = "Australasia"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Bulgaria"; ISO2 = "BG"; ISO3 = "BGR"; UNM49 = "100"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Burkina Faso"; ISO2 = "BF"; ISO3 = "BFA"; UNM49 = "854"; Region = "EMEA"; SubRegion = "Africa West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Burundi"; ISO2 = "BI"; ISO3 = "BDI"; UNM49 = "108"; Region = "EMEA"; SubRegion = "Africa East"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Cambodia"; ISO2 = "KH"; ISO3 = "KHM"; UNM49 = "116"; Region = "APAC"; SubRegion = "Australasia"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Cameroon"; ISO2 = "CM"; ISO3 = "CMR"; UNM49 = "120"; Region = "EMEA"; SubRegion = "Africa Central"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Canada"; ISO2 = "CA"; ISO3 = "CAN"; UNM49 = "124"; Region = "AMER"; SubRegion = "North America"; PDL = "CAN"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Cabo Verde"; ISO2 = "CV"; ISO3 = "CPV"; UNM49 = "132"; Region = "EMEA"; SubRegion = "Africa West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Cayman Islands"; ISO2 = "KY"; ISO3 = "CYM"; UNM49 = "136"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Central African Republic"; ISO2 = "CF"; ISO3 = "CAF"; UNM49 = "140"; Region = "EMEA"; SubRegion = "Africa Central"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Chad"; ISO2 = "TD"; ISO3 = "TCD"; UNM49 = "148"; Region = "EMEA"; SubRegion = "Africa Central"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Chile"; ISO2 = "CL"; ISO3 = "CHL"; UNM49 = "152"; Region = "LATM"; SubRegion = "South America"; PDL = "BRA"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "China"; ISO2 = "CN"; ISO3 = "CHN"; UNM49 = "156"; Region = "APAC"; SubRegion = "Asia East"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Christmas Island"; ISO2 = "CX"; ISO3 = "CXR"; UNM49 = "162"; Region = "APAC"; SubRegion = "Australasia"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Cocos (Keeling) Islands"; ISO2 = "CC"; ISO3 = "CCK"; UNM49 = "166"; Region = "APAC"; SubRegion = "Australasia"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Colombia"; ISO2 = "CO"; ISO3 = "COL"; UNM49 = "170"; Region = "LATM"; SubRegion = "South America"; PDL = "BRA"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Comoros"; ISO2 = "KM"; ISO3 = "COM"; UNM49 = "174"; Region = "EMEA"; SubRegion = "Africa East"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Cook Islands"; ISO2 = "CK"; ISO3 = "COK"; UNM49 = "184"; Region = "APAC"; SubRegion = "Australasia"; PDL = "AUS"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Costa Rica"; ISO2 = "CR"; ISO3 = "CRI"; UNM49 = "188"; Region = "LATM"; SubRegion = "Central America"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Croatia"; ISO2 = "HR"; ISO3 = "HRV"; UNM49 = "191"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Côte d’Ivoire"; ISO2 = "CI"; ISO3 = "CIV"; UNM49 = "384"; Region = "EMEA"; SubRegion = "Africa West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Cuba"; ISO2 = "CU"; ISO3 = "CUB"; UNM49 = "192"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Curaçao"; ISO2 = "CW"; ISO3 = "CUW"; UNM49 = "531"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Cyprus"; ISO2 = "CY"; ISO3 = "CYP"; UNM49 = "196"; Region = "EMEA"; SubRegion = "Asia West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Czechia"; ISO2 = "CZ"; ISO3 = "CZE"; UNM49 = "203"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Congo (DRC)"; ISO2 = "CD"; ISO3 = "COD"; UNM49 = "180"; Region = "EMEA"; SubRegion = "Africa Central"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Denmark"; ISO2 = "DK"; ISO3 = "DNK"; UNM49 = "208"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Djibouti"; ISO2 = "DJ"; ISO3 = "DJI"; UNM49 = "262"; Region = "EMEA"; SubRegion = "Africa East"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Dominica"; ISO2 = "DM"; ISO3 = "DMA"; UNM49 = "212"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Dominican Republic"; ISO2 = "DO"; ISO3 = "DOM"; UNM49 = "214"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Ecuador"; ISO2 = "EC"; ISO3 = "ECU"; UNM49 = "218"; Region = "LATM"; SubRegion = "South America"; PDL = "BRA"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Egypt"; ISO2 = "EG"; ISO3 = "EGY"; UNM49 = "818"; Region = "EMEA"; SubRegion = "Africa North"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "El Salvador"; ISO2 = "SV"; ISO3 = "SLV"; UNM49 = "222"; Region = "LATM"; SubRegion = "Central America"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Equatorial Guinea"; ISO2 = "GQ"; ISO3 = "GNQ"; UNM49 = "226"; Region = "EMEA"; SubRegion = "Africa Central"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Eritrea"; ISO2 = "ER"; ISO3 = "ERI"; UNM49 = "232"; Region = "EMEA"; SubRegion = "Africa East"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Estonia"; ISO2 = "EE"; ISO3 = "EST"; UNM49 = "233"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Ethiopia"; ISO2 = "ET"; ISO3 = "ETH"; UNM49 = "231"; Region = "EMEA"; SubRegion = "Africa East"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Falkland Islands"; ISO2 = "FK"; ISO3 = "FLK"; UNM49 = "238"; Region = "AMER"; SubRegion = "South America"; PDL = "BRA"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Faroe Islands"; ISO2 = "FO"; ISO3 = "FRO"; UNM49 = "234"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Fiji"; ISO2 = "FJ"; ISO3 = "FJI"; UNM49 = "242"; Region = "APAC"; SubRegion = "Australasia"; PDL = "AUS"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Finland"; ISO2 = "FI"; ISO3 = "FIN"; UNM49 = "246"; Region = "EMEA"; SubRegion = "Europe"; PDL = "NOR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "France"; ISO2 = "FR"; ISO3 = "FRA"; UNM49 = "250"; Region = "EMEA"; SubRegion = "Europe"; PDL = "FRA"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "French Guiana"; ISO2 = "GF"; ISO3 = "GUF"; UNM49 = "254"; Region = "AMER"; SubRegion = "South America"; PDL = "BRA"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "French Polynesia"; ISO2 = "PF"; ISO3 = "PYF"; UNM49 = "258"; Region = "APAC"; SubRegion = "Australasia"; PDL = "AUS"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Gabon"; ISO2 = "GA"; ISO3 = "GAB"; UNM49 = "266"; Region = "EMEA"; SubRegion = "Africa West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Gambia"; ISO2 = "GM"; ISO3 = "GMB"; UNM49 = "270"; Region = "EMEA"; SubRegion = "Africa West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Georgia"; ISO2 = "GE"; ISO3 = "GEO"; UNM49 = "268"; Region = "EMEA"; SubRegion = "Asia West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Germany"; ISO2 = "DE"; ISO3 = "DEU"; UNM49 = "276"; Region = "EMEA"; SubRegion = "Europe"; PDL = "DEU"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Ghana"; ISO2 = "GH"; ISO3 = "GHA"; UNM49 = "288"; Region = "EMEA"; SubRegion = "Africa West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Gibraltar"; ISO2 = "GI"; ISO3 = "GIB"; UNM49 = "292"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Greece"; ISO2 = "GR"; ISO3 = "GRC"; UNM49 = "300"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Greenland"; ISO2 = "GL"; ISO3 = "GRL"; UNM49 = "304"; Region = "AMER"; SubRegion = "North America"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Grenada"; ISO2 = "GD"; ISO3 = "GRD"; UNM49 = "308"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Guadeloupe"; ISO2 = "GP"; ISO3 = "GLP"; UNM49 = "312"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Guam"; ISO2 = "GU"; ISO3 = "GUM"; UNM49 = "316"; Region = "LATM"; SubRegion = "Australasia"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Guatemala"; ISO2 = "GT"; ISO3 = "GTM"; UNM49 = "320"; Region = "LATM"; SubRegion = "Central America"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Guernsey"; ISO2 = "GG"; ISO3 = "GGY"; UNM49 = "831"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Guinea"; ISO2 = "GN"; ISO3 = "GIN"; UNM49 = "324"; Region = "EMEA"; SubRegion = "Africa West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Guinea-Bissau"; ISO2 = "GW"; ISO3 = "GNB"; UNM49 = "624"; Region = "EMEA"; SubRegion = "Africa West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Guyana"; ISO2 = "GY"; ISO3 = "GUY"; UNM49 = "328"; Region = "LATM"; SubRegion = "South America"; PDL = "BRA"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Haiti"; ISO2 = "HT"; ISO3 = "HTI"; UNM49 = "332"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Vatican City"; ISO2 = "VA"; ISO3 = "VAT"; UNM49 = "336"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Honduras"; ISO2 = "HN"; ISO3 = "HND"; UNM49 = "340"; Region = "LATM"; SubRegion = "Central America"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Hong Kong SAR"; ISO2 = "HK"; ISO3 = "HKG"; UNM49 = "344"; Region = "APAC"; SubRegion = "Asia East"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Hungary"; ISO2 = "HU"; ISO3 = "HUN"; UNM49 = "348"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Iceland"; ISO2 = "IS"; ISO3 = "ISL"; UNM49 = "352"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "India"; ISO2 = "IN"; ISO3 = "IND"; UNM49 = "356"; Region = "APAC"; SubRegion = "Asia South"; PDL = "IND"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Indonesia"; ISO2 = "ID"; ISO3 = "IDN"; UNM49 = "360"; Region = "APAC"; SubRegion = "Australasia"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Iran"; ISO2 = "IR"; ISO3 = "IRN"; UNM49 = "364"; Region = "APAC"; SubRegion = "Asia West"; PDL = "ARE"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Iraq"; ISO2 = "IQ"; ISO3 = "IRQ"; UNM49 = "368"; Region = "EMEA"; SubRegion = "Asia West"; PDL = "ARE"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Ireland"; ISO2 = "IE"; ISO3 = "IRL"; UNM49 = "372"; Region = "EMEA"; SubRegion = "Europe"; PDL = "GBR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Isle of Man"; ISO2 = "IM"; ISO3 = "IMN"; UNM49 = "833"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Israel"; ISO2 = "IL"; ISO3 = "ISR"; UNM49 = "376"; Region = "EMEA"; SubRegion = "Asia West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Italy"; ISO2 = "IT"; ISO3 = "ITA"; UNM49 = "380"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Jamaica"; ISO2 = "JM"; ISO3 = "JAM"; UNM49 = "388"; Region = "AMER"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Japan"; ISO2 = "JP"; ISO3 = "JPN"; UNM49 = "392"; Region = "APAC"; SubRegion = "Asia East"; PDL = "JPN"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Jersey"; ISO2 = "JE"; ISO3 = "JEY"; UNM49 = "832"; Region = "EMEA"; SubRegion = "Europe"; PDL = "FRA"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Jordan"; ISO2 = "JO"; ISO3 = "JOR"; UNM49 = "400"; Region = "EMEA"; SubRegion = "Asia West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Kazakhstan"; ISO2 = "KZ"; ISO3 = "KAZ"; UNM49 = "398"; Region = "APAC"; SubRegion = "Asia Central"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Kenya"; ISO2 = "KE"; ISO3 = "KEN"; UNM49 = "404"; Region = "EMEA"; SubRegion = "Africa East"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Kiribati"; ISO2 = "KI"; ISO3 = "KIR"; UNM49 = "296"; Region = "APAC"; SubRegion = "Australasia"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Kosovo"; ISO2 = "XK"; ISO3 = "XXK"; UNM49 = "000"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Kuwait"; ISO2 = "KW"; ISO3 = "KWT"; UNM49 = "414"; Region = "APAC"; SubRegion = "Asia West"; PDL = "ARE"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Kyrgyzstan"; ISO2 = "KG"; ISO3 = "KGZ"; UNM49 = "417"; Region = "APAC"; SubRegion = "Asia Central"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Laos"; ISO2 = "LA"; ISO3 = "LAO"; UNM49 = "418"; Region = "APAC"; SubRegion = "Australasia"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Latvia"; ISO2 = "LV"; ISO3 = "LVA"; UNM49 = "428"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Lebanon"; ISO2 = "LB"; ISO3 = "LBN"; UNM49 = "422"; Region = "EMEA"; SubRegion = "Asia West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Lesotho"; ISO2 = "LS"; ISO3 = "LSO"; UNM49 = "426"; Region = "EMEA"; SubRegion = "Africa South"; PDL = "ZAF"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Liberia"; ISO2 = "LR"; ISO3 = "LBR"; UNM49 = "430"; Region = "EMEA"; SubRegion = "Africa West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Libya"; ISO2 = "LY"; ISO3 = "LBY"; UNM49 = "434"; Region = "EMEA"; SubRegion = "Africa North"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Liechtenstein"; ISO2 = "LI"; ISO3 = "LIE"; UNM49 = "438"; Region = "EMEA"; SubRegion = "Europe"; PDL = "CHE"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Lithuania"; ISO2 = "LT"; ISO3 = "LTU"; UNM49 = "440"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Luxembourg"; ISO2 = "LU"; ISO3 = "LUX"; UNM49 = "442"; Region = "EMEA"; SubRegion = "Europe"; PDL = "FRA"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Macao SAR"; ISO2 = "MO"; ISO3 = "MAC"; UNM49 = "446"; Region = "APAC"; SubRegion = "Asia East"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Madagascar"; ISO2 = "MG"; ISO3 = "MDG"; UNM49 = "450"; Region = "EMEA"; SubRegion = "Africa East"; PDL = "ZAF"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Malawi"; ISO2 = "MW"; ISO3 = "MWI"; UNM49 = "454"; Region = "EMEA"; SubRegion = "Africa East"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Malaysia"; ISO2 = "MY"; ISO3 = "MYS"; UNM49 = "458"; Region = "APAC"; SubRegion = "Australasia"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Maldives"; ISO2 = "MV"; ISO3 = "MDV"; UNM49 = "462"; Region = "APAC"; SubRegion = "Asia South"; PDL = "IND"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Mali"; ISO2 = "ML"; ISO3 = "MLI"; UNM49 = "466"; Region = "EMEA"; SubRegion = "Africa West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Malta"; ISO2 = "MT"; ISO3 = "MLT"; UNM49 = "470"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Marshall Islands"; ISO2 = "MH"; ISO3 = "MHL"; UNM49 = "584"; Region = "APAC"; SubRegion = "Australasia"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Martinique"; ISO2 = "MQ"; ISO3 = "MTQ"; UNM49 = "474"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Mauritania"; ISO2 = "MR"; ISO3 = "MRT"; UNM49 = "478"; Region = "EMEA"; SubRegion = "Africa West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Mauritius"; ISO2 = "MU"; ISO3 = "MUS"; UNM49 = "480"; Region = "EMEA"; SubRegion = "Africa East"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Mayotte"; ISO2 = "YT"; ISO3 = "MYT"; UNM49 = "175"; Region = "EMEA"; SubRegion = "Africa East"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Mexico"; ISO2 = "MX"; ISO3 = "MEX"; UNM49 = "484"; Region = "LATM"; SubRegion = "North America"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Micronesia"; ISO2 = "FM"; ISO3 = "FSM"; UNM49 = "583"; Region = "APAC"; SubRegion = "Australasia"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Moldova"; ISO2 = "MD"; ISO3 = "MDA"; UNM49 = "498"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Monaco"; ISO2 = "MC"; ISO3 = "MCO"; UNM49 = "492"; Region = "EMEA"; SubRegion = "Europe"; PDL = "FRA"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Mongolia"; ISO2 = "MN"; ISO3 = "MNG"; UNM49 = "496"; Region = "APAC"; SubRegion = "Asia East"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Montenegro"; ISO2 = "ME"; ISO3 = "MNE"; UNM49 = "499"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Montserrat"; ISO2 = "MS"; ISO3 = "MSR"; UNM49 = "500"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Morocco"; ISO2 = "MA"; ISO3 = "MAR"; UNM49 = "504"; Region = "EMEA"; SubRegion = "Africa North"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Mozambique"; ISO2 = "MZ"; ISO3 = "MOZ"; UNM49 = "508"; Region = "EMEA"; SubRegion = "Africa East"; PDL = "ZAF"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Myanmar"; ISO2 = "MM"; ISO3 = "MMR"; UNM49 = "104"; Region = "APAC"; SubRegion = "Australasia"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Namibia"; ISO2 = "NA"; ISO3 = "NAM"; UNM49 = "516"; Region = "EMEA"; SubRegion = "Africa South"; PDL = "ZAF"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Nauru"; ISO2 = "NR"; ISO3 = "NRU"; UNM49 = "520"; Region = "APAC"; SubRegion = "Australasia"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Nepal"; ISO2 = "NP"; ISO3 = "NPL"; UNM49 = "524"; Region = "APAC"; SubRegion = "Asia South"; PDL = "IND"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Netherlands"; ISO2 = "NL"; ISO3 = "NLD"; UNM49 = "528"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "New Caledonia"; ISO2 = "NC"; ISO3 = "NCL"; UNM49 = "540"; Region = "APAC"; SubRegion = "Australasia"; PDL = "AUS"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "New Zealand"; ISO2 = "NZ"; ISO3 = "NZL"; UNM49 = "554"; Region = "APAC"; SubRegion = "Australasia"; PDL = "AUS"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Nicaragua"; ISO2 = "NI"; ISO3 = "NIC"; UNM49 = "558"; Region = "LATM"; SubRegion = "Central America"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Niger"; ISO2 = "NE"; ISO3 = "NER"; UNM49 = "562"; Region = "EMEA"; SubRegion = "Africa West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Nigeria"; ISO2 = "NG"; ISO3 = "NGA"; UNM49 = "566"; Region = "EMEA"; SubRegion = "Africa West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Niue"; ISO2 = "NU"; ISO3 = "NIU"; UNM49 = "570"; Region = "APAC"; SubRegion = "Australasia"; PDL = "AUS"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Norfolk Island"; ISO2 = "NF"; ISO3 = "NFK"; UNM49 = "574"; Region = "APAC"; SubRegion = "Australasia"; PDL = "AUS"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "North Korea"; ISO2 = "KP"; ISO3 = "PRK"; UNM49 = "408"; Region = "APAC"; SubRegion = "Asia East"; PDL = "KOR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Northern Mariana Islands"; ISO2 = "MP"; ISO3 = "MNP"; UNM49 = "580"; Region = "APAC"; SubRegion = "Australasia"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Norway"; ISO2 = "NO"; ISO3 = "NOR"; UNM49 = "578"; Region = "EMEA"; SubRegion = "Europe"; PDL = "NOR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Oman"; ISO2 = "OM"; ISO3 = "OMN"; UNM49 = "512"; Region = "APAC"; SubRegion = "Asia West"; PDL = "ARE"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Pakistan"; ISO2 = "PK"; ISO3 = "PAK"; UNM49 = "586"; Region = "APAC"; SubRegion = "Asia South"; PDL = "IND"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Palau"; ISO2 = "PW"; ISO3 = "PLW"; UNM49 = "585"; Region = "APAC"; SubRegion = "Australasia"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Palestinian Authority"; ISO2 = "PS"; ISO3 = "PSE"; UNM49 = "275"; Region = "EMEA"; SubRegion = "Asia West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Panama"; ISO2 = "PA"; ISO3 = "PAN"; UNM49 = "591"; Region = "LATM"; SubRegion = "Central America"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Papua New Guinea"; ISO2 = "PG"; ISO3 = "PNG"; UNM49 = "598"; Region = "APAC"; SubRegion = "Australasia"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Paraguay"; ISO2 = "PY"; ISO3 = "PRY"; UNM49 = "600"; Region = "LATM"; SubRegion = "South America"; PDL = "BRA"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Peru"; ISO2 = "PE"; ISO3 = "PER"; UNM49 = "604"; Region = "LATM"; SubRegion = "South America"; PDL = "BRA"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Philippines"; ISO2 = "PH"; ISO3 = "PHL"; UNM49 = "608"; Region = "APAC"; SubRegion = "Australasia"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Pitcairn Islands"; ISO2 = "PN"; ISO3 = "PCN"; UNM49 = "612"; Region = "LATM"; SubRegion = "South America"; PDL = "BRA"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Poland"; ISO2 = "PL"; ISO3 = "POL"; UNM49 = "616"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Portugal"; ISO2 = "PT"; ISO3 = "PRT"; UNM49 = "620"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Puerto Rico"; ISO2 = "PR"; ISO3 = "PRI"; UNM49 = "630"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Qatar"; ISO2 = "QA"; ISO3 = "QAT"; UNM49 = "634"; Region = "APAC"; SubRegion = "Asia West"; PDL = "ARE"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Macedonia, FYRO"; ISO2 = "MK"; ISO3 = "MKD"; UNM49 = "807"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Congo"; ISO2 = "CG"; ISO3 = "COG"; UNM49 = "178"; Region = "EMEA"; SubRegion = "Africa Central"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Romania"; ISO2 = "RO"; ISO3 = "ROU"; UNM49 = "642"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Réunion"; ISO2 = "RE"; ISO3 = "REU"; UNM49 = "638"; Region = "EMEA"; SubRegion = "Africa East"; PDL = "ZAF"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Russia"; ISO2 = "RU"; ISO3 = "RUS"; UNM49 = "643"; Region = "APAC"; SubRegion = "Asia North"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Rwanda"; ISO2 = "RW"; ISO3 = "RWA"; UNM49 = "646"; Region = "EMEA"; SubRegion = "Africa East"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "St Helena, Ascension, Tristan da Cunha"; ISO2 = "SH"; ISO3 = "SHN"; UNM49 = "654"; Region = "EMEA"; SubRegion = "Africa West"; PDL = "ZAF"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Saint Kitts and Nevis"; ISO2 = "KN"; ISO3 = "KNA"; UNM49 = "659"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Saint Lucia"; ISO2 = "LC"; ISO3 = "LCA"; UNM49 = "662"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Saint Pierre and Miquelon"; ISO2 = "PM"; ISO3 = "SPM"; UNM49 = "666"; Region = "LATM"; SubRegion = "North America"; PDL = "CAN"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Saint Vincent and the Grenadines"; ISO2 = "VC"; ISO3 = "VCT"; UNM49 = "670"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Saint Barthélemy"; ISO2 = "BL"; ISO3 = "BLM"; UNM49 = "652"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Saint Martin"; ISO2 = "MF"; ISO3 = "MAF"; UNM49 = "663"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Samoa"; ISO2 = "WS"; ISO3 = "WSM"; UNM49 = "882"; Region = "APAC"; SubRegion = "Australasia"; PDL = "AUS"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "San Marino"; ISO2 = "SM"; ISO3 = "SMR"; UNM49 = "674"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "São Tomé and Príncipe"; ISO2 = "ST"; ISO3 = "STP"; UNM49 = "678"; Region = "EMEA"; SubRegion = "Africa Central"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Saudi Arabia"; ISO2 = "SA"; ISO3 = "SAU"; UNM49 = "682"; Region = "APAC"; SubRegion = "Asia West"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Senegal"; ISO2 = "SN"; ISO3 = "SEN"; UNM49 = "686"; Region = "EMEA"; SubRegion = "Africa West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Serbia"; ISO2 = "RS"; ISO3 = "SRB"; UNM49 = "688"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Seychelles"; ISO2 = "SC"; ISO3 = "SYC"; UNM49 = "690"; Region = "EMEA"; SubRegion = "Africa East"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Sierra Leone"; ISO2 = "SL"; ISO3 = "SLE"; UNM49 = "694"; Region = "EMEA"; SubRegion = "Africa West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Singapore"; ISO2 = "SG"; ISO3 = "SGP"; UNM49 = "702"; Region = "APAC"; SubRegion = "Australasia"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Sint Maarten"; ISO2 = "SX"; ISO3 = "SXM"; UNM49 = "534"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Slovakia"; ISO2 = "SK"; ISO3 = "SVK"; UNM49 = "703"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Slovenia"; ISO2 = "SI"; ISO3 = "SVN"; UNM49 = "705"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Solomon Islands"; ISO2 = "SB"; ISO3 = "SLB"; UNM49 = "090"; Region = "APAC"; SubRegion = "Australasia"; PDL = "AUS"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Somalia"; ISO2 = "SO"; ISO3 = "SOM"; UNM49 = "706"; Region = "EMEA"; SubRegion = "Africa East"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "South Africa"; ISO2 = "ZA"; ISO3 = "ZAF"; UNM49 = "710"; Region = "EMEA"; SubRegion = "Africa South"; PDL = "ZAF"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Korea"; ISO2 = "KR"; ISO3 = "KOR"; UNM49 = "410"; Region = "APAC"; SubRegion = "Asia East"; PDL = "KOR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "South Sudan"; ISO2 = "SS"; ISO3 = "SSD"; UNM49 = "728"; Region = "EMEA"; SubRegion = "Africa South"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Spain"; ISO2 = "ES"; ISO3 = "ESP"; UNM49 = "724"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Sri Lanka"; ISO2 = "LK"; ISO3 = "LKA"; UNM49 = "144"; Region = "APAC"; SubRegion = "Asia South"; PDL = "IND"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Sudan"; ISO2 = "SD"; ISO3 = "SDN"; UNM49 = "736"; Region = "EMEA"; SubRegion = "Africa North"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Suriname"; ISO2 = "SR"; ISO3 = "SUR"; UNM49 = "740"; Region = "AMER"; SubRegion = "South America"; PDL = "BRA"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Svalbard and Jan Mayen"; ISO2 = "SJ"; ISO3 = "SJM"; UNM49 = "744"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Swaziland"; ISO2 = "SZ"; ISO3 = "SWZ"; UNM49 = "748"; Region = "EMEA"; SubRegion = "Africa South"; PDL = "ZAF"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Sweden"; ISO2 = "SE"; ISO3 = "SWE"; UNM49 = "752"; Region = "EMEA"; SubRegion = "Europe"; PDL = "NOR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Switzerland"; ISO2 = "CH"; ISO3 = "CHE"; UNM49 = "756"; Region = "EMEA"; SubRegion = "Europe"; PDL = "CHE"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Syria"; ISO2 = "SY"; ISO3 = "SYR"; UNM49 = "760"; Region = "EMEA"; SubRegion = "Asia West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Taiwan"; ISO2 = "TW"; ISO3 = "TWN"; UNM49 = "158"; Region = "APAC"; SubRegion = "Asia East"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Tajikistan"; ISO2 = "TJ"; ISO3 = "TJK"; UNM49 = "762"; Region = "APAC"; SubRegion = "Asia Central"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Tanzania"; ISO2 = "TZ"; ISO3 = "TZA"; UNM49 = "834"; Region = "EMEA"; SubRegion = "Africa East"; PDL = "ZAF"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Thailand"; ISO2 = "TH"; ISO3 = "THA"; UNM49 = "764"; Region = "APAC"; SubRegion = "Australasia"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Timor-Leste"; ISO2 = "TL"; ISO3 = "TLS"; UNM49 = "626"; Region = "APAC"; SubRegion = "Australasia"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Togo"; ISO2 = "TG"; ISO3 = "TGO"; UNM49 = "768"; Region = "EMEA"; SubRegion = "Africa West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Tokelau"; ISO2 = "TK"; ISO3 = "TKL"; UNM49 = "772"; Region = "APAC"; SubRegion = "Australasia"; PDL = "AUS"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Tonga"; ISO2 = "TO"; ISO3 = "TON"; UNM49 = "776"; Region = "APAC"; SubRegion = "Australasia"; PDL = "AUS"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Trinidad and Tobago"; ISO2 = "TT"; ISO3 = "TTO"; UNM49 = "780"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Tunisia"; ISO2 = "TN"; ISO3 = "TUN"; UNM49 = "788"; Region = "EMEA"; SubRegion = "Africa North"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Turkey"; ISO2 = "TR"; ISO3 = "TUR"; UNM49 = "792"; Region = "EMEA"; SubRegion = "Asia West"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Turkmenistan"; ISO2 = "TM"; ISO3 = "TKM"; UNM49 = "795"; Region = "APAC"; SubRegion = "Asia Central"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Turks and Caicos Islands"; ISO2 = "TC"; ISO3 = "TCA"; UNM49 = "796"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Tuvalu"; ISO2 = "TV"; ISO3 = "TUV"; UNM49 = "798"; Region = "APAC"; SubRegion = "Australasia"; PDL = "AUS"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Uganda"; ISO2 = "UG"; ISO3 = "UGA"; UNM49 = "800"; Region = "EMEA"; SubRegion = "Africa East"; PDL = "ZAF"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Ukraine"; ISO2 = "UA"; ISO3 = "UKR"; UNM49 = "804"; Region = "EMEA"; SubRegion = "Europe"; PDL = "EUR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "United Arab Emirates"; ISO2 = "AE"; ISO3 = "ARE"; UNM49 = "784"; Region = "APAC"; SubRegion = "Asia West"; PDL = "ARE"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "United Kingdom"; ISO2 = "GB"; ISO3 = "GBR"; UNM49 = "826"; Region = "EMEA"; SubRegion = "Europe"; PDL = "GBR"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "U.S. Outlying Islands"; ISO2 = "UM"; ISO3 = "UMI"; UNM49 = "581"; Region = "LATM"; SubRegion = "Australasia"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "United States"; ISO2 = "US"; ISO3 = "USA"; UNM49 = "840"; Region = "AMER"; SubRegion = "North America"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Uruguay"; ISO2 = "UY"; ISO3 = "URY"; UNM49 = "858"; Region = "LATM"; SubRegion = "South America"; PDL = "BRA"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Uzbekistan"; ISO2 = "UZ"; ISO3 = "UZB"; UNM49 = "860"; Region = "APAC"; SubRegion = "Asia Central"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Vanuatu"; ISO2 = "VU"; ISO3 = "VUT"; UNM49 = "548"; Region = "APAC"; SubRegion = "Australasia"; PDL = "AUS"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Venezuela"; ISO2 = "VE"; ISO3 = "VEN"; UNM49 = "862"; Region = "LATM"; SubRegion = "South America"; PDL = "BRA"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Vietnam"; ISO2 = "VN"; ISO3 = "VNM"; UNM49 = "704"; Region = "APAC"; SubRegion = "Asia East"; PDL = "APC"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "U.S. Virgin Islands"; ISO2 = "VI"; ISO3 = "VIR"; UNM49 = "850"; Region = "LATM"; SubRegion = "Carribean"; PDL = "NAM"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Wallis and Futuna"; ISO2 = "WF"; ISO3 = "WLF"; UNM49 = "876"; Region = "APAC"; SubRegion = "Australasia"; PDL = "AUS"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Yemen"; ISO2 = "YE"; ISO3 = "YEM"; UNM49 = "887"; Region = "APAC"; SubRegion = "Asia West"; PDL = "ARE"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Zambia"; ISO2 = "ZM"; ISO3 = "ZMB"; UNM49 = "894"; Region = "EMEA"; SubRegion = "Africa East"; PDL = "ZAF"}) |Out-Null
$CountryCodes.Add([PSCustomObject]@{ Country = "Zimbabwe"; ISO2 = "ZW"; ISO3 = "ZWE"; UNM49 = "716"; Region = "EMEA"; SubRegion = "Africa East"; PDL = "ZAF"}) |Out-Null
return $CountryCodes
}

function Get-RegionFromCulture {
$RegionData = New-Object -TypeName System.Collections.ArrayList;
$SpecificCultures = [System.Globalization.CultureInfo]::GetCultures([System.Globalization.CultureTypes]::SpecificCultures)
$SpecificCultures |
    ForEach-Object {
        $Current = New-Object System.Globalization.RegionInfo $_.Name -ErrorAction SilentlyContinue
        if ( $Current.TwoLetterISORegionName.Length -ge 1 ){
        $RegionData += [PSCustomObject]@{
            LanguageName = $Current.Name
            CountryEnglishName = $Current.EnglishName
            CountryDisplayName = $Current.DisplayName
            CountryNativeName  = $Current.NativeName
            ISO2 = $Current.TwoLetterISORegionName
            ISO3 = $Current.ThreeLetterISORegionName
            WIN3 = $Current.ThreeLetterWindowsRegionName
            IsMetric  = $Current.IsMetric
            GeoId = $Current.GeoId
            CurrencyEnglishName = $Current.CurrencyEnglishName
            CurrencyNativeName = $Current.CurrencyNativeName
            CurrencySymbol = $Current.CurrencySymbol
            ISOCurrencySymbol = $Current.ISOCurrencySymbol
            }
        }
    }
return $RegionData
}


function Get-RegionInfo {
$RegionData2 = New-Object -TypeName System.Collections.ArrayList;
$RegionDataFromCulture = Get-RegionFromCulture
$RegionDataFromO365 = Get-O365RegionData
$CountrySelection = ($RegionDataFromCulture | Where-Object {$_.ISO2.Length -eq 2} | Group-Object ISO2 | Sort-Object Name)
$CountrySelection | ForEach-Object {
    $CurrentCountry = $_
    $Merge = $null; $Merge = $RegionDataFromO365 | Where-Object { $_.ISO2 -eq  $CurrentCountry.Name  }
    $EnglishName = $null; $EnglishName = $CurrentCountry.Group[0].CountryEnglishName
    $NativeName = $null; $NativeName = (($CurrentCountry.Group | Where-Object { $_.CountryNativeName -ne $EnglishName } | Select-Object CountryNativeName -Unique).CountryNativeName -join ", ")
    $FullName = $null; if ( [string]::IsNullOrWhiteSpace($NativeName) ) { $FullName = $EnglishName; $NativeName = $EnglishName } else { $FullName = $EnglishName + "  (" + $NativeName + ")" }
    $CurrencyEnglishName = $null; $CurrencyEnglishName =  ($CurrentCountry.Group.CurrencyEnglishName | Select-Object -Unique) -join "; "
    $CurrencyNativeName = $null; $CurrencyNativeName = (($CurrentCountry.Group | Where-Object { $_.CurrencyNativeName -ne ($CurrentCountry.Group.CurrencyEnglishName | Select-Object -Unique) } | Select-Object CurrencyNativeName -Unique -First 1).CurrencyNativeName -join ", ");  if ( [string]::IsNullOrWhiteSpace($CurrencyNativeName) ) { $CurrencyNativeName = $CurrencyEnglishName }
        $RegionData2 += [PSCustomObject]@{
            EnglishName = $EnglishName
            NativeName = $NativeName
            FullName = $FullName
            ISO2 = $CurrentCountry.Name
            ISO3 = $CurrentCountry.Group[0].ISO3
            UNM49 = $Merge.UNM49
            PDL = $Merge.PDL
            Region = $Merge.Region
            SubRegion = $Merge.SubRegion
            MSWin3 = $CurrentCountry.Group[0].WIN3
            MSGeoID = ($CurrentCountry.Group.GeoId | Select-Object -Unique) -join "; "
            CurrencyEnglishName = $CurrencyEnglishName
            CurrencyNativeName =  $CurrencyNativeName
            CurrencySymbol = ($CurrentCountry.Group.CurrencySymbol | Select-Object -Unique) -join "; "
            ISOCurrencySymbol = ($CurrentCountry.Group.ISOCurrencySymbol | Select-Object -Unique) -join "; "
            }

    }
return $RegionData2
}
