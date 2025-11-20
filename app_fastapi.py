from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
import joblib

# Load the trained model
model = joblib.load("concrete_strength_model.joblib")

# Initialize FastAPI app
app = FastAPI(
    title="Concrete Strength Prediction API",
    description="API to predict compressive strength of concrete using a trained Linear Regression model",
    version="1.0.0"
)

# Enable CORS for all origins (can restrict later if needed)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Input data model with type checks, ranges, and Swagger UI examples
class ConcreteInput(BaseModel):
    cement: float = Field(..., gt=0, example=300, description="Amount of cement (kg/m3)")
    water: float = Field(..., gt=0, example=180, description="Amount of water (kg/m3)")
    superplasticizer: float = Field(..., ge=0, example=5, description="Amount of superplasticizer (kg/m3)")
    coarse_aggregate: float = Field(..., gt=0, example=1000, description="Amount of coarse aggregate (kg/m3)")
    fine_aggregate: float = Field(..., gt=0, example=800, description="Amount of fine aggregate (kg/m3)")
    age: int = Field(..., gt=0, example=28, description="Age of concrete (days)")
    embodied_CO2: float = Field(..., ge=0, example=300, description="Embodied CO2 of concrete (kg)")
    energy_consumption: float = Field(..., ge=0, example=500, description="Energy consumption (MJ)")
    resource_consumption: float = Field(..., ge=0, example=200, description="Resource consumption (kg)")

# Root endpoint for simple testing
@app.get("/")
def read_root():
    return {"message": "Concrete Strength Prediction API is running!"}

# Prediction endpoint
@app.post("/predict")
def predict_concrete_strength(input_data: ConcreteInput):
    features = [
        input_data.cement,
        input_data.water,
        input_data.superplasticizer,
        input_data.coarse_aggregate,
        input_data.fine_aggregate,
        input_data.age,
        input_data.embodied_CO2,
        input_data.energy_consumption,
        input_data.resource_consumption
    ]
    prediction = model.predict([features])[0]
    return {"predicted_compressive_strength": prediction}