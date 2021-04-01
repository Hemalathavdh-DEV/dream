require "pry"
namespace :newspaper_hindu do
  task :pdf_parser => :environment do
  	$citiesOfIndia = ["Mumbai","Maharashtra","Delhi","Bangalore","Karnataka","Hyderabad","Telangana","Ahmedabad","Gujarat","Chennai","Tamil Nadu","TamilNadu","Kolkata","Bengal","West Bengal","Surat","Pune","Jaipur","Rajasthan","Lucknow","Uttar Pradesh","Kanpur","Nagpur","Indore","Madhya Pradesh","Thane","Bhopal","Visakhapatnam","Andhra Pradesh","Pimpri-Chinchwad","Patna","Bihar","Vadodara","Ghaziabad","Ludhiana","Punjab","Agra","Nashik","Ranchi","Jharkhand","Faridabad","Haryana","Meerut","Rajkot","Kalyan-Dombivli","Vasai-Virar","Varanasi","Srinagar","Jammu and Kashmir","Aurangabad","Dhanbad","Amritsar","Navi Mumbai","Allahabad""Howrah","Gwalior","Jabalpur","Coimbatore","Vijayawada","Vijayawad","Jodhpur","Madurai","Raipur","Chhattisgarh","Kota","Chandigarh","Guwahati","Assam","Solapur","Hubli–Dharwad","Mysore""Tiruchirappalli","Bareilly","Aligarh","Tiruppur","Gurgaon","Moradabad","Jalandhar","Bhubaneswar","Odisha","Salem","Warangal","Mira-Bhayandar","Jalgaon","Guntur","Thiruvananthapuram","Kerala","Bhiwandi","Saharanpur","Gorakhpur","Bikaner","Amravati","Noida","Jamshedpur","Bhilai","Cuttack","Firozabad","Kochi","Nellore","Bhavnagar","Dehradun","Uttarakhand","Durgapur","Asansol","Rourkela","Nanded","Kolhapur","Ajmer","Akola","Gulbarga","Jamnagar","Ujjain","Loni","Siliguri","Jhansi","Ulhasnagar","Jammu","Sangli-Miraj & Kupwad","Mangalore","Erode","Belgaum","Ambattur","Tirunelveli","Malegaon","Gaya","Udaipur","Kakinada","Davanagere","Kozhikode","Maheshtala","Rajpur Sonarpur","Rajahmundry","Bokaro","South Dumdum","Bellary","Patiala","Gopalpur","Agartala","Tripura","Bhagalpur","Muzaffarnagar","Bhatpara","Panihati","Latur","Dhule","Tirupati","Rohtak","Sagar","Korba","Bhilwara","Berhampur","Muzaffarpur","Ahmednagar","Mathura","Kollam","Avadi","Kadapa","Kamarhati","Sambalpur","Bilaspur","Shahjahanpur","Satara","Bijapur","Kurnool","Rampur","Shimoga","Chandrapur","Junagadh","Thrissur","Alwar","Bardhaman","Kulti","Nizamabad","Parbhani","Tumkur","Khammam","Ozhukarai","Puducherry","Bihar Sharif","Panipat","Darbhanga","Bally","Aizawl","Mizoram","Dewas","Ichalkaranji","Karnal","Bathinda","Jalna","Eluru","Barasat","Kirari Suleman Nagar","Purnia","Satna","Mau","Sonipat","Farrukhabad","Durg","Imphal","Manipur","Ratlam","Hapur","Arrah","Anantapur","Karimnagar","Etawah","Ambarnath","North Dumdum","Bharatpur","Begusarai","New Delhi","Gandhidham","Baranagar","Tiruvottiyur","Pondicherry","Sikar","Thoothukudi","Rewa","Mirzapur","Raichur","Pali","Ramagundam","Silchar","Haridwar","Vijayanagaram","Tenali","Nagercoil","Sri Ganganagar","Karawal Nagar","Mango","Thanjavur","Bulandshahr","Uluberia","Katni","Sambhal","Singrauli","Nadiad","Secunderabad","Naihati","Yamunanagar","Bidhannagar","Pallavaram","Bidar","Munger","Panchkula","Burhanpur","Raurkela Industrial Township","Kharagpur","Dindigul","Gandhinagar","Hospet","Nangloi Jat","Malda","Ongole","Deoghar","Chapra","Haldia","Khandwa","Nandyal","Morena","Amroha","Anand","Bhind","Bhalswa Jahangir Pur","Madhyamgram","Bhiwani","Berhampore","Ambala","Morbi","Fatehpur","Raebareli","Khora,haziabad","Chittoor","Bhusawal","Orai","Bahraich","Phusro","Vellore","Mehsana","Raiganj","Sirsa","Danapur","Serampore","Sultan Pur Majra","Guna","Jaunpur","Panvel","Shivpuri","Surendranagar Dudhrej","Unnao","Chinsurah","Alappuzha","Kottayam","Machilipatnam","Shimla","Himachal Pradesh","Adoni","Udupi","Katihar","Proddatur","Mahbubnagar","Saharsa","Dibrugarh","Jorhat","Hazaribagh","Hindupur","Nagaon","Sasaram","Hajipur","Giridih","Bhimavaram","Kumbakonam","Bongaigaon","Dehri","Madanapalle","Siwan","Bettiah","Ramgarh","Tinsukia","Guntakal","Srikakulam","Motihari","Dharmavaram","Medininagar","Gudivada","Phagwara","Pudukkottai","Hosur","Narasaraopet","Suryapet","Miryalaguda","Tadipatri","Karaikudi","Kishanganj","Jamalpur","Ballia","Kavali","Tadepalligudem","Amaravati","Buxar","Tezpur","Jehanabad","Gangtok","Sikkim"]
  	reader = PDF::Reader.new("/home/hp/Downloads/The_Hindu_05_Dec_2020.pdf")
	# puts reader.page(1).text
	result = fetch_cities(reader.page(1).text)
	puts result
  end
end

def fetch_cities(txt)
	fetcher = EngTagger.new
	tagged = fetcher.add_tags(txt)
	binding.pry
	words_list = fetcher.get_words(txt)
	readable = fetcher.get_readable(txt)
	proper_nouns = fetcher.get_proper_nouns(tagged)
	cities = matching_cities(proper_nouns.keys)
	return cities
end

def matching_cities(fetched_result)
	comparison_one = fetched_result.join("00").gsub(/[[:punct:]]/, '').split("00").map{|a| a.downcase}
	comparison_two = $citiesOfIndia.map{|a| a.downcase}
	comparison_one & comparison_two
end

