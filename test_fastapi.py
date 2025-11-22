import requests

# The API URL
url = "http://127.0.0.1:5050/predict"

# Sample input data (replace with real values if needed)
data = {
    "cement": 300.0,
    "water": 180.0,
    "superplasticizer": 5.0,
    "coarse_aggregate": 1000.0,
    "fine_aggregate": 800.0,
    "age": 28,
    "embodied_CO2": 150.0,
    "energy_consumption": 200.0,
    "resource_consumption": 120.0
}

# Send POST request
response = requests.post(url, json=data)

# Print response
print(response.json())