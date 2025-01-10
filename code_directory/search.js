document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('search-button');
    form.addEventListener('click', function(event) {
        event.preventDefault();
        const query = document.getElementById('search-input').value;
        if (query.trim() !== "") {
            searchPapers(query);
        } else {
            alert("Please enter a search query.");
        }
    });

    document.getElementById("refresh-button").addEventListener("click", function() {
        window.location.reload();
    });

    function searchPapers(query) {
        const apiUrl = `https://api.crossref.org/works?query=${encodeURIComponent(query)}`;

        fetch(apiUrl)
            .then(response => response.json())
            .then(data => {
                displaySearchResults(data.message.items);
            })
            .catch(error => {
                console.error('Error fetching data:', error);
                displayError('Error fetching data. Please try again later.');
            });
    }

    function displaySearchResults(items) {
        const resultsContainer = document.getElementById("results-container");
        resultsContainer.innerHTML = ""; // Clear previous results

        if (items.length === 0) {
            resultsContainer.innerHTML = '<p>No results found.</p>';
            return;
        }

        items.forEach(item => {
            const title = item.title ? item.title[0] : 'No title available';
            const authors = item.author ? item.author.map(author => author.family).join(', ') : 'No authors available';
            const publicationDate = item.published && item.published['date-parts'] ? item.published['date-parts'][0].join('-') : 'No date available';
            const link = item.URL ? `<a href="${item.URL}" target="_blank">Read more</a>` : 'No link available';

            const resultItem = document.createElement('div');
            resultItem.classList.add('article');
            resultItem.innerHTML = `
                <h3>${title}</h3>
                <p><strong>Authors:</strong> ${authors}</p>
                <p><strong>Publication Date:</strong> ${publicationDate}</p>
                <p>${link}</p>
            `;
            resultsContainer.appendChild(resultItem);
        });
    }

    function displayError(errorMessage) {
        const resultsContainer = document.getElementById("results-container");
        resultsContainer.innerHTML = `<p>${errorMessage}</p>`;
    }
});
