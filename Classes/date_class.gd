class_name Date
extends Node

#NOTE: dates in month/day/year format
var dateDictionary := {}
var dateFormat := "%s/%s/%s"
static var daysInMonth := {
	"1" : 31,
	"2" : 28,
	"3" : 31,
	"4" : 30,
	"5" : 31,
	"6" : 30,
	"7" : 31,
	"8" : 31,
	"9" : 30,
	"10" : 31,
	"11" : 30,
	"12" : 31
}

func _init(date := Time.get_datetime_dict_from_system()):
	dateDictionary = date
	is_leap_year(dateDictionary["year"])

#region Setup Functions
func assign_weekly_dates(arrayOfNames := [], month := 0, day := 0, year := 0):
	var dateString := []
	for n in range(arrayOfNames.size()):
		day += 7
		if day > daysInMonth[str(month)]:
			day = day - daysInMonth[str(month)]
			month += 1
			if month > 12:
				month = 1
				year += 1
		dateString.append(dateFormat % [month, day, year])
	return dateString

func check_date(date := {}):
	var initialDate := ""
	if date["weekday"] != Time.WEEKDAY_SATURDAY:
		date["day"] += Time.WEEKDAY_SATURDAY - date["weekday"]
	initialDate = dateFormat % [date["month"], date["day"], date["year"]]
	return initialDate

func get_date_data_as_integers(date := ""):
	var month = int(date.get_slice("/", 0))
	var day = int(date.get_slice("/", 1))
	var year = int(date.get_slice("/", 2))
	return {"month" : month, "day" : day, "year" : year}

func is_leap_year(year := 0):
	if year % 4 != 0:
		daysInMonth["2"] = 28
	else:
		daysInMonth["2"] = 29
#endregion

func get_formatted_dates(nameArray := []):
	var dateData = get_date_data_as_integers(check_date(dateDictionary))
	var formattedDates = "\n".join(
		assign_weekly_dates(
				nameArray,
				dateData["month"],
				dateData["day"],
				dateData["year"]
			)
		)
	return formattedDates
