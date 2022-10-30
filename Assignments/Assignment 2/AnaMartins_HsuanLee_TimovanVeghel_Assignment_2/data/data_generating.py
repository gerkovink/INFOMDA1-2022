import requests
 
url = "https://imdb-api.com/API/AdvancedSearch/k_vg4dpwb1?title_type=feature"

payload = {}
headers= {}
 
response = requests.request("GET", url, headers=headers, data = payload)
 
while open("data.json", "w").write(response.text):
    print("Data saved to file")
    break
print(response.text.encode('utf8'))