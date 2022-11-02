import requests
import csv
import json
 
first = True

# set up
alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
asc = True
data_file = open('movie_data.csv', 'a')
csv_writer = csv.writer(data_file)

for letter in alphabet:
    for i in range(0, 2):
        if asc:
            url = "https://imdb-api.com/API/AdvancedSearch/k_opudepox?title=" + letter + "&title_type=feature&count=250&sort=alpha,asc&moviemeter=60,240"
            asc = False
        else:
            url = "https://imdb-api.com/API/AdvancedSearch/k_opudepox?title=" + letter + "&title_type=feature&count=250&sort=alpha,desc&moviemeter=60,240"
            asc = True

        response = requests.request("GET", url)
        print(response.text)
        data = json.loads(response.text)

        movies = data['results']

        for movie in movies:
            if first:
        
                # Writing headers of CSV file
                header = movie.keys()
                csv_writer.writerow(header)
                first = False
        
            # Writing data of CSV file
            if movie.values() != None:
                csv_writer.writerow(movie.values())
