import requests
import csv
import json
 
first = True

api_key = "k_awpz8wnu"

# set up
<<<<<<< HEAD
genres = ['action', 'comedy', 'family', 'history', 'mystery', 'sci-fi', 'war', 'adventure', 'crime', 'fantasy', 'horror', 'news', 'sport',
'western', 'animation', 'documentary', 'film-noir', 'music', 'reality-tv', 'talk-show', 'biography', 'drama', 'game-show', 'musical', 'romance',
'thriller']
=======
genres = ["action", "adventure", "animation", "biography", "comedy", "crime", "documentary", "drama", "family", "fantasy", "film-noir", "game-show", "history", "horror", "music", "musical", "mystery", "news", "reality-tv", "romance", "sci-fi", "sport", "talk-show", "thriller", "war", "western"]
>>>>>>> 63d77259f9295a4be9ee2a8d8344c46aa0485b43
asc = True
data_file = open('movie_data.csv', 'a', encoding="utf-8")
csv_writer = csv.writer(data_file)
api_key = "k_opudepox"

for genre in genres:
    print(genre)
    for i in range(0, 2):
        if asc:
<<<<<<< HEAD
            url = "https://imdb-api.com/API/AdvancedSearch/" + api_key + "?&title_type=feature&count=1000&sort=alpha,asc&moviemeter=60,240&genres=" + genre
            asc = False
        else:
            url = "https://imdb-api.com/API/AdvancedSearch/" + api_key + "?&title_type=feature&count=1000&sort=alpha,desc&moviemeter=60,240&genres=" + genre
=======
            url = "https://imdb-api.com/API/AdvancedSearch/" + api_key + "?title_type=feature&genres=" + genre + "&count=250&sort=alpha,asc&moviemeter=60,"
            asc = False
        else:
            url = "https://imdb-api.com/API/AdvancedSearch/" + api_key + "?title_type=feature&genres=" + genre + "&count=250&sort=alpha,desc&moviemeter=60,"
>>>>>>> 63d77259f9295a4be9ee2a8d8344c46aa0485b43
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
