import requests
import csv
import json
 
first = True

api_key = "k_awpz8wnu"

# set up
genres = ["action", "adventure", "animation", "biography", "comedy", "crime", "documentary", "drama", "family", "fantasy", "film-noir", "game-show", "history", "horror", "music", "musical", "mystery", "news", "reality-tv", "romance", "sci-fi", "sport", "talk-show", "thriller", "war", "western"]
asc = True
data_file = open('movie_data.csv', 'a', encoding="utf-8")
csv_writer = csv.writer(data_file)
api_key = "k_waqdtpx9"

for genre in genres:
    for i in range(0, 2):
        if asc:
            url = "https://imdb-api.com/API/AdvancedSearch/" + api_key + "?title_type=feature&genres=" + genre + "&count=250&sort=alpha,asc&moviemeter=60,&num_votes=25000,"
            asc = False
        else:
            url = "https://imdb-api.com/API/AdvancedSearch/" + api_key + "?title_type=feature&genres=" + genre + "&count=250&sort=alpha,desc&moviemeter=60,&num_votes=25000,"
            asc = True

        response = requests.request("GET", url)
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
