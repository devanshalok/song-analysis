# Song Analysis

**Song Analysis** is an R-based application that analyzes the mood of a song and predicts its potential success using machine learning. By leveraging the Million Song Dataset (MSD), this project evaluates various song characteristics and uses multiple models to determine whether a new song has the qualities to become a hit or is likely to underperform.

## Project Overview

The success of a song can be influenced by multiple factors, including tempo, energy, danceability, and more. This project applies machine learning to analyze these factors and predict the success rate of a song before its release. This tool is valuable for artists, producers, and record labels to get an early indication of a song’s potential reception.

## Features

- **Mood Analysis**: Analyzes the emotional tone and mood of the song based on multiple audio features.
- **Success Prediction**: Runs various machine learning models to predict the likelihood of a song becoming a hit.
- **Data-Driven Insights**: Utilizes patterns from the Million Song Dataset to inform predictions.

## Getting Started

To set up and run this project on your local machine, follow these instructions.

### Prerequisites

You’ll need the following installed on your machine:

- **R** (v3.6 or higher)
- **RStudio** (optional but recommended)
- R packages: `tidyverse`, `caret`, `e1071`, `randomForest`, and `dplyr`

### Dataset

The project uses the **Million Song Dataset (MSD)**, which provides detailed information on song characteristics. Please download and configure the dataset according to the project instructions.

### Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/devanshalok/song-analysis.git
   cd song-analysis
   ```

2. **Install Required R Packages**

   Open R or RStudio and run the following commands to install necessary packages:

   ```R
   install.packages(c("tidyverse", "caret", "e1071", "randomForest", "dplyr"))
   ```

3. **Load Dataset**

   Place the Million Song Dataset (MSD) in the designated directory and load it in the R environment as per the provided instructions.

## Project Structure

- **data/**: Contains the Million Song Dataset (or reference to load it from a specified path).
- **scripts/**: R scripts for data processing, feature extraction, model training, and prediction.
- **results/**: Output files and visualizations of analysis results.

## Usage

1. **Preprocess Data**: Run the preprocessing script to clean and format the data.

   ```R
   source("scripts/preprocess_data.R")
   ```

2. **Run Mood Analysis**: Analyze the mood of a new song based on its audio features.

   ```R
   source("scripts/mood_analysis.R")
   ```

3. **Predict Success Rate**: Predict the success rate of a song using various machine learning models.

   ```R
   source("scripts/predict_success.R")
   ```

   The script will output a success likelihood score, indicating if the song is predicted to be a hit or a flop.

## Machine Learning Models

The project uses multiple machine learning models to evaluate the song’s success potential:

- **Logistic Regression**: For binary classification of song success.
- **Random Forest**: For handling complex interactions among song features.
- **Support Vector Machine (SVM)**: For high-dimensional feature space analysis.
- **Naive Bayes**: For probabilistic success prediction based on feature distribution.

These models are trained and tested on the Million Song Dataset and use various song attributes (e.g., tempo, loudness, energy) as input features.

## Results and Evaluation

The accuracy of each model is assessed using cross-validation. The best-performing model is used for final success prediction.

### Sample Results

Example predictions based on input data:

- **Song A**: Success Probability - 78% (Likely Hit)
- **Song B**: Success Probability - 35% (Likely Flop)
- **Song C**: Success Probability - 92% (Likely Hit)

## Built With

- **R** - Programming language for statistical computing
- **Million Song Dataset (MSD)** - Data source for song attributes and success metrics
- **R packages** - Tidyverse, Caret, e1071, RandomForest, dplyr for data processing and modeling

## Contributing

Contributions are welcome! Please see the `CONTRIBUTING.md` file for guidelines on how to submit issues and pull requests.

## Authors

- **Devansh Alok** - Initial work - [devanshalok](https://github.com/devanshalok)

## License

This project is licensed under the MIT License - see the `LICENSE.md` file for details.

## Acknowledgments

- Special thanks to the providers of the Million Song Dataset (MSD).
- Inspiration from data-driven music analysis and predictive modeling in entertainment.
- Gratitude to the R community for useful packages and resources.
