import requests
import csv
import json

data_file = open('data_file.csv', 'w')
 
count = True

# set up
alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
asc = True
data_file = open('data_file.csv', 'a')
csv_writer = csv.writer(data_file)

for letter in alphabet:
    for i in range(0, 2):
        if asc:
            url = "https://imdb-api.com/API/AdvancedSearch/k_vg4dpwb1?title=" + letter + "a&title_type=feature&count=250&sort=alpha,asc"
            asc = False
        else:
            url = "https://imdb-api.com/API/AdvancedSearch/k_vg4dpwb1?title=" + letter + "a&title_type=feature&count=250&sort=alpha,desc"
            asc = True

        response = requests.request("GET", url)
        data = json.loads(response.text)

        movies = data['results']

        for movie in movies:
            if count:
        
                # Writing headers of CSV file
                header = movie.keys()
                csv_writer.writerow(header)
                count = False
        
            # Writing data of CSV file
            if movie.values() != None:
                csv_writer.writerow(movie.values())
