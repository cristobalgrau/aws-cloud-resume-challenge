// Javascript code for views counter
// ----------------------------------

// Selects the HTML element with the class 'counter-number'
const counter = document.querySelector(".counter-number");

// Function to update the counter
function updateCounter() {
    // Makes an HTTP GET request to the provided AWS API Gateway
    fetch("https://t5wnb4ated.execute-api.us-east-1.amazonaws.com/resume/views")
        // Handles the response by converting the response body to JSON format
        .then(response => response.json())
        .then(data => {
            // Updates the content of the HTML element with the retrieved data
            counter.innerHTML = ` Views: ${data}`;
        })
        // Catches and handles any errors that may occur during the request or data processing
        .catch(error => {
            console.error('Error fetching data:', error);
        });
}

// Calls the function to update the counter when the page loads
updateCounter();
