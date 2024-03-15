# Treasure Hunt Game API

The Treasure Hunt Game API is a Ruby on Rails application designed to offer an engaging gaming experience where users guess the location of hidden treasure. Featuring geolocation and token-based authentication, this API facilitates user registration, submission of guesses, and displays a leaderboard of winners.

## Features

- **User Authentication:** Secure signup and login using Devise with JWT for token-based access.
- **Guess Submission:** Users can submit guesses for the treasure's location, with the system calculating the proximity to the actual treasure.
- **Winner Identification:** Identifies winners based on their guesses being within 1000 meters of the treasure.
- **Leaderboard:** Retrieves a list of winners sorted by their distance from the treasure, with support for sorting and pagination.

## Technology Stack

- **Framework:** Ruby on Rails 7.1.2
- **Database:** PostgreSQL
- **Authentication:** Devise with JWT for secure API access
- **Geolocation:** Geocoder for calculating distances
- **Server:** Puma

## Getting Started

Ensure the following are installed:

- Ruby version 3.1.0
- Rails version 7.1.2
- PostgreSQL server

## Setup

1. **Clone the repository:**

```bash
git clone <repository-url>
```

2. **Navigate to the project directory:**

```bash
cd treasure_hunt_game
```

3. **Install dependencies:**

```bash
bundle install
```

4. **Setup environment variables:**
5. **Initialize the database:**

```bash
rails db:create db:migrate
```

6. **Start the Rails server:**

```bash
rails server
```

The API will now be accessible at **http://localhost:3000**.

# API Endpoints

- **POST http://localhost:3000/sign_up:** Register a new user.
- **POST http://localhost:3000/sign_in:** Log in and receive a JWT.
- **POST http://localhost:3000/api/v1/winners:** Submit a guess. Requires JWT authentication.
- **GET http://localhost:3000/api/v1/winners:** List winners, with options for sorting and pagination.
