#!/usr/bin/env nu

let table = (cat /etc/environment.d/50-weather-secrets.conf 
    | lines 
    | each {split row "="} 
    | each { {key: $in.0, value: $in.1} } 
    | transpose -r -d)
let lat = $table | (get WEATHER_LOCATION | split row "," | get 0)
let lon = $table | (get WEATHER_LOCATION | split row "," | get 1)
let API_KEY = $table | (get WEATHER_API_KEY)
let values = (http get $"https://api.openweathermap.org/data/2.5/weather?lat=($lat)&lon=($lon)&appid=($API_KEY)&units=imperial")


let temp = $values | get main | get temp | math round
let name = $values | get name
let real_feel = $values | get main | get feels_like | math round
let weather = ($values | get weather)
let id = ($weather | get id)
let status = ($weather | get description | first)
let humidity = ($values | get main | get humidity)
def get_weather_icon [code: string] {
    match $code {
        "01d" => "☀️",
        "01n" => "🌙",
        "02d" => "🌤️",
        "02n" => "☁️",
        "03d" | "03n" => "☁️",
        "04d" | "04n" => "☁️",
        "09d" | "09n" => "🌧️",
        "10d" => "🌦️",
        "10n" => "🌧️",
        "11d" | "11n" => "⛈️",
        "13d" | "13n" => "❄️",
        "50d" | "50n" => "🌫️",
        _ => "🌡️"
    }
}

let icon = (get_weather_icon ($weather | get icon | first))
let output = {
  text : $"($icon) ($temp)°F"
  tooltip : $"($name): ($status) - ($real_feel)°F"
}

print ($output | to json -r)
# print ($values | get main)
