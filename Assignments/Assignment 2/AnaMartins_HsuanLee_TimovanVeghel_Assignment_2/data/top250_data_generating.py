import requests
import csv
import json

data_file = open('movie_data.csv', 'a')
csv_writer = csv.writer(data_file)

url = "https://imdb-api.com/en/API/Top250Movies/k_vg4dpwb1"
response = requests.request("GET", url)
data = json.loads(response.text)
movies = data['results']

first = True

for movie in movies:
    if first:
        header = movie.keys()
        csv_writer.writerow(header)
        first = False
    if movie.values() != None:
        csv_writer.writerow(movie.values())