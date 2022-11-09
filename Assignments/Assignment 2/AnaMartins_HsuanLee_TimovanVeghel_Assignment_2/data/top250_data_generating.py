import requests
import csv
import json

data_file = open('top250_data.csv', 'a', encoding="utf-8")
csv_writer = csv.writer(data_file)
api_key = "k_opudepox"

url = "https://imdb-api.com/en/API/Top250Movies/" + api_key
response = requests.request("GET", url)
print(response.text)
data = json.loads(response.text)
movies = data['items']

first = True

for movie in movies:
    if first:
        header = movie.keys()
        csv_writer.writerow(header)
        first = False
    if movie.values() != None:
        csv_writer.writerow(movie.values())