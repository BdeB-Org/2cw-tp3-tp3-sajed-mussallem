// index.js
document.addEventListener('DOMContentLoaded', () => {
    fetchLivres();
});

function fetchLivres() {
    fetch('/api/livres')
        .then(response => response.json())
        .then(data => populateLivresTable(data))
        .catch(error => console.error('Erreur lors de la récupération des livres:', error));
}

function populateLivresTable(livres) {
    const tableBody = document.getElementById('livresTable').getElementsByTagName('tbody')[0];
    livres.forEach(livre => {
        const row = tableBody.insertRow();
        row.insertCell(0).textContent = livre.titre;
        row.insertCell(1).textContent = livre.auteur;
        row.insertCell(2).textContent = livre.genre;
        row.insertCell(3).textContent = livre.date_publication;
        const actionCell = row.insertCell(4);
        const borrowButton = document.createElement('button');
        borrowButton.textContent = 'Emprunter';
        borrowButton.onclick = () => emprunterLivre(livre.id);
        actionCell.appendChild(borrowButton);
    });
}

function emprunterLivre(livreId) {
    fetch('/api/emprunter', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ livre_id: livreId })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Livre emprunté avec succès');
        } else {
            alert('Erreur lors de l'emprunt du livre');
        }
    })
    .catch(error => console.error('Erreur lors de l'emprunt du livre:', error));
}
