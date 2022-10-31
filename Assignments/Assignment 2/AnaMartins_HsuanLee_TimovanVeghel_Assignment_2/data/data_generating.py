import requests
import json

from pandas.io.json import json_normalize
 
url = "https://imdb-api.com/API/AdvancedSearch/k_vg4dpwb1?title=a&title_type=feature&count=250&sort=alpha,asc"

payload = {}
headers= {}
 
response = requests.request("GET", url, headers=headers, data = payload)

todos = json.loads(response.text)

df = json_normalize(todos, 'results')
df.to_csv("output.csv", index=False, sep='\t', encoding="utf-8")

print(todos)
 
while open("data.json", "w").write(response.text):
    print("Data saved to file")
    break
#print(response.text.encode('utf8'))